output "vpc_id" {
  value = aws_vpc.cmtr-3v98t79h-01-vp.id
}

output "subnet_public_a_id" {
  value = aws_subnet.cmtr-3v98t79h-01-subnet-public-a.id
}

output "subnet_public_b_id" {
  value = aws_subnet.cmtr-3v98t79h-01-subnet-public-b.id
}

output "subnet_public_c_id" {
  value = aws_subnet.cmtr-3v98t79h-01-subnet-public-c.id
}

output "igw_id" {
  value = aws_internet_gateway.cmtr-3v98t79h-01-igw.id
}

output "rt_id" {
  value = aws_route_table.cmtr-3v98t79h-01-rt.id
}

