resource "kubernetes_cluster_role_binding" "admins-role-binding" {
  metadata {
    name = "admins-role-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Group"
    name      = "masters"
  }
}

resource "kubernetes_service_account" "aws-ecr-access-sa" {
  metadata {
    namespace = "jenkins"
    name      = "aws-ecr-access-sa"
    annotations = {
      "eks.amazonaws.com/role-arn" = var.eks-ecr-access-role-arn
    }
  }
}
