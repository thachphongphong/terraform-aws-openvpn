resource "aws_ebs_volume" "openvpn_data" {
  availability_zone = var.ebs_region
  size              = var.ebs_size
  encrypted         = true

  lifecycle {
    prevent_destroy = false
  }
}


resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  instance_id = aws_instance.openvpn.id
  volume_id   = aws_ebs_volume.openvpn_data.id

  provisioner "local-exec" {
    command = "ansible-playbook --private-key keys/openvpn -i '${aws_instance.openvpn.public_ip},' config/ansible/openvpn.yml"
  }
}

resource "aws_key_pair" "openvpn" {
  key_name   = "openvpn"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCz8V1usqK0IMQuSNhu7+ruwQqfdPDr/+6JPT7zLBz2maeNR0NgaZJ2ljKqO6wSvDlEY6fuV07Q5pZLwoTEbQOY724tuidXxV4FtXEJp79s3bFw/bBTT2n5Qm0vn73LA/hZncDuPwmIdNAI07DtLELOtfAEGeVApsEFKx1X2GBQoGqANjC+gcFLcuXTQ06Vuqb939It9wUVeLVauVwSDw/eho7YOfZXTZ9Mt64K8sKIRfsm6PgAGFuFUf1hpw1lJR1+OGmU2kouv1dEhqqHcWSwUzR6rZDX6OLZCl/kBujESWl64aLDwXByO+4ejQ3zPkLAyT5+OKwXjkM2F9obkah8e/+pXakspY+oIAKHV+IYLKpif88XQyhbsJT1BfP+AyIqmaXcw54BfigY5ZDnL2/Tbehe6tMHKZ/l/UVTT8lfXDaOPStRnrkX6C5Zsfz7A0z1pjoi8BBXy3vK6kw5asb/OC3/5wUsL/RiEMDw7ZHNQB7yZID0WhDzl794ay93J+k= linhdo@LinhDoMac"
}

#resource "aws_route53_record" "openvpn" {
#  zone_id = var.route_zone_id
#  name    = "vpn.${var.domain}"
#  type    = "A"
#  ttl     = "300"
#  records = [aws_instance.openvpn.public_ip]
#}

data "http" "local_ip_address" {
  url = "http://ipv4.icanhazip.com"
}

locals {
  local_ip_address = "${chomp(data.http.local_ip_address.response_body)}/32"
}

