resource "aws_alb" "demo_alb" {
  name               = "demo-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.demo_alb_sg.id, aws_security_group.demo_sec_grp.id]
  subnets            = [for subnet in aws_subnet.demo_subnet : subnet.id]

  enable_deletion_protection = false

  tags = {
    Name = "demo_alb"
  }
}

resource "aws_alb_target_group" "demo_alb_tg" {
    name = "demo-alb-target"
    target_type = "instance"
    port        = 80
    protocol    = "HTTP"
    vpc_id      = aws_vpc.demo_vpc.id
}

resource "aws_alb_target_group_attachment" "demo-tg-attach" {
  for_each = aws_instance.demo_instance
  target_group_arn = aws_alb_target_group.demo_alb_tg.arn
  target_id = each.value.id
  port = 80
}

resource "aws_alb_listener" "demo_alb_listener" {
  load_balancer_arn = aws_alb.demo_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.demo_alb_tg.arn
  }
}