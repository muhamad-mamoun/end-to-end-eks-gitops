resource "aws_iam_openid_connect_provider" "oidc-provider" {
  url             = var.eks-iodc-provider
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da0ecd6c7e2"]
}

resource "aws_iam_role" "eks-ebs-csi-role" {
  name = "eks-ebs-csi-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Action    = "sts:AssumeRoleWithWebIdentity",
      Principal = { Federated = aws_iam_openid_connect_provider.oidc-provider.arn },
      Condition = { StringEquals = { "${replace(aws_iam_openid_connect_provider.oidc-provider.url, "https://", "")}:sub" = "system:serviceaccount:kube-system:ebs-csi-controller-sa" } }
    }]
  })
}

resource "aws_iam_role_policy" "eks-ebs-csi-policy" {
  name = "eks-ebs-csi-policy"
  role = aws_iam_role.eks-ebs-csi-role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:AttachVolume",
          "ec2:CreateSnapshot",
          "ec2:CreateTags",
          "ec2:CreateVolume",
          "ec2:DeleteSnapshot",
          "ec2:DeleteTags",
          "ec2:DeleteVolume",
          "ec2:DescribeInstances",
          "ec2:DescribeSnapshots",
          "ec2:DescribeTags",
          "ec2:DescribeVolumes",
          "ec2:DescribeAvailabilityZones",
          "ec2:ModifyVolume",
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "eks-ecr-write-role" {
  name = "eks-ecr-write-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Action    = "sts:AssumeRoleWithWebIdentity",
      Principal = { Federated = aws_iam_openid_connect_provider.oidc-provider.arn },
      Condition = { StringEquals = { "${replace(aws_iam_openid_connect_provider.oidc-provider.url, "https://", "")}:sub" = "system:serviceaccount:jenkins:aws-ecr-write-sa" } }
    }]
  })
}

resource "aws_iam_role_policy" "eks-ecr-write-policy" {
  name = "eks-ecr-write-policy"
  role = aws_iam_role.eks-ecr-write-role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "ecr:GetAuthorizationToken"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "eks-ecr-read-role" {
  name = "eks-ecr-read-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Action    = "sts:AssumeRoleWithWebIdentity",
      Principal = { Federated = aws_iam_openid_connect_provider.oidc-provider.arn },
      Condition = { StringEquals = { "${replace(aws_iam_openid_connect_provider.oidc-provider.url, "https://", "")}:sub" = "system:serviceaccount:argocd:aws-ecr-read-sa" } }
    }]
  })
}

resource "aws_iam_role_policy" "eks-ecr-read-policy" {
  name = "eks-ecr-read-policy"
  role = aws_iam_role.eks-ecr-read-role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer",
          "ecr:DescribeImages",
          "ecr:ListImages",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:GetLifecyclePolicy",
          "ecr:GetLifecyclePolicyPreview",
          "ecr:ListTagsForResource",
          "ecr:DescribeImageScanFindings"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "aws-sm-read-role" {
  name = "aws-sm-read-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Action    = "sts:AssumeRoleWithWebIdentity",
      Principal = { Federated = aws_iam_openid_connect_provider.oidc-provider.arn },
      Condition = { StringEquals = { "${replace(aws_iam_openid_connect_provider.oidc-provider.url, "https://", "")}:sub" = "system:serviceaccount:eso:aws-sm-read-sa" } }
    }]
  })
}

resource "aws_iam_role_policy" "aws-sm-read-policy" {
  name = "aws-sm-read-policy"
  role = aws_iam_role.aws-sm-read-role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetRandomPassword",
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds",
          "secretsmanager:ListSecrets",
          "secretsmanager:BatchGetSecretValue"
        ]
        Resource = "*"
      }
    ]
  })
}
