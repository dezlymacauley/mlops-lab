/*
  ABOUT: f02_compute.tf

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
  The operating system in this file is Linux, specifically Ubuntu
  (the version is set by the `ubuntu_version` variable).

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
# that was not created in this Terraform file
# E.g. an AMI (Amazon Machine Image)

# `ubuntu` is a name of my choosing that I'm using to refer to
# the results of the search so that I can use those results in another section
# of this file.
data "aws_ami" "ubuntu" {

  # This tells Terraform to pick the most recent AMI if the search
  # returns multiple results
  most_recent = true

  # This is the AWS account ID of the account that owns the image
  # 099720109477 is the account ID of Canonical, the organisation behind
  # the Ubuntu operating system.
  # This limits the search to images published by Canonical.

  # I got this info from here:
  # https://ubuntu.com/aws/docs/aws-how-to/instances/find-ubuntu-images/#finding-images-for-ec2-and-eks
  # Click the tab `Using the AWS Console`
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd*/ubuntu-*-${var.ubuntu_version}-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = [var.architecture]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

#______________________________________________________________________________

output "aws_ec2_instance_type" {
  value = var.aws_ec2_instance_type
}

output "ubuntu_version" {
  value = var.ubuntu_version
}
#______________________________________________________________________________

output "ubuntu_ami_id" {
  value = data.aws_ami.ubuntu.id
}

output "ubuntu_ami_name" {
  value = data.aws_ami.ubuntu.name
}

output "ubuntu_ami_created" {
  value = data.aws_ami.ubuntu.creation_date
}

# NOTE: If you run `terraform apply -auto-approve`,
# you should get something like this back.
# The exact values will differ: the AMI ID depends on the region, and the
# build date changes whenever Canonical publishes a new image.

# instance_type = "t3.micro"
# ubuntu_ami_created = "2026-10-28T06:49:15.000Z"
# ubuntu_ami_id = "ami-0bfc5cae5711ffac8"
# ubuntu_ami_name = "ubuntu/images/hvm-ssd-gp3/ubuntu-resolute-26.04-amd64-server-20261028"
# ubuntu_version = "26.04"

#______________________________________________________________________________

resource "aws_instance" "ubuntu_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.aws_ec2_instance_type

  # Configure the storage settings for the virtual computer
  root_block_device {
    volume_size = var.aws_ec2_volume_size
    volume_type = var.aws_ec2_volume_type

    # Ensures that the storage is deleted when the EC2 instance is deleted
    delete_on_termination = true
  }

}
