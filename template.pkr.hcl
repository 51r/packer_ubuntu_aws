packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}
variable "AWS_DEFAULT_REGION" {
  type    = string
  default = "eu-central-1"
}
variable "AWS_ACCESS_KEY_ID" {
  type    = string
  default = ""
}
variable "AWS_SECRET_ACCESS_KEY" {
  type      = string
  default   = ""
  sensitive = true
}
source "amazon-ebs" "ubuntu" {
  ami_name      = "learn-packer-linux-aws"
  instance_type = "t2.micro"
  access_key    = var.AWS_ACCESS_KEY_ID
  secret_key    = var.AWS_SECRET_ACCESS_KEY
  region        = var.AWS_DEFAULT_REGION
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "shell" {
    script = "scripts/install_nginx.sh"
  }
}
