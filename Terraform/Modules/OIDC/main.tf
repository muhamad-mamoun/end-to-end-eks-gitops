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

resource "aws_iam_role" "eks-ecr-access-role" {
  name = "eks-ecr-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Action    = "sts:AssumeRoleWithWebIdentity",
      Principal = { Federated = aws_iam_openid_connect_provider.oidc-provider.arn },
      Condition = { StringEquals = { "${replace(aws_iam_openid_connect_provider.oidc-provider.url, "https://", "")}:sub" = "system:serviceaccount:jenkins:aws-ecr-access-sa" } }
    }]
  })
}

resource "aws_iam_role_policy" "eks-ecr-access-policy" {
  name = "eks-ecr-access-policy"
  role = aws_iam_role.eks-ecr-access-role.id

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
