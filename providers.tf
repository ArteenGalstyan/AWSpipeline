# Providers

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  shared_credentials_files = ["\\Users\\Arteen\\.aws\\credentials"]
  shared_config_files      = ["C:\\Users\\Arteen\\.aws\\config"]
}
