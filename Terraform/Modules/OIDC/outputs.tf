output "eks-ebs-csi-role-arn" {
  value = aws_iam_role.eks-ebs-csi-role.arn
}

output "eks-ecr-write-role-arn" {
  value = aws_iam_role.eks-ecr-write-role.arn
}

output "eks-ecr-read-role-arn" {
  value = aws_iam_role.eks-ecr-read-role.arn
}

output "aws-sm-read-role-arn" {
  value = aws_iam_role.aws-sm-read-role.arn
}
