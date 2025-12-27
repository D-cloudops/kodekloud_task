resource "aws_vpc" "private_vpc" {
  cidr_block = var.KKE_VPC_CIDR
  tags = {
    Name = "devops-priv-vpc"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.private_vpc.id
  cidr_block = var.KKE_SUBNET_CIDR
  map_public_ip_on_launch = false
  tags = {
    Name = "devops-priv-subnet"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.private_vpc.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.private_vpc.cidr_block
  from_port         = -1
  ip_protocol       = "tcp"
  to_port           = -1
}


resource "aws_instance" "devops_instance" {
  ami = "ami-005e54dee72cc1d00"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  tags = {
    Name = "devops-priv-ec2"
  }
}