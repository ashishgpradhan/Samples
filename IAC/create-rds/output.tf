data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnets " "default_subnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }

  filter {
    name   = "availability-zone"
    values = ["us-east-1b", "us-east-1a"]
  }

}

output "default_vpc" {
  value = data.aws_vpc.default_vpc.id
}
