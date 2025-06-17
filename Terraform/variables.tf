variable "aws-profile" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc-cidr" {
  type = string
}

variable "public-subnets" {
  type = list(object({
    name = string
    cidr = string
    zone = string
  }))
}

variable "private-subnets" {
  type = list(object({
    name = string
    cidr = string
    zone = string
  }))
}

variable "nat-gw-subnet-name" {
  type = string
}

variable "bastion-server-subnet-name" {
  type = string
}

variable "bastion-server-ami-id" {
  type = string
}

variable "admin-public-ip" {
  type = string
}

variable "ecr-repositories" {
  type = set(string)
}

variable "backend-jwt-secret" {
  type = string
}

variable "database-root-password" {
  type = string
}

variable "database-username" {
  type = string
}

variable "database-password" {
  type = string
}

variable "jenkins-username" {
  type = string
}

variable "jenkins-password" {
  type = string
}

variable "jenkins-volume-id" {
  type = string
}

variable "jenkins-ebs-zone" {
  type = string
}

variable "application-namespace" {
  type = string
}

variable "prometheus-namespace" {
  type = string
}

variable "application-volume-id" {
  type = string
}

variable "argocd-hashed-password" {
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

variable "prometheus-volume-id" {
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
