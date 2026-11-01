# This Creates an AWS instance. This is the EC2 service on AWS
# I'm naming this AWS instance, `demo_instance`
resource "aws_instance" "demo_instance" {
  associate_public_ip_address = true

  # NOTE: I got the values below from the `EC2` menu of the AWS console

  # Username:                   ubuntu
  # Architecture:               64-bit (x86)
  # Creation date:              2026-10-16
  ami           = "ami-0d97d7f07b25dd693"
  instance_type = "t3.micro"

  root_block_device {
    delete_on_termination = true

    # NOTE: I got the values below from the `EC2` menu of the AWS console

    # Configure storage
    volume_size = 8     # 8 GiB
    volume_type = "gp3" # General Purpose SSD (gp3)
  }
}
