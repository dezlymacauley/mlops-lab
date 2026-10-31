/*
  
  ABOUT: Blocks

  A Terraform configuration is written inside a `.tf` file.

  The syntax inside the file is called `HCL`, 
  which stands for HashiCorp Configuration Language.

  The settings in this file are declared using blocks.

  This is the syntax of a block:

  the_type_of_thing_you_want_to_configure {
    the settings for that thing
  }

  The settings inside each block, are declared as key-value pairs.

  This is the syntax:
  key = "value"

*/

// This block is used to configure Terraform
terraform {

  // The version of Terraform required to run this file
  // The value "1.16.5",  means exactly version 1.16.5
  // The value ">= 1.16.5" means greater than or equal to 1.16.5

  // The value "~> 1.16.5" means that everything excluding the last number
  // should match. So something like 1.16.6, or 1.16.7 ... will be accepted
  // but something like 1.17.2 is unacceptable.
  required_version = "1.16.5"

  // `required_providers` is a nested block that goes inside the `terraform`
  // block. This block is used to list the providers that should
  // be downloaded for your project.

  // A provider is a plugin that tells Terraform how to interact with
  // a specific platform, so that you don't have to manually enter the
  // commands or API calls that are used for that specific platform.

  // This is one of the main advantages of Terraform.
  // It allows you to use the HCL syntax to communicate with a variety
  // of different platforms.
  required_providers {

    // For this example,
    // I want to interact with the platform AWS (Amazon Web Services)

    // You can search for the AWS plugin on the Terraform registry:
    // https://registry.terraform.io/providers/hashicorp/aws/latest

    // This link will also contain the values that you need for `source`
    // and `version`

    // The first step is to choose a name that you will use to refer
    // to this plugin throughout this file. I have chosen `aws`

    aws = {

      // The address of the plugin in the Terraform registry.
      // "hashicorp" is the publisher and "aws" is the plugin.
      source = "hashicorp/aws"

      // The version of that plugin that should be used
      version = "6.69.0"
    }

    // I'm adding another plugin that will allow Terraform to generate
    // random values. I'm using the name `random` to refer to the plugin
    random = {
      source  = "hashicorp/random",
      version = "3.9.1"
    }

  }

  backend "s3" {
    bucket = "terraform-state-for-d05-backends"
    key = "state.tfstate"

    // NOTE: The s3 bucket that contains the state file,
    // does not have to be in the same region.
    region = "eu-north-1"
    use_lockfile = true
  }

}

// This `provider` block is used to configure a provider (aka a pluin) 
// that you listed inside the Terraform block. You refer to the plugin using
// the name that you chose.
provider "aws" {

  // This tells Terraform to create all resources in this region when using
  // the `aws` plugin.
  // `eu-north-1` is Stockholm, Sweden
  region = "eu-north-1"
}
