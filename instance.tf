resource "aws_instance" "openvpn" {
  lifecycle {
    ignore_changes = [ami]
  }
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.openvpn.id

  #  iam_instance_profile        = aws_iam_role.instance.id
  disable_api_termination     = var.disable_api_termination
  source_dest_check           = "false"
  associate_public_ip_address = var.associate_public_ip_address

  tags = {
    Name   = var.tag_name
    role   = "openvpn"
    client = var.client
  }

  vpc_security_group_ids = [
    aws_security_group.openvpn.id,
    aws_security_group.ssh_from_local.id
  ]

  key_name = aws_key_pair.openvpn.key_name
}