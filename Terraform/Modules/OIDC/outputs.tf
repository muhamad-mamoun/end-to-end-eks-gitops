output "eks-ebs-csi-role-arn" {
  value = aws_iam_role.eks-ebs-csi-role.arn
}

output "eks-ecr-access-role-arn" {
  value = aws_iam_role.eks-ecr-access-role.arn
}
