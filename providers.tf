# Providers

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  shared_credentials_files = [var.shared_credentials]
  shared_config_files      = [var.shared_config]
}
