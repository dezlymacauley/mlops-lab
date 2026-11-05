# This is how to get the list of availibilty zones in a region
# It will get the availibilty zones specified in the providers block
data "aws_availability_zones" "azs" {
  state = "available"
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

  name = "demo-vpc"

  # List all the availibity zones
  azs = data.aws_availability_zones.azs.names

  # This gives the VPC the IP address range:
  # 10.0.0.0 to 10.0.255.255 (65,536 IP addresses in total)
  cidr = "10.0.0.0/16"

  # This subnet has a range of:
  # 10.0.0.0 to 10.0.0.255 (256 IP addresses in total)
  private_subnets = ["10.0.0.0/24"]

  # This subnet has a range of: 
  # 10.0.128.0 to 10.0.128.255 (256 IP addresses in total)
  public_subnets = ["10.0.128.0/24"]

  # This is also valid
  # private_subnets = ["10.0.1.0/24"]
  # public_subnets  = ["10.0.2.0/24"]

}

# NOTE: Updating versions.tf

# So terraform init -upgrade is used when you update a version in 
# your f01_versions.tf file (after terraform init has already been run)

#______________________________________________________________________________
