# Security Group itself (without inline rules)
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow web traffic"
  vpc_id      = data.aws_vpc.default.id
}

# Ingress rule (HTTP)
resource "aws_security_group_rule" "allow_http_in" {
  type              = "ingress"
  description       = "Allow HTTP from anywhere"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_sg.id
}

# Egress rule (all traffic)
resource "aws_security_group_rule" "allow_all_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_sg.id
}


resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Security group for EC2 instances"
  vpc_id      = data.aws_vpc.default.id


  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


