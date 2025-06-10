resource "kubernetes_ingress_v1" "jenkins-ingress" {
  metadata {
    name      = "jenkins-ingress"
    namespace = kubernetes_namespace.jenkins-namespace.metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class"           = "nginx"
      "nginx.ingress.kubernetes.io/use-regex" = "true"
    }
  }

  spec {
    rule {
      http {
        path {
          path      = "/jenkins"
          path_type = "Prefix"

          backend {
            service {
              name = "jenkins"
              port { number = 8080 }
            }
          }
        }
      }
    }
  }
}
