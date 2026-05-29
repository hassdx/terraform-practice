
resource "aws_vpc" "HASSAN-ELHOUARI-01-vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
    Name      = "${var.name}-vpc"
  }
}

resource "aws_subnet" "HASSAN-ELHOUARI-01-subnet-public-a" {
  vpc_id            = aws_vpc.HASSAN-ELHOUARI-01-vpc.id
  cidr_block        = var.subnet_cidr_a
  availability_zone = "us-east-1a"

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
    Name      = "HASSAN-ELHOUARI-01-subnet-public-a"
  }
}

resource "aws_subnet" "HASSAN-ELHOUARI-01-subnet-public-b" {
  vpc_id            = aws_vpc.HASSAN-ELHOUARI-01-vpc.id
  cidr_block        = var.subnet_cidr_b
  availability_zone = "us-east-1b"

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
    Name      = "HASSAN-ELHOUARI-01-subnet-public-b"
  }
}

resource "aws_subnet" "HASSAN-ELHOUARI-01-subnet-public-c" {
  vpc_id            = aws_vpc.HASSAN-ELHOUARI-01-vpc.id
  cidr_block        = var.subnet_cidr_c
  availability_zone = "us-east-1c"

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
    Name      = "HASSAN-ELHOUARI-01-subnet-public-c"
  }
}

resource "aws_internet_gateway" "HASSAN-ELHOUARI-01-igw" {
  vpc_id = aws_vpc.HASSAN-ELHOUARI-01-vpc.id

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
    Name      = "HASSAN-ELHOUARI-01-igw"
  }
}

resource "aws_route_table" "HASSAN-ELHOUARI-01-rt" {
  vpc_id = aws_vpc.HASSAN-ELHOUARI-01-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.HASSAN-ELHOUARI-01-igw.id
  }
  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
    Name      = "HASSAN-ELHOUARI-01-rt"
  }

}

resource "aws_route_table_association" "HASSAN-ELHOUARI-01-route_table_association-a" {
  subnet_id      = aws_subnet.HASSAN-ELHOUARI-01-subnet-public-a.id
  route_table_id = aws_route_table.HASSAN-ELHOUARI-01-rt.id
}

resource "aws_route_table_association" "HASSAN-ELHOUARI-01-vpc-route_table_association-b" {
  subnet_id      = aws_subnet.HASSAN-ELHOUARI-01-subnet-public-b.id
  route_table_id = aws_route_table.HASSAN-ELHOUARI-01-rt.id
}

resource "aws_route_table_association" "HASSAN-ELHOUARI-01-vpc-route_table_association-c" {
  subnet_id      = aws_subnet.HASSAN-ELHOUARI-01-subnet-public-c.id
  route_table_id = aws_route_table.HASSAN-ELHOUARI-01-rt.id
}