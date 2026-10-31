/*
  _____________________________________________________________________________
  
  ABOUT: VPC

  Think of AWS as one giant landscape that is used by multiple AWS customers.
  A VPC is your own section of land on AWS, that is isolated from other AWS
  customers.

  VPC stands for virtual private network. 
  A VPC is an isolated network on AWS, where you can place your AWS resources,
  and control how those resources communicate with each other,
  and which resources you want to make publically available.
  _____________________________________________________________________________
  
  ABOUT: CIDR Block

  This defines the range of private IP addresses available inside your VPC.

  The syntax is:

  number.number.number.number/number

  Here's an example of a CIDR block

  0.0.0.0/16

  The first numbers are the network address. 
  So `0.0.0.0` is the network address. 

  What are acceptable values for those numbers?

  Each of those numbers must be between 0 and 255 (inclusive).

  This is because each of those numbers is stored as 8 bits.
  8 bits can represent 256 different numbers. 0 to 255 inclusive.


  Examples of valid ipv4 addresses:
  10.0.0.0
  10.0.0.1
  10.0.0.25
  10.0.0.255
  10.0.1.0
  192.168.1.10
  _____________________________________________________________________________

  The number after the slash is called the `CIDR prefix length` 

  So the `16` in `0.0.0.0/16` is the CIDR prefix length

  What are acceptable values?

  Any whole number from 0 to 32

  The larger the CIDR prefix, the smaller the number of addresses the network
  will have.

  10.0.0.0/32	
    -> This means only 1 available ipv4 address

  10.0.0.0/0 
   -> This means 4,294,967,296 available ip addresses
   -> Anything that is an ipv4 addresses is valid on the network

  Those two are extremes.
  _____________________________________________________________________________

  10.0.0.0/8 
    -> This means 16,777,216 addresses	
    -> This is a very large network

  10.0.0.0/16	
    -> This mean 65,536 available ipv4 addresses
    -> This is a Large network

  10.0.0.0/24
    -> This mean 256 available ipv4 addresses
    -> This is a Small network

  _____________________________________________________________________________
  
  You'd normally choose a CIDR block of 16

  Then you'd have a sub network inside of that that is 24

  A sub network (aka a subnet) is a smaller network inside your VPC.

  This is useful for when your want to create section inside your VPC.
  _____________________________________________________________________________

*/

// This is how you create local variables in Terraform
locals {
  shared_tags = {
    ManagedBy   = "terraform"
    ProjectName = "purple-rose"
    CostCenter  = "1234"
  }
}

resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  // NOTE: The tag `Name` must be called that.
  // This is what AWS and Floci (Local Cloud) will use as the resource name
  // in their respective User Interfaces
  
  tags = merge(
    local.shared_tags,
    { Name = "${local.shared_tags.ProjectName}: main_vpc" }
  )

  /*
      If you had to manually write out `tags`,
      it would look like this:

      tags = {
        ManagedBy    = "terraform"
        ProjectName  = "purple-rose"
        ResourceName = "purple-rose: main_vpc"
      }
    */
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.0.0/24"

  tags = merge(
    local.shared_tags,
    { Name = "${local.shared_tags.ProjectName}: public_subnet" }
  )

}

// Ingress and egress traffic
// Sending data to the public internet and accepting data from the public
// internet.
resource "aws_internet_gateway" "main_internet_gateway" {
  vpc_id = aws_vpc.main_vpc.id

  tags = merge(
    local.shared_tags,
    { Name = "${local.shared_tags.ProjectName}: main_internet_gateway" }
  )
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_internet_gateway.id
  }

  tags = merge(
    local.shared_tags,
    { Name = "${local.shared_tags.ProjectName}: public_route_table" }
  )

}

resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
  // An `aws_route_table_association` does not support tags
}
