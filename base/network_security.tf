
resource "aws_security_group" "ssh-inbound" {
  name        = "ssh-inbound"
  description = "allows ssh access from safe IP-range"
  vpc_id      = aws_vpc.HASSAN-ELHOUARI-01-vpc.id

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
  }
}

resource "aws_security_group_rule" "ssh-inbound" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["88.216.154.177/32"]
  security_group_id = aws_security_group.ssh-inbound.id
}

resource "aws_security_group" "lb-http-inbound" {
  name        = "lb-http-inbound"
  description = "aallows http access from safe IP-range to a LoadBalancer"
  vpc_id      = aws_vpc.HASSAN-ELHOUARI-01-vpc.id

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
  }

}

resource "aws_security_group_rule" "lb-http-inbound" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["88.216.154.177/32"]
  security_group_id = aws_security_group.lb-http-inbound.id
}

resource "aws_security_group" "http-inbound" {
  name        = "http-inbound"
  description = "allows http access from LoadBalancer"
  vpc_id      = aws_vpc.HASSAN-ELHOUARI-01-vpc.id

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
  }
}

resource "aws_security_group_rule" "http_from_lb_rule" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.http-inbound.id
  source_security_group_id = aws_security_group.lb-http-inbound.id
}