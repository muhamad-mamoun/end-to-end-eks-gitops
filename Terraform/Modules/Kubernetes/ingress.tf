resource "kubernetes_ingress_v1" "jenkins-ingress" {
  metadata {
    namespace = "jenkins"
    name      = "jenkins-ingress"
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
