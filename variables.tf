variable "name" {
  default     = "openvpn"
  description = "OpenVPN instance name"
}

variable "vpc_name" {
  description = "The OpenVPN VPC"
  default     = "openvpn"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDRs to use"
}

variable "instance_type" {
  description = "OpenVPN EC2 instance type"
}

variable "ebs_region" {
  description = "Region for the EBS volume where we'll store credentials and certificates"
}

variable "ebs_size" {
  description = "EBS volume size. 1GB should be fine in most cases"
  default     = 1
  type        = number
}

variable "ami" {
  description = "AMI ID to use for the EC2 instance"
}

variable "tag_name" {
  description = "The name to tag AWS resources with"
  default     = "openvpn"
}

variable "associate_public_ip_address" {
  description = "Associate a public IP address to the OpenVPN instance."
  default     = true
  type        = bool
}

variable "vpn_subnets" { default = ["10.194.36.0/23"] }
variable "volume_delete_on_termination" { default = "true" }
variable "ami_wildcard" { default = "amzn2-ami-hvm*" }
variable "disable_api_termination" { default = "false" }
variable "client" { default = "tera" }

variable "ec2_username" {
  description = "The user to connect to the EC2 as"
  default     = "ubuntu"
}

variable "vpn_network" {
  description = "The VPN network configuration for client"
  type        = string
  default     = "10.8.0"
}

variable "accepter_vpc_id" {
  description = "The accepter VPC id"
  type        = string
}

variable "accepter_vpc_name" {
  description = "The accepter VPC name"
  type        = string
}

variable "accepter_vpc_cidr" {
  description = "The accepter VPC cidr"
  type        = string
}

variable "accepter_tag" {
  description = "The route table accepter tag"
  type        = string
  default     = "*private*"
}