
# Fetch all default subnets in the current AWS region
data "aws_subnets" "default" {
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

# Fetch default VPC for completeness
data "aws_vpc" "default" {
  default = true
}
