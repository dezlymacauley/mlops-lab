terraform {
  required_version = "~> 1.16.5"
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.69.1"
    }

  }
}

provider "aws" {
  region = "eu-north-1"

  // NOTE: The advantage of this is that all resources created with this
  // provider will have these default tag.

  default_tags {
    tags = {
      ManagedBy   = "terraform"
      ProjectName = "purple-rose"
      CostCenter  = "1234"
    }
  }
}
