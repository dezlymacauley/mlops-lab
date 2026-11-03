/*
  ABOUT: f03_compute.tf

  _____________________________________________________________________________
  
  This file tells Terraform to create 
  a virtual computer (aka virtual machine, VM, or virtual server).

  The type of virtual computer in this file is called an AWS EC2 instance. 

  EC2 is AWS’s service for renting virtual computers. 
  And an EC2 instance is one rented virtual computer that is running on
  the AWS platform.
  _____________________________________________________________________________

  That virtual computer needs an operating system. 
  The operating system in this file is Linux, specifically `Ubuntu 22.04`

  To get the operating system onto the virtual computer, 
  Terraform tells AWS which AMI (Amazon Machine Image) to use. 

  AWS then copies it onto the new computer’s disk and boots it.
  _____________________________________________________________________________
  

  _____________________________________________________________________________

*/

data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "compute" {
  ami = data.aws_ami.ubuntu 
}
