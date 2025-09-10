resource "aws_lb" "my_app_alb" {
  name               = "my-app-alb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = data.aws_subnets.default.ids
}
resource "aws_lb_target_group" "my_app_tg" {
  name        = "my-app-tg-tf"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.default.id
  target_type = "ip"
}
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.my_app_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_app_tg.arn
  }
}
