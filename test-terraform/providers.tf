terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0"
    }
  }
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "kot-labs"
    workspaces {
      name = "kot-labs-s3-test"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "wlynshue"
  default_tags {
    tags = {
      Application = "kot-lab-ops"
      Environment = "test"
    }
  }
}