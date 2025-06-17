variable "aws-profile" {
  type = string
}

variable "cluster-name" {
  type = string
}

variable "cluster-endpoint" {
  type = string
}

variable "cluster-certificate" {
  type = string
}

variable "eks-ecr-read-role-arn" {
  type = string
}

variable "eks-ecr-write-role-arn" {
  type = string
}

variable "aws-sm-read-role-arn" {
  type = string
}

variable "jenkins-volume-id" {
  type = string
}

variable "github-username" {
  type = string
}
variable "github-password" {
  type = string
}
variable "gitops-repo-url" {
  type = string
}

variable "ingress-namespace" {
  type = string
}

variable "argocd-namespace" {
  type = string
}

variable "application-namespace" {
  type = string
}

variable "prometheus-namespace" {
  type = string
}

variable "eso-namespace" {
  type = string
}

variable "application-volume-id" {
  type = string
}

variable "prometheus-volume-id" {
  type = string
}

variable "ecr-frontend-repo-url" {
  type = string
}

variable "ecr-backend-repo-url" {
  type = string
}
