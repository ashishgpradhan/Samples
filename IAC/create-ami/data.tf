data "aws_subnets" "default_subnet_id" {
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

data "aws_vpc" "default" {
  default = true
}

output "default_subnet_ids" {
  description = "List of default subnet IDs"
  value       = data.aws_subnets.default_subnet_id
  
}

output "default_vpc_id" {
  description = "The default VPC ID"
  value       = data.aws_vpc.default.id
  
}