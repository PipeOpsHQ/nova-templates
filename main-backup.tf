#done
data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}


#  done, 
data "aws_vpc" "selected" {
  tags = {
    #Name = "${var.pipeops_workspace}-vpc"
    Name = "${var.cluster_name}"
    
  }
}

# done 
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

# done
data "aws_subnets" "intra_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  tags = {
    "Name" = "${var.cluster_name}"
  }
}

#done
locals {
  sanitized_kubernetes_version = replace(var.eks_version, "v", "")
}

#done
module "ebs_csi_irsa_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name_prefix      = "${var.cluster_name}-driver"
  attach_ebs_csi_policy = true


  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }
}
/* done
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

  cluster_name                             = var.cluster_name
  cluster_version                          = local.sanitized_kubernetes_version
  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  authentication_mode = "API_AND_CONFIG_MAP"

  # Enable IRSA
  enable_irsa = true

  #done
  cluster_addons = {
    coredns = {
      most_recent = true
    }
    eks-pod-identity-agent = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }

    vpc-cni = {
      most_recent    = true
      before_compute = true
      configuration_values = jsonencode({
        env = {
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
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

  #done
  vpc_id                   = data.aws_vpc.selected.id
  subnet_ids               = data.aws_subnets.private_subnets.ids
  control_plane_subnet_ids = data.aws_subnets.intra_subnets.ids

  /* done
  eks_managed_node_group_defaults = {
    # ami_type = "AL2_x86_64"
    iam_role_additional_policies = {
      "ClusterAutoscalerPolicy" = aws_iam_policy.cluster_autoscaler_policy.arn
    }
  }
  */

  eks_managed_node_groups = {
    one = {
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

      # Enable ECR access for node group
      iam_role_additional_policies = {
        AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
        AmazonEKSWorkerNodePolicy          = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
        AmazonEKS_CNI_Policy               = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
      }

      labels = {
        "karpenter.sh/controller" = "true"
      }

      taints = {
        addons = {
          key    = "CriticalAddonsOnly"
          value  = "true"
          effect = "NO_SCHEDULE"
        }
        /*iam_role_use_name_prefix = false
      tags = {
        "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
        "k8s.io/cluster-autoscaler/enabled"             = "true"
      }*/
      }
    }

    #done
    
    node_security_group_tags = {
      "Name"                   = var.cluster_name
      "karpenter.sh/discovery" = var.cluster_name
      "pipeops.io/cluster"     = "${var.cluster_name}"
      "Environment"            = "production"
      "Terraform"              = "true"
      "ManagedBy"              = "pipeops.io"
      "DateCreated"            = formatdate("YYYY-MM-DD", timestamp())
    }
    #done
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

}

# done
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
