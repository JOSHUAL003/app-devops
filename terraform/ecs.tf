resource "aws_ecs_cluster" "cluster" {

  name = "${var.project_name}-cluster"

  tags = {
    Name = "${var.project_name}-cluster"
  }

}
resource "aws_ecs_task_definition" "task" {

  family = var.project_name

  network_mode = "awsvpc"

  requires_compatibilities = ["FARGATE"]

  cpu = "256"

  memory = "512"

  execution_role_arn = aws_iam_role.ecs_execution_role.arn

  task_role_arn = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([

    {

      name = "app"

      image = "${aws_ecr_repository.app.repository_url}:latest"

      essential = true

      portMappings = [

        {

          containerPort = 5000

          hostPort = 5000

          protocol = "tcp"

        }

      ]

      logConfiguration = {

        logDriver = "awslogs"

        options = {

          awslogs-group = aws_cloudwatch_log_group.ecs_logs.name

          awslogs-region = var.aws_region

          awslogs-stream-prefix = "ecs"

        }

      }

    }

  ])

}
resource "aws_ecs_service" "service" {

  name = "${var.project_name}-service"

  cluster = aws_ecs_cluster.cluster.id

  task_definition = aws_ecs_task_definition.task.arn

  desired_count = 1

  launch_type = "FARGATE"

  network_configuration {

    subnets = [

      aws_subnet.private_subnet_1.id,

      aws_subnet.private_subnet_2.id

    ]

    security_groups = [

      aws_security_group.ecs_sg.id

    ]

    assign_public_ip = false

  }

  load_balancer {

    target_group_arn = aws_lb_target_group.tg.arn

    container_name = "app"

    container_port = 5000

  }

  depends_on = [

    aws_lb_listener.http

  ]

}
