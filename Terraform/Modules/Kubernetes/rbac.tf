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
    name      = "aws-ecr-write-sa"
    namespace = kubernetes_namespace.jenkins-namespace.metadata[0].name
    annotations = {
      "eks.amazonaws.com/role-arn" = var.eks-ecr-write-role-arn
    }
  }
}

resource "kubernetes_service_account" "aws-ecr-read-sa" {
  metadata {
    name      = "aws-ecr-read-sa"
    namespace = var.argocd-namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = var.eks-ecr-read-role-arn
    }
  }
}
