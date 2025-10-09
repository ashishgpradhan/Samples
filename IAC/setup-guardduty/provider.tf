terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 4.0"
        }
    }
    required_version = ">= 1.0.0"
}

provider "aws" {
  alias = "ProductionRegion"
  region     = var.aws_region
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}