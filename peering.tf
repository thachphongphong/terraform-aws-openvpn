# Who Am I - important for setting up the peering
data "aws_caller_identity" "current" {
}

data "aws_route_tables" "accepter" {
  vpc_id = var.accepter_vpc_id
  tags = {
    "Name" = var.accepter_tag
  }
}

# Setup the connection
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = aws_vpc.openvpn.id
  peer_vpc_id   = var.accepter_vpc_id
  peer_owner_id = data.aws_caller_identity.current.account_id
  auto_accept   = true
  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution  = true
    allow_classic_link_to_remote_vpc = true
  }
  tags = {
    Name = "VPC Peering between ${var.accepter_vpc_name} and ${var.vpc_name}"
    Side = "Requester"
  }
}

resource "aws_route" "requester" {
  route_table_id            = aws_route_table.openvpn.id
  destination_cidr_block    = var.accepter_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  depends_on                = [aws_vpc.openvpn, aws_route_table.openvpn]
}

resource "aws_route" "accepter" {
  count                     = length(data.aws_route_tables.accepter.ids)
  route_table_id            = tolist(data.aws_route_tables.accepter.ids)[count.index]
  destination_cidr_block    = aws_vpc.openvpn.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}