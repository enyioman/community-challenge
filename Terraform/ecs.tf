resource "aws_ecs_cluster" "HostspaceCluster" {
  name = "HostspaceCluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_service" "HostSpaceClusterService" {
  name                   = "HostSpaceClusterService"
  cluster                = aws_ecs_cluster.HostspaceCluster.arn
  launch_type            = "FARGATE"
  enable_execute_command = true

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  desired_count                      = 1
  task_definition                    = aws_ecs_task_definition.HostspaceTaskDefinition.arn

  network_configuration {
    assign_public_ip = true
    security_groups  = [aws_security_group.hostspace_sg.id]
    subnets          = [aws_subnet.sub1.id, aws_subnet.sub2.id, aws_subnet.sub3.id]
  }
}

resource "aws_ecs_task_definition" "HostspaceTaskDefinition" {
  container_definitions = jsonencode([
    {
      name      = "frontend"
      image     = "335081657283.dkr.ecr.us-east-1.amazonaws.com/frontend:latest"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          "protocol"    = "tcp"
          "appProtocol" = "http"
        }
      ]
    },

    {
      name      = "backend"
      image     = "335081657283.dkr.ecr.us-east-1.amazonaws.com/backend:latest"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
          "protocol"    = "tcp"
          "appProtocol" = "http"
        }
      ]
    }
  ])
  family                   = "HostspaceTaskDefinition"
  requires_compatibilities = ["FARGATE"]

  cpu                = "512"
  memory             = "1024"
  network_mode       = "awsvpc"
  task_role_arn      = "arn:aws:iam::335081657283:role/ecsTaskExecutionRole"
  execution_role_arn = "arn:aws:iam::335081657283:role/ecsTaskExecutionRole"
}