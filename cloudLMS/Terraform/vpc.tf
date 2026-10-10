resource "aws_vpc" "lms_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name      = "CASAS-LMS-VPC"
    Project   = "CASAS Cloud-Based Learning Management System"
    ManagedBy = "Terraform"
  }
}

resource "aws_internet_gateway" "lms_igw" {
  vpc_id = aws_vpc.lms_vpc.id

  tags = {
    Name      = "CASAS-LMS-IGW"
    Project   = "CASAS Cloud-Based Learning Management System"
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.lms_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name      = "CASAS-LMS-Public-Subnet"
    Project   = "CASAS Cloud-Based Learning Management System"
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.lms_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name      = "CASAS-LMS-Private-Subnet-A"
    Project   = "CASAS Cloud-Based Learning Management System"
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.lms_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name      = "CASAS-LMS-Private-Subnet-B"
    Project   = "CASAS Cloud-Based Learning Management System"
    ManagedBy = "Terraform"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.lms_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lms_igw.id
  }

  tags = {
    Name      = "CASAS-LMS-Public-Route-Table"
    Project   = "CASAS Cloud-Based Learning Management System"
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.lms_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name      = "CASAS-LMS-Public-Subnet-B"
    Project   = "CASAS Cloud-Based Learning Management System"
    ManagedBy = "Terraform"
  }
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}