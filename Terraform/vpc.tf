resource "aws_vpc" "hostspace_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
}

resource "aws_subnet" "sub1" {
  cidr_block              = "10.0.1.0/24"
  vpc_id                  = aws_vpc.hostspace_vpc.id
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "sub2" {
  cidr_block              = "10.0.2.0/24"
  vpc_id                  = aws_vpc.hostspace_vpc.id
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "sub3" {
  cidr_block              = "10.0.3.0/24"
  vpc_id                  = aws_vpc.hostspace_vpc.id
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true
}

resource "aws_security_group" "hostspace_sg" {
  name   = "hostspace_sg"
  vpc_id = aws_vpc.hostspace_vpc.id

  ingress {
    description = "http"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "hostspace_gw" {
  vpc_id = aws_vpc.hostspace_vpc.id
}

resource "aws_route_table" "hostspace_rt" {
  vpc_id = aws_vpc.hostspace_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hostspace_gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.hostspace_gw.id
  }
}

resource "aws_route_table_association" "route1" {
  route_table_id = aws_route_table.hostspace_rt.id
  subnet_id      = aws_subnet.sub1.id
}

resource "aws_route_table_association" "route2" {
  route_table_id = aws_route_table.hostspace_rt.id
  subnet_id      = aws_subnet.sub2.id
}

resource "aws_route_table_association" "route3" {
  route_table_id = aws_route_table.hostspace_rt.id
  subnet_id      = aws_subnet.sub3.id
}