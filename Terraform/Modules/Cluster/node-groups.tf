resource "aws_eks_node_group" "main-node-group" {
  node_group_name = "main-node-group"
  cluster_name    = aws_eks_cluster.main-cluster.name
  node_role_arn   = var.eks-worker-nodes-role-arn
  subnet_ids      = var.eks-subents-ids

  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.medium"]
  labels         = { type = "on-demand" }

  remote_access {
    ec2_ssh_key               = var.worker-nodes-key-name
    source_security_group_ids = [var.eks-worker-nodes-sg-id]
  }

  scaling_config {
    desired_size = 3
    max_size     = 5
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}
