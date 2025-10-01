terraform {


  required_providers {
    aws = {
      source = "hashicorp/aws"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.46.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
