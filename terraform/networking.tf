
 VPC


resource "aws_vpc" "main" {

  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }

}


 Internet Gateway


resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
  }

}


 Public Subnet 1


resource "aws_subnet" "public_subnet_1" {

  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-1"
  }

}


 Public Subnet 2


resource "aws_subnet" "public_subnet_2" {

  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-2"
  }

}


 Private Subnet 1


resource "aws_subnet" "private_subnet_1" {

  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-private-subnet-1"
  }

}


 Private Subnet 2


resource "aws_subnet" "private_subnet_2" {

  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-private-subnet-2"
  }

}


 Elastic IP


resource "aws_eip" "nat_eip" {

  domain = "vpc"

  tags = {
    Name = "${var.project_name}-nat-eip"
  }

}


 NAT Gateway


resource "aws_nat_gateway" "nat" {

  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  depends_on = [
    aws_internet_gateway.igw
  ]

  tags = {
    Name = "${var.project_name}-nat"
  }

}


 Public Route Table


resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.igw.id

  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }

}


 Private Route Table


resource "aws_route_table" "private" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.nat.id

  }

  tags = {
    Name = "${var.project_name}-private-rt"
  }

}


 Public Route Table Association 1


resource "aws_route_table_association" "public1" {

  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public.id

}


 Public Route Table Association 2


resource "aws_route_table_association" "public2" {

  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public.id

}


 Private Route Table Association 1


resource "aws_route_table_association" "private1" {

  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private.id

}


 Private Route Table Association 2


resource "aws_route_table_association" "private2" {

  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private.id

}
