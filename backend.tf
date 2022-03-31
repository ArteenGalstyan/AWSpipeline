# Remote backend
terraform {
  backend "s3" {
    bucket         = "amg-terraform-backend"
    key            = "terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "amg-terraform-backend-table"
  }
}
