output "ingress-namespace" {
  value = helm_release.ingress.namespace
}

output "jenkins-namespace" {
  value = helm_release.jenkins.namespace
}

output "argocd-namespace" {
  value = helm_release.argocd.namespace
}

output "eso-namespace" {
  value = helm_release.external-secret-operator.namespace
}
