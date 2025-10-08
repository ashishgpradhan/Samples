resource "aws_security_group" "ec2_instance_sg" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_security_group_rule" "AllowSSH" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_instance_sg.id
}


resource "aws_security_group_rule" "AlloHTTP" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_instance_sg.id
}


resource "aws_security_group_rule" "ConnectOnAllPorts" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_instance_sg.id
}


resource "aws_instance" "ec2_instance" {
  ami             = "ami-0150ccaf51ab55a51" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type   = "t2.micro"
  subnet_id       = data.aws_subnets.default_subnet_id.ids[0]
  security_groups = [aws_security_group.ec2_instance_sg.id]
  tags = {
    Name = "MyEC2Instance"
  }

}
