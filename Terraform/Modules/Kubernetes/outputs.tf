output "jenkins-namespace" {
  value = kubernetes_namespace.jenkins-namespace.metadata[0].name
}

output "prometheus-namespace" {
  value = kubernetes_namespace.prometheus-namespace.metadata[0].name
}
