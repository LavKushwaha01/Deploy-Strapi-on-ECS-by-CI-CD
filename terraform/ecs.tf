resource "aws_ecs_cluster" "this" {
  name = "strapi-cluster-lav"
}

resource "aws_ecs_task_definition" "strapi" {
  family                   = "strapi-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"

  container_definitions = jsonencode([
    {
      name      = "strapi"
      image     = "${var.dockerhub_repo}:${var.image_tag}"
      essential = true

      portMappings = [
        {
          containerPort = 1337
          protocol      = "tcp"
        }
      ]

      environment = [
          { name = "NODE_ENV", value = "production" },
{ name = "APP_KEYS", value = "key1,key2,key3,key4" },
{ name = "API_TOKEN_SALT", value = "random_salt_123" },
{ name = "ADMIN_JWT_SECRET", value = "admin_secret_123" },
{ name = "JWT_SECRET", value = "jwt_secret_123" },


        { name = "DATABASE_CLIENT",   value = "postgres" },
        { name = "DATABASE_HOST",     value = aws_db_instance.postgres.address },
        { name = "DATABASE_PORT",     value = "5432" },
        { name = "DATABASE_NAME",     value = var.db_name },
        { name = "DATABASE_USERNAME", value = var.db_username },
        { name = "DATABASE_PASSWORD", value = var.db_password }
      ]
    }
  ])
}

resource "aws_ecs_service" "strapi" {
  name            = "strapi-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.strapi.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnets.default.ids
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  depends_on = [aws_db_instance.postgres]
}
