terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }

  # backend "remote" {
  #   hostname     = "app.terraform.io"
  #   organization = "kot-labs"

  #   workspaces {
  #     prefix = "plate-stack-"
  #   }
  # }
  cloud {
    hostname = "app.terraform.io"
    organization = "kot-labs"
    workspaces {
      tags = [ "plate-stack-prod", "plate-stack-dev" ]
    }
  }

}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}