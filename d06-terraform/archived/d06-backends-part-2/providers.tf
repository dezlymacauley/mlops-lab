terraform {

  required_version = "1.16.5"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.69.0"
    }

    random = {
      source  = "hashicorp/random",
      version = "3.9.1"
    }

  }

  backend "s3" {

  }

}

provider "aws" {
  region = "eu-north-1"
}
