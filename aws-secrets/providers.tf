terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "kot-labs"
    workspaces {
      name = "test-aws-secrets"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  profile = "wlynshue"
  region  = "us-east-1"
  default_tags {
    tags = {
      Application = "kot-labs"
    }
  }
}