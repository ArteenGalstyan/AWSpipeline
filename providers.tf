# Providers

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  shared_credentials_files = ["%USERPROFILE%.aws\\credentials"]
  shared_config_files      = ["%USERPROFILE%.aws\\config"]
}
