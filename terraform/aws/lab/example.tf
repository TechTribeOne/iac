provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "example" {
  ami                    = "ami-0323c3dd2da7fb37d"
  instance_type          = "t2.micro"
  key_name               = "euidzero_rsa"
  vpc_security_group_ids = [
      "sg-03ada9b10f77604e7"
  ]
}
