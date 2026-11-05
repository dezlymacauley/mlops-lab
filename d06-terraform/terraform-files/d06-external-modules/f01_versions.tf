terraform {
  required_version = "1.17.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.71.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

/*

  ABOUT: External Modules

  This module contains a collection of reusable terraform files 
  that contains all of the setup for the aws resources 
  that are needed to create a vpc manually. 

  The module allows you to change the default settings
*/



# `aws_vpc` is a custom name of your choosing to refer 
# to the external module that you intend to use
module "aws_vpc" {

  # https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.7.3"

  # NOTE: Dependency Requirements:
  # aws (hashicorp/aws) >= 6.28

}


# NOTE: Updating versions.tf

# So terraform init -upgrade is used when you update a version in 
# your f01_versions.tf file (after terraform init has already been run)
