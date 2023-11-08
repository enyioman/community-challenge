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
  execution_role_arn = aws_iam_role.ecs_task_role.arn
  task_role_arn      = aws_iam_role.ecs_task_role.arn
  # task_role_arn      = "arn:aws:iam::335081657283:role/ecsTaskExecutionRole"
  # execution_role_arn = "arn:aws:iam::335081657283:role/ecsTaskExecutionRole"
}

resource "aws_iam_role" "ecs_task_role" {
  name = "ecs_task_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com",
      },
    }],
  })
}

resource "aws_iam_policy" "ecs_task_policy" {
  name        = "ecs_task_policy"
  description = "Policy for ECS tasks to write logs to CloudWatch Logs and pull from ECR"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ],
        Effect   = "Allow",
        Resource = "*",
      },
      {
        Action   = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
        ],
        Effect   = "Allow",
        Resource = "*",
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_attachment" {
  policy_arn = aws_iam_policy.ecs_task_policy.arn
  role       = aws_iam_role.ecs_task_role.name
}

