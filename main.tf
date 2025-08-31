terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

module "grafana" {
  source = "git::https://github.com/Gabconst/GRAFANA-IAC.git//compute?ref=main"

  ami_id               = "ami-020cba7c55df1f615"
  instance_type        = "t2.micro"
  key_name             = "devops-pdi"
  allowed_ssh_cidr     = "0.0.0.0/0"
  allowed_grafana_cidr = "0.0.0.0/0"
  aws_profile          = "default"
  aws_region           = "us-east-1"

  ssh_port             = 22
  grafana_port         = 3000

  egress_from_port     = 0
  egress_to_port       = 0
  egress_protocol      = "-1"
  egress_cidr_blocks   = ["0.0.0.0/0"]
}

output "instance_ip" {
  value = module.grafana.instance_ip
}

output "security_group_id" {
  value = module.grafana.security_group_id
}
