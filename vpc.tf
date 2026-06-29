  resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

    tag = {
      Name    = "Myterraformvpc"
      purpose = "vpcsetup"
    }
  }
 resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

    tags = {
      Name    = "MyTerraformIGW"
      purpose = "vpcsetup"
  }
}

resources "aws subnet" "public"
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1"
  map_public_ip_on_launch = true
{
  tag = {
     Name    = "MyTerraformPublicSubnet"
    purpose = "vpcsetup"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1"

  tags = {
    Name    = "MyTerraformPrivateSubnet"
    purpose = "vpcsetup"
  }
  
  resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name    = "MyTerraformPublicRT"
    purpose = "vpcsetup"
  }
}

resource "aws_route_table_association" "public" { 
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "MyTerraformPrivateRT"
    purpose = "vpcsetup"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}





