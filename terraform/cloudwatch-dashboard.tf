resource "aws_cloudwatch_dashboard" "ecs_dashboard" {
  dashboard_name = "strapi-ecs-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        x = 0
        y = 0
        width = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/ECS", "CPUUtilization", "ClusterName", aws_ecs_cluster.this.name, "ServiceName", aws_ecs_service.strapi.name]
          ]
          period = 300
          stat   = "Average"
          region = var.region
          title  = "ECS CPU Utilization"
        }
      },
      {
        type = "metric"
        x = 12
        y = 0
        width = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/ECS", "MemoryUtilization", "ClusterName", aws_ecs_cluster.this.name, "ServiceName", aws_ecs_service.strapi.name]
          ]
          period = 300
          stat   = "Average"
          region = var.region
          title  = "ECS Memory Utilization"
        }
      },
      {
        type = "metric"
        x = 0
        y = 6
        width = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/ECS", "RunningTaskCount", "ClusterName", aws_ecs_cluster.this.name, "ServiceName", aws_ecs_service.strapi.name]
          ]
          period = 300
          stat   = "Average"
          region = var.region
          title  = "Running Task Count"
        }
      },
      {
        type = "metric"
        x = 12
        y = 6
        width = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/ECS", "NetworkRxBytes", "ClusterName", aws_ecs_cluster.this.name, "ServiceName", aws_ecs_service.strapi.name],
            ["AWS/ECS", "NetworkTxBytes", "ClusterName", aws_ecs_cluster.this.name, "ServiceName", aws_ecs_service.strapi.name]
          ]
          period = 300
          stat   = "Sum"
          region = var.region
          title  = "Network In / Out"
        }
      }
    ]
  })
}