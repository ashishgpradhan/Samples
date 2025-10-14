resource "aws_security_group" "instance_sg" {
  name        = "instance_sg"
  description = "Security group for RDS instance"
  vpc_id      = data.aws_vpc.default_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}