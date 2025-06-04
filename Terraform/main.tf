module "identity" {
  source = "./Modules/Identity"
}

module "security" {
  source                 = "./Modules/Security"
  backend-jwt-secret     = var.backend-jwt-secret
  database-root-password = var.database-root-password
  database-username      = var.database-username
  database-password      = var.database-password
  jenkins-username       = var.jenkins-username
  jenkins-password       = var.jenkins-password
}

module "network" {
  source             = "./Modules/Network"
  vpc-cidr           = var.vpc-cidr
  public-subnets     = var.public-subnets
  private-subnets    = var.private-subnets
  nat-gw-subnet-name = var.nat-gw-subnet-name
  admin-public-ip    = var.admin-public-ip
}

module "compute" {
  source                               = "./Modules/Compute"
  bastion-server-ami-id                = var.bastion-server-ami-id
  bastion-server-instance-profile-name = module.identity.bastion-server-instance-profile-name
  bastion-server-subnet-id             = module.network.public-subnets["${var.bastion-server-subnet-name}"].id
  bastion-server-key-name              = module.security.bastion-server-key-name
  bastion-server-sg-id                 = module.network.bastion-server-sg-id
}

module "registry" {
  source           = "./Modules/Registry"
  ecr-repositories = var.ecr-repositories
}

module "cluster" {
  source                     = "./Modules/Cluster"
  eks-subents-ids            = [for subnet in module.network.private-subnets : subnet.id]
  eks-control-plane-role-arn = module.identity.eks-control-plane-role.arn
  eks-worker-nodes-role-arn  = module.identity.eks-worker-nodes-role.arn
  bastion-server-role-arn    = module.identity.bastion-server-role.arn
  eks-control-plane-sg-id    = module.network.control-plane-sg-id
  eks-worker-nodes-sg-id     = module.network.worker-nodes-sg-id
  worker-nodes-key-name      = module.security.bastion-server-key-name

  depends_on = [module.identity]
}

module "kubernetes" {
  source                  = "./Modules/Kubernetes"
  aws-profile             = var.aws-profile
  cluster-certificate     = module.cluster.cluster-certificate
  cluster-endpoint        = module.cluster.cluster-endpoint
  cluster-name            = module.cluster.cluster-name
  eks-ecr-access-role-arn = module.open-id-connect.eks-ecr-access-role-arn
}

module "open-id-connect" {
  source            = "./Modules/OIDC"
  eks-iodc-provider = module.cluster.eks-iodc-provider
}

module "helm" {
  source               = "./Modules/Helm"
  aws-profile          = var.aws-profile
  eks-ebs-csi-role-arn = module.open-id-connect.eks-ebs-csi-role-arn
  cluster-certificate  = module.cluster.cluster-certificate
  cluster-endpoint     = module.cluster.cluster-endpoint
  cluster-name         = module.cluster.cluster-name
  jenkins-custom-pvc   = module.kubernetes.jenkins-custom-pvc
  jenkins-ebs-zone     = var.jenkins-ebs-zone
  jenkins-username     = var.jenkins-username
  jenkins-password     = var.jenkins-password
}

resource "null_resource" "kubeconfig" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --profile ${var.aws-profile} --region ${var.region} --name ${module.cluster.cluster-name}"
  }
}
