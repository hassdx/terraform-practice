
resource "aws_vpc" "cmtr-3v98t79h-01-vp" {
  cidr_block = "10.10.0.0/16"

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
    Name      = "cmtr-3v98t79h-01-vp"
  }
}

resource "aws_subnet" "cmtr-3v98t79h-01-subnet-public-a" {
  vpc_id            = aws_vpc.cmtr-3v98t79h-01-vp.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
    Name      = "cmtr-3v98t79h-01-subnet-public-a"
  }
}

resource "aws_subnet" "cmtr-3v98t79h-01-subnet-public-b" {
  vpc_id            = aws_vpc.cmtr-3v98t79h-01-vp.id
  cidr_block        = "10.10.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
    Name      = "cmtr-3v98t79h-01-subnet-public-b"
  }
}

resource "aws_subnet" "HASSAN-ELHOUARI-01-subnet-public-c" {
  vpc_id            = aws_vpc.cmtr-3v98t79h-01-vp.id
  cidr_block        = "10.10.5.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
    Name      = "HASSAN-ELHOUARI-01-subnet-public-c"
  }
}

resource "aws_internet_gateway" "cmtr-3v98t79h-01-igw" {
  vpc_id = aws_vpc.cmtr-3v98t79h-01-vp.id

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
    Name      = "cmtr-3v98t79h-01-igw"
  }
}

resource "aws_route_table" "cmtr-3v98t79h-01-rt" {
  vpc_id = aws_vpc.cmtr-3v98t79h-01-vp.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cmtr-3v98t79h-01-igw.id
  }
  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
    Name      = "cmtr-3v98t79h-01-rt"
  }

}

resource "aws_route_table_association" "HASSAN-ELHOUARI-01-route_table_association-a" {
  subnet_id      = aws_subnet.cmtr-3v98t79h-01-subnet-public-a.id
  route_table_id = aws_route_table.cmtr-3v98t79h-01-rt.id
}

resource "aws_route_table_association" "cmtr-3v98t79h-01-vp-route_table_association-b" {
  subnet_id      = aws_subnet.cmtr-3v98t79h-01-subnet-public-b.id
  route_table_id = aws_route_table.cmtr-3v98t79h-01-rt.id
}

resource "aws_route_table_association" "cmtr-3v98t79h-01-vp-route_table_association-c" {
  subnet_id      = aws_subnet.HASSAN-ELHOUARI-01-subnet-public-c.id
  route_table_id = aws_route_table.cmtr-3v98t79h-01-rt.id
}