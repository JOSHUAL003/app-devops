####################################################
# ECR Repository URL
####################################################

output "ecr_repository_url" {

  description = "Amazon ECR Repository URL"

  value = aws_ecr_repository.app.repository_url

}

####################################################
# ECS Cluster Name
####################################################

output "ecs_cluster_name" {

  description = "ECS Cluster Name"

  value = aws_ecs_cluster.cluster.name

}

####################################################
# ECS Service Name
####################################################

output "ecs_service_name" {

  description = "ECS Service Name"

  value = aws_ecs_service.service.name

}

####################################################
# ALB DNS Name
####################################################

output "alb_dns_name" {

  description = "Application Load Balancer DNS"

  value = aws_lb.alb.dns_name

}

####################################################
# RDS Endpoint
####################################################

output "rds_endpoint" {

  description = "RDS Endpoint"

  value = aws_db_instance.mysql.endpoint

}
