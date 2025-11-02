variable "splunk" {
  default = "8088"
}

resource "aws_security_group" "security_group_payment_app" {
  name        = "payment_app"
  description = "Application Security Group"
  depends_on  = [aws_eip.example]

  # Below ingress allows HTTPS  from DEV VPC
  ingress {
    description = "ingress allows HTTPS  from DEV VPC"
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"
    cidr_blocks = [var.dev_cidr]
  }

  # Below ingress allows APIs access from DEV VPC

  ingress {
    description = "ingress allows APIs access from DEV VPC"
    from_port   = var.api_port
    to_port     = var.api_port
    protocol    = "tcp"
    cidr_blocks = [var.dev_cidr]
  }

  # Below ingress allows APIs access from Prod App Public IP.

  ingress {
    description = "ingress allows APIs access from Prod App Public IP"
    from_port   = var.api_port
    to_port     = var.api_port
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.example.public_ip}/32"]
  }

  egress {
    description = "egress allows APIs access from Prod App Public IP"
    from_port   = var.splunk
    to_port     = var.splunk
    protocol    = "tcp"
    cidr_blocks = [var.prod_cidr]
  }

  tags = {
    name = "payment_app"
    team = "payment team"
    stack = var.environment
  }
}