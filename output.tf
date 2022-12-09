output "ec2_instance_ip" {
  value = aws_instance.openvpn.public_ip
}

output "connection_string" {
  value = "'ssh -i openvpn_key ${var.ec2_username}@${aws_instance.openvpn.public_ip}'"
}

output "vpc_id" {
  value = aws_vpc.openvpn.id
}

output "vpn_subnet" {
  value = aws_subnet.openvpn.cidr_block
}