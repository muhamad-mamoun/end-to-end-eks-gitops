resource "aws_iam_role" "bastion-server-role" {
  name = "bastion-server-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Principal = { Service = "ec2.amazonaws.com" }
      },
    ]
  })
}

resource "aws_iam_role_policy" "describe-eks-policy" {
  name = "describe-eks-policy"
  role = aws_iam_role.bastion-server-role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["eks:DescribeCluster"]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = ["sts:GetCallerIdentity"]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "eks-control-plane-role" {
  name = "eks-control-plane-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Principal = { Service = "eks.amazonaws.com" }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks-control-plane-policy" {
  for_each = {
    "1" = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "2" = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController",
  }

  role       = aws_iam_role.eks-control-plane-role.name
  policy_arn = each.value
}

resource "aws_iam_role" "eks-worker-nodes-role" {
  name = "eks-worker-nodes-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Principal = { Service = "ec2.amazonaws.com" }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks-worker-nodes-policy" {
  for_each = {
    "1" : "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "2" : "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "3" : "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  }

  role       = aws_iam_role.eks-worker-nodes-role.name
  policy_arn = each.value
}
