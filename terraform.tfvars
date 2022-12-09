vpc_name      = "OpenVPN"
vpc_cidr      = "10.194.38.0/24"
instance_type = "t2.micro"
ebs_region    = "ap-southeast-1b"
ami           = "ami-02045ebddb047018b"

# vpc peering
accepter_vpc_id   = "vpc-0195fc7ab469db8af"
accepter_vpc_name = "Default"
accepter_vpc_cidr = "172.31.0.0/16"