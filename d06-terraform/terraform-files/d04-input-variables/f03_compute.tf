/*
  ABOUT: f03_compute.tf

  _____________________________________________________________________________

  NOTE: Virtual Computer
  
  This file tells Terraform to create
  a virtual computer (aka virtual machine, VM, or virtual server).

  The type of virtual computer in this file is called an AWS EC2 instance.
  _____________________________________________________________________________
  
  NOTE: AWS EC2

  EC2 is AWS’s service for renting virtual computers.
  And an EC2 instance is one rented virtual computer that is running on
  the AWS platform.

  Each EC2 instance will be given its own virtual disk
  (storage space that holds the operating system, software, and files).

  This disk will start off empty.
  _____________________________________________________________________________

  NOTE: AMI

  That virtual computer needs an operating system.
  The operating system in this file is Linux, specifically Ubuntu 22.04

  To get the operating system onto the virtual computer,
  Terraform needs to tell AWS which AMI (Amazon Machine Image) to use.

  An AMI is a disk that already has a specific operating system
  installed on it. This means AWS does not need to download and install
  the operating system every time it needs to create a new virtual computer.

  All AWS needs to do is copy the contents of the AMI onto
  the new virtual computer’s empty disk.

  Because Ubuntu is already installed in the AMI,
  nothing needs to be installed after the copy.

  AWS just starts the virtual computer, which loads the Ubuntu that is
  already on its disk. AWS will perform a few setup tasks when starting
  that virtual computer for the first time.

  _____________________________________________________________________________

*/

# This is a `data` block. 
# A data block is used when you want Terraform to retrieve some information
# that was not created in this Terraform files
# E.g. An AMI (Amazon Machine Image)

# `ubuntu` is a name of my choosing that I'm using to store 
# the results of the search so that I can use those results in another section
# of this file.
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
