resource "aws_security_group" "openvpn" {
  name        = "${var.vpc_name}_openvpn"
  description = "Openvpn rules"
  vpc_id      = aws_vpc.openvpn.id

  lifecycle {
    create_before_destroy = "true"
  }

  # For OpenVPN Client Web Server & Admin Web UI
  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow access VPN from Internet"
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.tag_name
  }
}

resource "aws_security_group" "ssh_from_local" {
  name        = "${var.vpc_name}_ssh_local"
  description = "Allow SSH access only from local machine"
  lifecycle {
    create_before_destroy = "true"
  }
  vpc_id = aws_vpc.openvpn.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.local_ip_address]
    description = "ssh access from local machine"
  }

  tags = {
    Name = var.tag_name
  }
}
