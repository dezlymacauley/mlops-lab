# Overview 
_______________________________________________________________________________

Make all the bash script in `.mise-tasks` executable
```bash
chmod u+x .mise-tasks/*.bash
```
_______________________________________________________________________________

Give mise permission to read the `mise.toml` file
```bash
mise trust
```
_______________________________________________________________________________

1. Deploy the VPC and a public subnet

2. Deploy an internet gateway and connect it to the VPC

3. Setup a route table with a route to the internet

4. Deploy an EC2 instance of the created subnet

5. Create a public IP and a security group that allows public ingress
_______________________________________________________________________________

### Infastructure Creation

_______________________________________________________________________________

Create a Terraform configuration file for the providers
```bash
touch providers.tf
```
_______________________________________________________________________________

Add this to the file
```terraform
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
}
```
_______________________________________________________________________________

Create a `networking.tf` file
```bash
touch networking.tf
```

Add this to the file
```terraform
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name      = "custom-project"
    ManagedBy = "terraform"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name      = "custom-project-public-subnet"
    ManagedBy = "terraform"
  }
}
```
_______________________________________________________________________________

Load 
```bash
source .env
```
_______________________________________________________________________________

Initialize Terraform
```bash
terraform init
```

#### Note: 
- This command will take a while because it needs to download the AWS plugin
for Terraform.
_______________________________________________________________________________

To check the Terraform version of your project and confirm the version of
AWS that you are using, run the following commands:

```bash
terraform version
```
_______________________________________________________________________________

Run this to see what will be created
```bash
terraform plan
```
_______________________________________________________________________________

Run this to create the infastructure on AWS 
```bash
terraform apply -auto-approve
```
_______________________________________________________________________________

When you are done, run this command
```bash
terraform destroy
```
_______________________________________________________________________________
