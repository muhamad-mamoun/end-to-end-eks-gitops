# EKS Application Infrastructure with CI Pipeline

A complete Infrastructure as Code (IaC) solution for deploying a 3-tier application on Amazon EKS with CI pipeline using Jenkins.

## Architecture Overview

- **Infrastructure**: AWS EKS cluster with managed node groups
- **CI**: Jenkins on EKS for building container images
- **Registry**: Amazon ECR for container images
- **Networking**: VPC with public/private subnets and NAT Gateway
- **Security**: Bastion host for secure cluster access

## Prerequisites

1. AWS CLI configured with admin access
2. Terraform installed
3. kubectl installed
4. helm installed

## Quick Start

1. Clone this repository
2. Create `secrets.tfvars` in the Terraform directory with required values:
```hcl
aws-profile            = "your-aws-profile"
admin-public-ip        = "your-public-ip"
backend-jwt-secret     = "your-jwt-secret"
database-root-password = "db-root-pass"
database-password      = "db-pass"
database-username      = "db-user"
jenkins-username       = "jenkins-user"
jenkins-password       = "jenkins-pass"
```

3. Initialize and apply Terraform:
```bash
cd Terraform
terraform init
terraform apply -var-file="secrets.tfvars"
```

## Infrastructure Components

### Network Layer
- VPC with CIDR 10.0.0.0/16
- 3 public and 3 private subnets across different AZs
- NAT Gateway for private subnet internet access
- Security groups for EKS and bastion host

### EKS Cluster
- EKS version 1.32
- Managed node group with t3.medium instances
- EBS CSI driver for persistent storage
- AWS Load Balancer controller for ingress

### CI Pipeline
- Jenkins running on EKS with persistent storage
- Kaniko for secure container image building
- ECR repositories for frontend and backend images

### Application
- Pure Kubernetes manifests for the 3-tier application
- Persistent volumes for database
- Ingress configuration for external access

## Folder Structure

```
.
├── Terraform/           # Infrastructure as Code
├── Manifest/            # Application Helm Chart
└── Jenkinsfile          # Jenkins CI pipeline
```

## Security Features

- Private EKS API endpoint
- Bastion host for cluster access
- OIDC integration for pod IAM roles
- Network isolation with private subnets

## Usage

1. Access Jenkins UI:
```bash
kubectl get svc -n jenkins
```

2. Access the bastion host:
```bash
ssh -i ssh-key ubuntu@$(terraform output -raw bastion-server-public-ip)
```

## Application Deployment

Deploy the application using kubectl:
```bash
helm install ./Manifest -f Manifest/custom.yaml -n app --create-namespace
```

## Cleanup

To destroy all resources:
```bash
terraform destroy -var-file="secrets.tfvars"
```

## Contributing

Feel free to open issues and pull requests for improvements.
