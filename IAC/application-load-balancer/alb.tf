resource "aws_lb_target_group" "name" {
  name        = "web-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_alb" "app_lb" {
  name               = "web-alb"
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = [data.aws_subnets.default.ids[0], data.aws_subnets.default.ids[1]]

  enable_deletion_protection = false

  tags = {
    Name = "web-alb"
  }

}


resource "aws_lb_listener" "app_lb_listener" {
  load_balancer_arn = aws_alb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.name.arn
  }

}

resource "aws_lb_target_group_attachment" "web_tg_attachment" {
  target_group_arn = aws_lb_target_group.name.arn
  count            = length(aws_instance.web_server)
  target_id        = aws_instance.web_server[count.index].id
  port             = 80

}
