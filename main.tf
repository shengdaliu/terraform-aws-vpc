provider "aws" {
  profile = var.profile
  region  = local.region
}

locals {
  region = "eu-central-1" # Frankfurt
  tags = {
    Owner       = "Shengda"
    Environment = "Test"
    Terraform   = "true"
  }
}

################################################################################
# VPC Module
################################################################################

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = "10.0.0.0/16"

  azs             = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_ipv6 = false

  enable_nat_gateway = true
  single_nat_gateway = true

  private_subnet_suffix = "private"
  public_subnet_suffix  = "public"

  private_subnet_tags = {
    Environment = "Test"
    Name        = "Private subnet"
    Terraform   = "true"

  }

  public_subnet_tags = {
    Environment = "Test"
    Name        = "Public subnet"
    Terraform   = "true"
  }

  default_route_table_tags = {
    Name      = "Default route table"
    Terraform = "true"
  }

  tags = local.tags
}
