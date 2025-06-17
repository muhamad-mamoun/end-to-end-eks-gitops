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

variable "jenkins-ebs-zone" {
  type = string
}

variable "jenkins-username" {
  type = string
}

variable "jenkins-password" {
  type = string
}

variable "eks-ebs-csi-role-arn" {
  type = string
}

variable "argocd-hashed-password" {
  type = string
}

variable "ecr-registry-url" {
  type = string
}

variable "jenkins-namespace" {
  type = string
}

variable "prometheus-namespace" {
  type = string
}

variable "prometheus-username" {
  type = string
}

variable "prometheus-password" {
  type = string
}

variable "prometheus-ebs-zone" {
  type = string
}

variable "aws-sm-read-role-arn" {
  type = string
}
