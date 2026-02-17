terraform {
  backend "s3" {
    bucket         = "lav-terraform-state"
    key            = "ecs/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"   # optional but recommended
    encrypt        = true
  }
}
