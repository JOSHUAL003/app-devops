resource "aws_security_group" "alb_sg" {
  name        = "${var.project_name}-alb-sg"
  description = "Allow HTTP and HTTPS"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol   = -1
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "${var.project_name}-alb-sg"
  }
}

resource "aws_security_group" "ecs_sg" {
  name        = "${var.project_name}-ecs-sg"
  description = "Allow traffic from ALB"
  vpc_id      = aws_vpc.main.id



  ingress {

    from_port = 5000
    to_port   = 5000
    protocol  = "tcp"

    security_groups = [aws_security_group.alb_sg.id]
  }


  egress {

    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]

  }


  tags  = {
    name = "${var.project_name}-ecs-sg"
  }

}


resource "aws_security_group" "rds_sg" {

  name        = "${var.project_name}-rds-sg"
  description = "Allow MySQL from ECS"
  vpc_id      = aws_vpc.main.id

  ingress {

    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"

    security_groups = [
      aws_security_group.ecs_sg.id
    ]

  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "${var.project_name}-rds-sg"
  }

}
