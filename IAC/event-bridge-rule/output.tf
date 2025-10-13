data "aws_vpc" "default" {
  default = true
}


output "default_vpc_id" {
  description = "The ID of the default VPC"
  value       = data.aws_vpc.default.id

}