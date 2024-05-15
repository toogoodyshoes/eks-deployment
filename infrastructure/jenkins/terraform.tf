terraform {
  cloud {
    organization = "nile_org"
    workspaces {
      name = "eks-deployment-jenkins"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.46.0"
    }
  }
}