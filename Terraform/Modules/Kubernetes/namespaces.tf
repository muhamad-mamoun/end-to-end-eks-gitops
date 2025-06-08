resource "kubernetes_namespace" "ingress-namespace" {
  metadata { name = "ingress" }
}

resource "kubernetes_namespace" "jenkins-namespace" {
  metadata { name = "jenkins" }
}

resource "kubernetes_namespace" "argocd-namespace" {
  metadata { name = "argocd" }
}

resource "kubernetes_namespace" "application-namespace" {
  metadata { name = var.application-namespace }
}
