data "terraform_remote_state" "base" {
  backend = "s3"

  config = {
    bucket = "epam-aws-tf-state-dx560"
    key    = "base/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_vpc" "my_vpc" {
  filter {
    name   = "tag:Name"
    values = ["HASSAN-ELHOUARI-01-vpc"]
  }
}

data "aws_subnet" "public_subnet_a" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.my_vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = ["HASSAN-ELHOUARI-01-subnet-public-a"]
  }
}

data "aws_subnet" "public_subnet_b" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.my_vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = ["HASSAN-ELHOUARI-01-subnet-public-b"]
  }
}

data "aws_subnet" "public_subnet_c" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.my_vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = ["HASSAN-ELHOUARI-01-subnet-public-c"]
  }
}

data "aws_security_group" "ssh" {
  filter {
    name   = "group-name"
    values = ["ssh-inbound"]
  }
  vpc_id = data.aws_vpc.my_vpc.id
}

data "aws_security_group" "lb_http" {
  filter {
    name   = "group-name"
    values = ["lb-http-inbound"]
  }
  vpc_id = data.aws_vpc.my_vpc.id
}

data "aws_security_group" "http" {
  filter {
    name   = "group-name"
    values = ["http-inbound"]
  }
  vpc_id = data.aws_vpc.my_vpc.id
}

    