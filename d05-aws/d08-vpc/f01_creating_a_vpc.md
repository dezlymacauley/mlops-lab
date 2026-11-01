# Creating a VPC 
_______________________________________________________________________________

## Creating a VPC (Virtual Private Cloud)

What are VPCs?

They are partions of AWS infastructure, where you can deploy resources,
and ensure that they are logically isolated from other AWS customers.

This VPC will contain two subnets:
1. A subnet that will have public access to the internet.
2. A private subnet
_______________________________________________________________________________

Login to your AWS account and ensure that you set it to the correct region.

E.g. `us-east-1` aka United States (N.Virginia)
_______________________________________________________________________________

Search for the `VPC` service, then one the left sidebar click `Your VPCs`

You should see a VPC with the name `-`, 
this is your default VPC for that region.
_______________________________________________________________________________

Click `Create VPC` to create a new VPC
_______________________________________________________________________________

Use these settings:

- Resources to create: `VPC only`
- Name tag: `demo-vpc`
- IPv4 CIDR block: `IPv4 CIDR manual input`
- IPv4 CIDR: `10.0.0.0/16`

##### Note: The CIDR block sizes should always be between `/16` and `/28`

- IPv6 CIDR block: No IPv6 CIDR block
- Tenancy: Default
- VPC encryption control ($): None

### Tags
- Key: `Name`, Value: `demo-vpc`
_______________________________________________________________________________

Click `Create VPC`
_______________________________________________________________________________

##### Note: Creating a VPC is free
_______________________________________________________________________________

You should see a `Main route table` after creating the VPC.

This will be the default route table for all of the subnets that do not an
explicit route table associated with them.
_______________________________________________________________________________

On the left sidebar, click on `subnets`

You should have 6 default subnets for the `us-east-1` region.
_______________________________________________________________________________

### How to create a subnet

Click `Create subnet`

- VPC ID: Select the `demo-vpc` from the drop down menu

Use these setting:
_______________________________________________________________________________

This is how to configure the public subnet

- Subnet name: `public-subnet`
- Availability Zone: `us-east-1a`
- IPv4 VPC CIDR block: `10.0.0.0/16`
- IPv4 subnet CIDR block: `10.0.0.0/24`

##### Note: You should see `256 IPs` next to it afterwards

_______________________________________________________________________________

`10.0.0.0/24` explained

- The first three numbers are fixed. `10.0.0`
- Only the fourth number can be changed.

- If you want to create a new subnet, then you would change the 3rd number.
- You would create a new subnet when you want to prevent 
overlapping CIDR blocks.
_______________________________________________________________________________

Click `Add new subnet` (This is to create another subnet. The private subnet)
_______________________________________________________________________________

Use these settings:

- Subnet name: `private subnet`
- Availability Zone: `us-east-1b`
- IPv4 VPC CIDR block: `10.0.0.0/16`

##### `Remember the first subnet was 10.0.0.0/24` 
so you change the third number when trying to create a new subnet

- IPv4 subnet CIDR block: `10.0.1.0/24`

##### Note: You should see `256 IPs` next to it afterwards

_______________________________________________________________________________

Click `Create subnet` to create both of these subnets for the `demo-vpc`
_______________________________________________________________________________

On the left sidebar, click `Internet gateways`

You should see the `Internet gateway ID` for one internet gateway, 
which is attached to the default VPC for the region.
_______________________________________________________________________________

### How to create a new internet gateway

On the left sidebar click `internet gateways`

You should see an internet gateway named `-`
_______________________________________________________________________________

Click `Create internet gateway`

This is the default internet gateway for the default VPC

- Name tag: `demo-igw`
_______________________________________________________________________________

After creating the internet gateway. 

You will see that the state of the gateway is `detached` 
(Not associated with any VPC)
_______________________________________________________________________________

Click on `Actions`, then click `Attach to VPC`

- Available VPCs: Select the `demo-vpc`
_______________________________________________________________________________

### Create a route table

In order to make a subnet public, that subnet has to be associated with a
route table, that has an entry to an internet gateway.
_______________________________________________________________________________

On the left sidebar, click `Route tables`

You should see the `Route table ID` for the default VPC, and the `demo-vpc`
_______________________________________________________________________________

Click `Create route table`

- Name: `public-rt`
- VPC: `demo-vpc`
_______________________________________________________________________________

After creating it, if you scroll down to `Routes`, you will see 
a local route.

- Destination: `10.0.0.0/16`
- Target: `local`

This route is not connected with any internet gateway.

Leave this as it is
_______________________________________________________________________________

Click `Edit routes`, then click add route

- `0.0.0.0/0` (A catch all IP CIDR block)

Target:
    -> `Internet Gateway`
    -> Select the `demo-igw`

Then click on `Save changes`
_______________________________________________________________________________

Click on the `subnet associations` tab,
then click `Edit subnet associations`

Select the `public-subnet`, then click `Save association`
_______________________________________________________________________________
