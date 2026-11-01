# SECTION: VPC and Internet Gateway

resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo_vpc.id
}
#______________________________________________________________________________

# SECTION: Subnets

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.demo_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.demo_vpc.id
  cidr_block = "10.0.0.0/24"
}
#______________________________________________________________________________

# SECTION: Route Table

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    gateway_id = aws_internet_gateway.igw.id
    cidr_block = "0.0.0.0/0"
  }
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id =  aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rtb.id
}
#______________________________________________________________________________
