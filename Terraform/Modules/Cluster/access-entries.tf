resource "aws_eks_access_entry" "bastion-access-entry" {
  cluster_name      = aws_eks_cluster.main-cluster.name
  principal_arn     = var.bastion-server-role-arn
  kubernetes_groups = ["masters"]
  type              = "STANDARD"
}
