resource "aws_security_group" "web-server-sg" {
  name        = "web-server-sg"
  description = "Allow HTTP and SSH traffic"


  ingress {
    from_port   = 80
    to_port     = 80
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


resource "aws_instance" "web-server" {
  ami           = "ami-08982f1c5bf93d976" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  security_groups = [aws_security_group.web-server-sg.name]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Welcome to the Web Server</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "WebServerInstance"
  }
  
}
