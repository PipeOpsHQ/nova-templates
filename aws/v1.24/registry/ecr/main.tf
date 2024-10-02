provider "aws" {
  region = "us-west-2"
}

resource "aws_ecr_repository" "ecr_repository" {
  name = var.eks_cluster_name

  image_tag_mutability = "IMMUTABLE" // Prevent accidental image updates

  image_scanning_configuration {
    scan_on_push = true // Enable image scanning on push
  }

  lifecycle_policy {
    // Delete images older than 30 days
    policy = jsonencode({
      rules = [
        {
          rulePriority = 1,
          description = "Delete old images",
          selection = {
            tagStatus = "any",
            countType = "sinceImagePushed",
            countUnit = "days",
            countNumber = 30
          },
          action = {
            type = "expire"
          }
        }
      ]
    })
  }
}

resource "aws_iam_user" "ecr_iam_user" {
  name = var.eks_cluster_name + "-registry-auth"

  tags = {
    workspace = var.workspace
    region = var.aws_region
    cluster_name = var.eks_cluster_name
  }
}

resource "aws_iam_access_key" "ecr_iam_access_key" {
  user = aws_iam_user.ecr_iam_user.name

  // Enable rotation of access keys for better security
  lifecycle {
    prevent_destroy = true // Prevent accidental deletion of access keys
  }
}

resource "aws_iam_user_policy_attachment" "example" {
  user       = aws_iam_user.ecr_iam_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"

  // Use least privilege principle and only attach policies that are needed
}

