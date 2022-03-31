# Demo Web Server using multiple AWS resources

# VPC

resource "aws_vpc" "tf-demo-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

# VPC Subnet 

resource "aws_subnet" "tf-demo-subnet1" {
  vpc_id            = aws_vpc.tf-demo-vpc.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = var.subnet_name
  }
}

# Internet Gateway

resource "aws_internet_gateway" "tf-demo-gw" {
  vpc_id = aws_vpc.tf-demo-vpc.id
}

# Custom Route Table

resource "aws_route_table" "tf-demo-rt" {
  vpc_id = aws_vpc.tf-demo-vpc.id

  route {
    cidr_block = var.rt_ipv4_cidr
    gateway_id = aws_internet_gateway.tf-demo-gw.id
  }

  route {
    ipv6_cidr_block = var.rt_ipv6_cidr
    gateway_id      = aws_internet_gateway.tf-demo-gw.id
  }

  tags = {
    Name = var.rt_name
  }
}

# Route Table Association
resource "aws_route_table_association" "tf-demo-tble-union" {
  subnet_id      = aws_subnet.tf-demo-subnet1.id
  route_table_id = aws_route_table.tf-demo-rt.id
}

# Security Groups
resource "aws_security_group" "tf-demo-secgrp" {
  name        = "allow_web_traffic"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.tf-demo-vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = var.secgrp_protocol
    cidr_blocks = [var.secgrp_HTTPS_cidr]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = var.secgrp_protocol
    cidr_blocks = [var.secgrp_HTTP_cidr]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = var.secgrp_protocol
    cidr_blocks = [var.secgrp_SSH_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.secgrp_name
  }
}

# Network interface

resource "aws_network_interface" "tf-demo-net-int" {
  subnet_id       = aws_subnet.tf-demo-subnet1.id
  private_ips     = [var.network_interface_ip]
  security_groups = [aws_security_group.tf-demo-secgrp.id]

}

# Elastic IP 

resource "aws_eip" "tf-demo-one" {
  vpc                       = true
  network_interface         = aws_network_interface.tf-demo-net-int.id
  associate_with_private_ip = var.network_interface_ip
  depends_on                = [aws_internet_gateway.tf-demo-gw]
}

# Ubuntu server

resource "aws_instance" "tf-demo-web-server" {
  ami               = "ami-009726b835c24a3aa"
  instance_type     = "t2.micro"
  availability_zone = var.availability_zone
  key_name          = "main-key"

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.tf-demo-net-int.id
  }

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install apache2 -y
                sudo systemctl start apache2
                sudo bash -c 'echo If you can read this, then the Web server is working! > /var/www/html/index.html'
                EOF
  tags = {
    Name = var.web_name
  }
}

# Budget

resource "aws_budgets_budget" "tf-demo-cost" {
  name         = "monthly-budget"
  budget_type  = "COST"
  limit_amount = "50"
  limit_unit   = "USD"
  time_unit    = "MONTHLY"
}
