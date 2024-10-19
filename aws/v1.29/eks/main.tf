
data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}


data "aws_iam_policy" "ebs_csi_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

data "aws_vpc" "selected" {
  tags = {
    #Name = "${var.pipeops_workspace}-vpc"
    Name = "${var.cluster_name}"
  }
}

data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  tags = {
    "kubernetes.io/role/internal-elb" = "1"
    "subnet"                          = "private"
    "karpenter.sh/discovery"          = "${var.cluster_name}"
  }
}

data "aws_subnets" "intra_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  tags = {
    "Name" = "${var.cluster_name}"
  }
}



locals {
  sanitized_kubernetes_version = replace(var.eks_version, "v", "")
}

/*
module "ebs_csi_irsa_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name             = "${var.cluster_name}-driver"
  attach_ebs_csi_policy = true
  policy_name_prefix    = var.cluster_name

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }
}


module "cluster_autoscaler_irsa_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name                        = "${var.cluster_name}-cluster-autoscaler"
  attach_cluster_autoscaler_policy = true
  cluster_autoscaler_cluster_names = [module.eks.cluster_name]
  policy_name_prefix               = var.cluster_name

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:cluster-autoscaler"]
    }
  }
  tags = {
    Owner = var.pipeops_workspace
    Name  = var.cluster_name
  }
}

resource "aws_iam_policy" "cluster_autoscaler_policy" {
  name        = "${var.cluster_name}-cluster-autoscaler-policy"
  description = "Policy for EKS Cluster Autoscaler"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:DescribeTags",
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup",
          "ec2:DescribeLaunchTemplateVersions"
        ],
        Resource = "*"
      }
    ]
  })
}

*/


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.24.0"

  cluster_name    = var.cluster_name
  cluster_version = local.sanitized_kubernetes_version
  cluster_endpoint_public_access           = true

  # Enable IRSA
  enable_irsa = true

  cluster_addons = {
    vpc-cni = {
      most_recent = true
      resolve_conflicts  = "OVERWRITE"
      before_compute = true
      configuration_values = jsonencode({
        env = {
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
    }

    coredns = {
      preserve    = true
      most_recent = true
      resolve_conflicts        = "OVERWRITE"
      timeouts = {
        create = "25m"
        delete = "10m"
      }
    }

    eks-pod-identity-agent = {
      most_recent = true
      resolve_conflicts        = "OVERWRITE"
    }

    kube-proxy = {
      most_recent = true
      resolve_conflicts        = "OVERWRITE"
    }

    aws-ebs-csi-driver = {
      most_recent              = true
      resolve_conflicts        = "OVERWRITE"
      service_account_role_arn = module.ebs_csi_irsa_role.iam_role_arn
      configuration_values = jsonencode({
        controller = {
          extraVolumeTags = {
            "Encrypted" = "true"
          }
        }
      })
    }
  }

  vpc_id                         = data.aws_vpc.selected.id
  subnet_ids                     = data.aws_subnets.private_subnets.ids
  control_plane_subnet_ids       = data.aws_subnets.intra_subnets.ids

  

  eks_managed_node_groups = {
    /*
    one = {
      name                     = "${var.cluster_name}-ng"
      subnet_ids               = data.aws_subnets.private_subnets.ids
      instance_types           = var.eks_instance_class
      ami_type        = var.ami_type
      min_size                 = var.eks_min_node
      max_size                 = var.eks_max_node
      desired_size             = var.eks_cluster_desired_node
      disk_size                = var.eks_cluster_storage
     */
     
     karpenter = {
      name            = "${var.cluster_name}-ng"
      subnet_ids      = data.aws_subnets.private_subnets.ids
      instance_types  = var.eks_instance_class
      ami_type        = var.ami_type
      min_size        = var.eks_min_node
      max_size        = var.eks_max_node
      desired_size    = var.eks_cluster_desired_node
      disk_size       = var.eks_cluster_storage
      create_iam_role = true

      iam_role_use_name_prefix = true
      iam_role_name            = "${var.cluster_name}-role"
      iam_role_description     = "EKS managed node group role for Karpenter"
 

      labels = {
        "karpenter.sh/controller" = "true"
      }

      taints = {
        addons = {
          key    = "CriticalAddonsOnly"
          value  = "true"
          effect = "NO_SCHEDULE"
        }
      }
    }
  }

  node_security_group_tags = {
    "Name"                   = var.cluster_name
    "karpenter.sh/discovery" = var.cluster_name
    "pipeops.io/cluster"     = "${var.cluster_name}"
    "Environment"            = "production"
    "Terraform"              = "true"
    "ManagedBy"              = "pipeops.io"
    "DateCreated"            = formatdate("YYYY-MM-DD", timestamp())
  }

  tags = {
    "Name"                   = var.cluster_name
    "karpenter.sh/discovery" = var.cluster_name
    "pipeops.io/cluster"     = "${var.cluster_name}"
    "Environment"            = "production"
    "Terraform"              = "true"
    "ManagedBy"              = "pipeops.io"
    "DateCreated"            = formatdate("YYYY-MM-DD", timestamp())
  }
}


module "eks_auth" {
  source = "aidanmelen/eks-auth/aws"
  eks    = module.eks

  map_roles = [
    {
      rolearn  = "arn:aws:iam::682321774018:role/KarpenterIRSA-${var.cluster_name}"
      username = "system:node:{{EC2PrivateDNSName}}"
      groups = [
        "system:bootstrappers",
        "system:nodes",
      ]
    },
  ]
 
  map_users = var.map_users

}
