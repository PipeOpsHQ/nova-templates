
module "karpenter" {
  source  = "terraform-aws-modules/eks/aws//modules/karpenter"
  version = "20.24.0"

  cluster_name = module.eks.cluster_name

  enable_v1_permissions = true

  enable_pod_identity             = true
  create_pod_identity_association = true


  # Used to attach additional IAM policies to the Karpenter node IAM role
  node_iam_role_additional_policies = {
    AmazonSSMManagedInstanceCore       = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    AmazonEKSWorkerNodePolicy          = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    AmazonEKS_CNI_Policy               = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  }

  tags = {
    "pipeops.io/cluster" = "${var.cluster_name}"
    Environment          = "production"
    Terraform            = "true"
    ManagedBy            = "pipeops.io"
    DateCreated          = formatdate("YYYY-MM-DD", timestamp())
  }

}

resource "helm_release" "karpenter" {
  namespace = "kube-system"

  name       = "karpenter"
  repository = "oci://public.ecr.aws/karpenter"
  repository_username = data.aws_ecrpublic_authorization_token.token.user_name
  repository_password = data.aws_ecrpublic_authorization_token.token.password
  chart      = "karpenter"
  version    = "1.0.6"
  wait       = true

  # Optional: Set this to true if you want to purge the release
  cleanup_on_fail = true

  # Optional: Set a timeout for the deletion process
  timeout = 600

  values = [
    <<-EOT
      replicas: 1
      serviceAccount:
        annotations:
          eks.amazonaws.com/role-arn: ${module.karpenter.node_iam_role_arn}
      settings:
        clusterName: ${module.eks.cluster_name}
        clusterEndpoint: ${module.eks.cluster_endpoint}
        interruptionQueue: ${module.karpenter.queue_name}
        featureGates:
          spotToSpotConsolidation: true
      tolerations:
        - key: "CriticalAddonsOnly"
          operator: "Equal"
          value: "true"
          effect: "NoSchedule"
    EOT
  ]

  depends_on = [module.eks, module.karpenter]
}

resource "kubectl_manifest" "karpenter_node_class" {
  yaml_body = <<-YAML
    apiVersion: karpenter.k8s.aws/v1beta1
    kind: EC2NodeClass
    metadata:
      name: pipss-default-node-class
      namespace: kube-system
      labels: 
        app.kubernetes.io/managed-by: "Helm"
      annotations:
        meta.helm.sh/release-name: "karpenter-crd"
        meta.helm.sh/release-namespace: "kube-system"    
    spec:
      template:
        metadata:
          labels: 
            app.kubernetes.io/managed-by: "Helm"
          annotations:
            meta.helm.sh/release-name: "karpenter-crd"
            meta.helm.sh/release-namespace: "kube-system"  
      amiFamily: AL2
      role: ${module.karpenter.node_iam_role_name}
      subnetSelectorTerms:
        - tags:
            karpenter.sh/discovery: ${module.eks.cluster_name}
            subnet: private
      securityGroupSelectorTerms:
        - tags:
            karpenter.sh/discovery: ${module.eks.cluster_name}
      tags:
        karpenter.sh/discovery: ${module.eks.cluster_name}

      blockDeviceMappings:
        - deviceName: /dev/xvda
          ebs:
            volumeSize: 50Gi
            volumeType: gp3
            deleteOnTermination: true
            encrypted: true
      detailedMonitoring: true
      metadataOptions:
        httpEndpoint: enabled
        httpProtocolIPv6: disabled
        httpPutResponseHopLimit: 2
        httpTokens: required
      userData: |
        MIME-Version: 1.0
        Content-Type: multipart/mixed; boundary="==BOUNDARY=="

        --==BOUNDARY==
        Content-Type: text/x-shellscript; charset="us-ascii"

        #!/bin/bash
        echo "Running custom user data script"
        # Add any additional initialization scripts here

        --==BOUNDARY==--
  YAML


  depends_on = [helm_release.karpenter]
}

resource "kubectl_manifest" "karpenter_node_pool" {
  yaml_body = <<-YAML
    apiVersion: karpenter.sh/v1beta1
    kind: NodePool
    metadata:
      name: pipeops-default-node-pool
      namespace: kube-system
    spec:
      template:
        metadata:
          # Labels are arbitrary key-values that are applied to all nodes
          labels:
            cluster-name: ${module.eks.cluster_name}

          # Annotations are arbitrary key-values that are applied to all nodes
          annotations:
            pipeops.io/cluster-name: ${module.eks.cluster_name}
        spec:
          nodeClassRef:
            name: pipss-default-node-class
            namespace: kube-system
          # Note: changing this value in the nodepool will drift the nodeclaims.
          expireAfter: 720h 
          # Note: changing this value in the nodepool will drift the nodeclaims.
          terminationGracePeriod: 48h
          requirements:
            - key: "karpenter.k8s.aws/instance-category"
              operator: In
              values: ["t", "m", "c"]
            - key: karpenter.k8s.aws/instance-size
              operator: In
              values: ["nano", "micro", "small", "medium"]
            - key: "karpenter.k8s.aws/instance-cpu"
              operator: In
              values: ["2", "4", "8", "16"]
            - key: "karpenter.k8s.aws/instance-generation"
              operator: Gt
              values: ["2"]
            - key: "karpenter.sh/capacity-type"
              operator: In
              values: ["on-demand", "spot"]
            - key: "kubernetes.io/arch"
              operator: In
              values: ["amd64"]
      limits:
        cpu: 100
      weight: 10
      disruption:
        consolidateAfter: 1m
        consolidationPolicy: WhenEmpty
        budgets:
          - nodes: 10%
          # On Weekdays during business hours, don't do any deprovisioning
          - schedule: "0 9 * * mon-fri"
            duration: 8h
            nodes: "1"
  YAML

  depends_on = [helm_release.karpenter, kubectl_manifest.karpenter_node_class]
}
