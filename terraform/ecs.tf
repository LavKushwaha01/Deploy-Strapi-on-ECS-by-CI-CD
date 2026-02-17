resource "aws_ecs_task_definition" "strapi" {
  family                   = "strapi-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"

  # Optional but recommended (logs). If you don’t have log group yet, ECS will create it.
  container_definitions = jsonencode([
    {
      name      = "strapi"
      image     = "${var.dockerhub_image}:${var.image_tag}"
      essential = true

      portMappings = [
        {
          containerPort = 1337
          hostPort      = 1337
          protocol      = "tcp"
        }
      ]
      environment = [
        { name = "NODE_ENV",          value = "production" },
        { name = "DATABASE_CLIENT",  value = "postgres" },
        { name = "DATABASE_HOST",    value = aws_db_instance.postgres.address },
        { name = "DATABASE_PORT",    value = "5432" },
        { name = "DATABASE_NAME",    value = var.db_name },
        { name = "DATABASE_USERNAME",value = var.db_username },
        { name = "DATABASE_PASSWORD",value = var.db_password }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/strapi"
          awslogs-region        = var.region
          awslogs-stream-prefix = "strapi"
        }
      }

      healthCheck = {
        command     = ["CMD-SHELL", "curl -f http://localhost:1337/_health || exit 1"]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 60
      }
    }
  ])
}
