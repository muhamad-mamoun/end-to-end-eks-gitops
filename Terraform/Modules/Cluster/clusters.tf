resource "aws_eks_cluster" "main-cluster" {
  name = "main-cluster"

  bootstrap_self_managed_addons = false
  version                       = "1.32"
  role_arn                      = var.eks-control-plane-role-arn

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  remote_network_config {
    remote_node_networks {
      cidrs = ["172.16.0.0/18"]
    }
    remote_pod_networks {
      cidrs = ["172.16.64.0/18"]
    }
  }

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    subnet_ids              = var.eks-subents-ids
    security_group_ids      = [var.eks-control-plane-sg-id]
  }
}
