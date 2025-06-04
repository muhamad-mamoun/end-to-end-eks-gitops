resource "aws_eks_addon" "kube-proxy-addon" {
  cluster_name = aws_eks_cluster.main-cluster.name
  addon_name   = "kube-proxy"
}

resource "aws_eks_addon" "vpc-cni-addon" {
  cluster_name = aws_eks_cluster.main-cluster.name
  addon_name   = "vpc-cni"
}

resource "aws_eks_addon" "coredns-addon" {
  cluster_name = aws_eks_cluster.main-cluster.name
  addon_name   = "coredns"

  depends_on = [aws_eks_node_group.main-node-group]
}

