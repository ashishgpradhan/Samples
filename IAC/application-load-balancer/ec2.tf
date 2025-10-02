resource "aws_instance" "web_server" {
  ami             = "ami-0150ccaf51ab55a51"
  instance_type   = "t2.micro"
  count           = 2
  security_groups = [aws_security_group.ec2_sg.name]

  user_data = <<-EOF
       #!/bin/bash
       sudo dnf update -y
       sudo dnf install -y httpd
       sudo systemctl start httpd
       sudo systemctl enable httpd
       echo "<html><h1>Welcome. Happy Learning from $(hostname -f)...</h1></html>" > /var/www/html/index.html
  EOF

  tags = {
    Name = "instance-${count.index + 1}"
  }
}


