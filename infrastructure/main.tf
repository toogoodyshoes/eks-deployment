provider "aws" {
  region = "ap-south-1"
}

module "network" {
  source = "./modules/network"
}

module "eks_cluster" {
  source = "./modules/eks_cluster"

  private_subnet_1_id = module.network.private-subnet-1.id
  private_subnet_2_id = module.network.private-subnet-2.id
  public_subnet_1_id = module.network.public-subnet-1.id
  public_subnet_2_id = module.network.public-subnet-2.id
}
