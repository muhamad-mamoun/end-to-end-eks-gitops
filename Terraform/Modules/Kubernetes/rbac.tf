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

resource "kubernetes_service_account" "aws-ecr-write-sa" {
  metadata {
    namespace = "jenkins"
    name      = "aws-ecr-write-sa"
    annotations = {
      "eks.amazonaws.com/role-arn" = var.eks-ecr-write-role-arn
    }
  }
}

resource "kubernetes_service_account" "aws-ecr-read-sa" {
  metadata {
    namespace = "argocd"
    name      = "aws-ecr-read-sa"
    annotations = {
      "eks.amazonaws.com/role-arn" = var.eks-ecr-read-role-arn
    }
  }
}
