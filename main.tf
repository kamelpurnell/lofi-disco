# Terraform state will be stored in S3
terraform {
  backend "s3" {
    bucket = "kameltestbucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

# Use AWS Terraform provider
provider "aws" {
  region = "us-east-1"
}
# Create Security Group for EC2
resource "aws_security_group" "terratest" {
  name = "terratest"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
# Create EC2 instance
resource "aws_instance" "default" {
  ami                    = "ami-021acbdb89706aa89"
  count                  = 1
  key_name               = "terraform"
  source_dest_check      = false
  instance_type          = "t2.micro"

  tags = {
    Name = "terraform-default"
  }
}


