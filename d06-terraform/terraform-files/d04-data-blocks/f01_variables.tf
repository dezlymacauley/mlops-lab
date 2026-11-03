/*
  ABOUT: variables

  This is how you set variables in Terraform
*/

variable "aws_ec2_instance_type" {
  type    = string
  default = "t3.micro"

  # How to add a variable type
  description = "The instance type of the AWS EC2 instance"

  validation {

    # Lists the valid options
    condition = contains(
      ["t3.micro", "t3.small"],
      var.aws_ec2_instance_type
    )

    error_message = <<-EOT
      Error: Invalid Instance Type

      Valid Instance Types:
      t3.micro
      t3.small
    EOT
  }

}

variable "architecture" {
  type    = string
  default = "x86_64"
}

variable "ubuntu_version" {
  type    = string
  default = "26.04"
}

variable "aws_ec2_volume_size" {
  type        = number
  default     = 8
  description = "The volume size in GIB of the EC2 instance"
}

variable "aws_ec2_volume_type" {
  type    = string
  default = "gp3"
}
