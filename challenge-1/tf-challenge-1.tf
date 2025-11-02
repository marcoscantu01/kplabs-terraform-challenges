provider "aws" {
  region  = "us-east-1"
}

terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "aws_eip" "kplabs_app_ip" {
  domain = "vpc"
}
