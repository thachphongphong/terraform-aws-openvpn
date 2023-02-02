generate "provider" {
  path      = "provider.tf"
  if_exists = "skip"
  contents  = <<EOF

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.75.0"
    }
  }
}

provider "aws" {
  region                  = var.region
  shared_credentials_file = var.shared_credentials_file
  profile                 = var.profile
}

EOF
}

generate "variables" {
  path      = "common_variables.tf"
  if_exists = "overwrite"
  contents  = <<EOF

variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "shared_credentials_file" {
  type    = string
  default = "credentials"
}

variable "profile" {
  type    = string
  default = "default"
}

EOF
}