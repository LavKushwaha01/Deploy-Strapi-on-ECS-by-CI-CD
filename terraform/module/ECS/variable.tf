variable "ecr_repo_url" {
  type        = string
  description = "ECR repository URL for Strapi image"
}
variable "image_tag" {
  type        = string
  description = "Docker image tag"
}

variable "db_name" {
  type    = string
  default = "strapi"
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}