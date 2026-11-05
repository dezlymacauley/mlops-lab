# SECTION: VPC and Internet Gateway

resource "aws_vpc" "demo_vpc" {

  tags = {
    Name = "demo_vpc"
  }

  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "demo_internet_gateway" {

  tags = {
    Name = "demo_internet_gateway"
  }

  vpc_id = aws_vpc.demo_vpc.id
}
#______________________________________________________________________________

# SECTION: Subnets

resource "aws_subnet" "private_subnet" {

  tags = {
    Name = "private_subnet"
  }

  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "public_subnet" {

  tags = {
    Name = "public_subnet"
  }

  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.0.0.0/24"
}
#______________________________________________________________________________

# SECTION: Route Table

resource "aws_route_table" "private_route_table" {

  tags = {
    Name = "public_route_table"
  }

  vpc_id = aws_vpc.demo_vpc.id

  route {
    gateway_id = aws_internet_gateway.demo_internet_gateway.id
    cidr_block = "0.0.0.0/0"
  }
}

/*
   NOTE: `aws_route_table_association` does not support `tags`

  This is because it doesn't create a resource.
  Its purpose is to declare a subnet is associated route table with
  a route table
*/

resource "aws_route_table_association" "private_subnet" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "public_subnet" {

  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}
#______________________________________________________________________________
