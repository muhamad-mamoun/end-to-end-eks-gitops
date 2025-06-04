output "cluster-name" {
  value = aws_eks_cluster.main-cluster.name
}

output "cluster-endpoint" {
  value = aws_eks_cluster.main-cluster.endpoint
}

output "cluster-certificate" {
  value = aws_eks_cluster.main-cluster.certificate_authority[0].data
}

output "eks-iodc-provider" {
  value = aws_eks_cluster.main-cluster.identity[0].oidc[0].issuer
}
