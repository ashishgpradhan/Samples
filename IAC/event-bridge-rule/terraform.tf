terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "local" {

}
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}