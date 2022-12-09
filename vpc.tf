resource "aws_vpc" "openvpn" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = var.vpc_name
  }
}

# Public Subnets - using /24 cidr range these will become /26 subnets.
resource "aws_subnet" "openvpn" {
  vpc_id     = aws_vpc.openvpn.id
  cidr_block = cidrsubnet(var.vpc_cidr, 2, 0)
  tags = {
    Name = var.vpc_name
    role = "public"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "openvpn" {
  vpc_id = aws_vpc.openvpn.id
  tags = {
    Name = var.vpc_name
  }
}

# Public route table and association
resource "aws_route_table" "openvpn" {
  vpc_id = aws_vpc.openvpn.id
  tags = {
    Name = "${var.vpc_name}-public"
  }
}

resource "aws_route" "openvpn" {
  route_table_id         = aws_route_table.openvpn.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.openvpn.id
}

resource "aws_route_table_association" "openvpn" {
  subnet_id      = aws_subnet.openvpn.id
  route_table_id = aws_route_table.openvpn.id
}