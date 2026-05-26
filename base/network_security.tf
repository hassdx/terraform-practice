resource "aws_security_group" "ssh-inbound" {
  name        = "ssh-inbound"
  description = "allows ssh access from safe IP-range"
  vpc_id      = aws_vpc.HASSAN-ELHOUARI-01-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
  }
}

resource "aws_security_group" "lb-http-inbound" {
  name        = "lb-http-inbound"
  description = "allows http access from safe IP-range to a LoadBalancer"
  vpc_id      = aws_vpc.HASSAN-ELHOUARI-01-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
  }
}

resource "aws_security_group" "http-inbound" {
  name        = "http-inbound"
  description = "allows http access from LoadBalancer"
  vpc_id      = aws_vpc.HASSAN-ELHOUARI-01-vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb-http-inbound.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
  }
}