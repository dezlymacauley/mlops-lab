/*
  The `terraform` block is used to configure the Terraform project

  Only constants are allowed inside the Terraform block.

*/
terraform {

  // Sets the version of Terraform required for the project
  required_version = "1.16.5"

  // This is where you list the infastructure providers 
  // that you will be interacting with
  required_providers {

    aws = {
      source = "hashicorp/aws"

      // The `~>` Makes the rightmost digit flexible
      // So this means: 5.37.0, 5.37.1, 5.37.2 ... are valid
      // 5.38.0 or 6.38.0 will not be valid.
      version = "~> 5.37.0"
    }
  }

  // This is used to configure what backend will be used to store the state
  // of the project
  backend "s3" {
    
  }

}

/*
  The `resource` block is where you list the resources that you want 
  to create.

  The syntax is:

  resource "type_of_resource" "a custom label to identify this resource"

*/
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-sample-bucket"
}

// When you want to create a piece of AWS infastructure that is not managed
// by you. Managed somewhere else but you want to use it in your project
data "aws_s3_bucket" "my_external_bucket" {
  bucket = "not-managed-by-us"
}

//_____________________________________________________________________________

// SECTION: Variables

// Declaring a variable
variable "bucket_name" {
  type = string 
  description = "my variable used to set bucket name"
  default = "my_default_bucket_name"
}

// Using the variable
resource "aws_s3_bucket" "my_bucket2" {
  bucket = var.bucket_name
}

//_____________________________________________________________________________

// SECTION: Output

// This allows you to expose information to the outside world

output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}

//_____________________________________________________________________________

// SECTION: Locals

// This is used to set temporary variables

locals {
  local_example = "This is a local variable" 
}

resource "aws_vpc" "squirrel_app" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = local.local_example
    }
}

//_____________________________________________________________________________

// SECTION: Modules

// This is use whe you have a directory that contains some Terraform code
// that you want to import.

module "my_module" {
  source = "./module-example" 
}

//_____________________________________________________________________________
