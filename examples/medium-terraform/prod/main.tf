provider "aws" {
  region = "eu-west-1"

  allowed_account_ids = var.allowed_account_ids
}

terraform {
  backend "s3" {
    key = "medium-terraform/prod/terraform.tfstate"
    # ...
  }
}

module "network" {
  source = "../modules/network"

  name = var.name

  cidr = var.cidr
  azs  = var.azs

  public_subnets = var.public_subnets
}

module "alb" {
  source = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  #...
}