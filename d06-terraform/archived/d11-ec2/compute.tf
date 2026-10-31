/* 
    I got the `ami` from this link:
    https://cloud-images.ubuntu.com/locator/ec2/

    Here are the details of the instance that I selected:
    Zone:           eu-north-1 
    Name:           Noble Numbat
    Version:        24.04 LTS
    Arch:           amd64
    Instance Type:  hvm:ebs-ssd-gp3
    Release:        20261004
    AMI-ID:         ami-09d835910a77f135c
    AKI-ID:         hvm

    You'd get this from AWS console
  */

//____________________________________________________________________________

// NOTE: If you only want to delete this resource without deleting the
// rest of your infastructure. Run this command.

// Method 1: Comment out the resource, then run `terraform apply`

// Method 2: Run this command:
// `terraform destroy -target=aws_instance.web_ec2`

//____________________________________________________________________________

resource "aws_instance" "web_ec2" {

  tags = {
    Name = "${local.project_name}: web_ec2"
  }

  subnet_id = aws_subnet.public_subnet.id

  ami = "ami-09d835910a77f135c"

  instance_type = "t3.micro"

  associate_public_ip_address = true

  // NOTE: This is how to add the security group to the instance
  vpc_security_group_ids = [aws_security_group.public_http_traffic_security_group.id]

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }

}

resource "aws_security_group" "public_http_traffic_security_group" {

  tags = {
    Name = "${local.project_name}: public_http_traffic_security_group"
  }

  description = "Security group allowing traffic on ports 443 and 80"
  name        = "public_http_traffic_security_group"
  vpc_id      = aws_vpc.main_vpc.id

}


resource "aws_vpc_security_group_ingress_rule" "http_security_group_rule" {

  tags = {
    Name = "${local.project_name}: http_security_group_rule"
  }

  security_group_id = aws_security_group.public_http_traffic_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "https_security_group_rule" {

  tags = {
    Name = "${local.project_name}: https_security_group_rule"
  }

  security_group_id = aws_security_group.public_http_traffic_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}
