resource "aws_vpc" "Custom_VPC" {
    cidr_block = "10.16.0.0/16"
    tags = {
        Name = "${var.Name}"
    }
}