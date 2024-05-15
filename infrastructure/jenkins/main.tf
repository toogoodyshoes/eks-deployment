provider "aws" {
  region = "ap-south-1"
}

module "jenkins" {
  source = "./modules/jenkins"
}
