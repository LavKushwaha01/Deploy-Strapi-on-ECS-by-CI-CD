resource "aws_cloudwatch_log_group" "strapi" {
  name              = "/ecs/strapi"
  retention_in_days = 7   # you can change to 14/30 for prod

  tags = {
    Name = "strapi-ecs-logs"
    App  = "strapi"
  }
}
