data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "alb_subnets" {
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}