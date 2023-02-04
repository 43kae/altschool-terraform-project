resource "aws_security_group" "demo_sec_grp" {
  name        = "traffic"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.demo_vpc.id

  dynamic "ingress" {
    for_each = var.web_ingress
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web_pub"
  }
}

resource "aws_security_group" "demo_alb_sg" {
  name = "load_balancer_traffic"
  description = "Redirect traffic from LB to instances"
  vpc_id = aws_vpc.demo_vpc.id
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "load_balancer"
  }
}

# resource "aws_security_group_rule" "opened_to_alb" {
#   type                     = "ingress"
#   from_port                = 80
#   to_port                  = 80
#   protocol                 = "tcp"
#   security_group_id        = "${aws_security_group.demo_alb_sg.id}"
#   source_security_group_id = "${aws_security_group.demo_sec_grp.id}"
# }