resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    name = "main_vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone
  tags = {
    name = "public_subnet"
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    name = "igw"
  }

}

resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    name = "main_route_table"
  }
}

resource "aws_route_table_association" "main_route_table_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.main_route_table.id
}

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"
  description = "Allow inbound traffic on ports 22 (SSH), 80 (HTTP), and 8080 (Jenkins)"
  vpc_id      = aws_vpc.main_vpc.id # Assuming you have a VPC defined.

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = var.protocol
    cidr_blocks = var.ingress_cidr_block # Allow all inbound SSH traffic. You can restrict this to specific IPs for more security.
  }

  ingress {
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = var.protocol
    cidr_blocks = var.ingress_cidr_block # Allow all HTTP traffic.
  }

  ingress {
    from_port   = var.jenkins_port
    to_port     = var.jenkins_port
    protocol    = var.protocol
    cidr_blocks = var.ingress_cidr_block # Allow all inbound Jenkins traffic. You can restrict this to specific IPs.
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = var.protocol
    cidr_blocks = var.engress_cidr_block # Allow all outbound traffic.
  }
}
