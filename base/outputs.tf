output "vpc_id" {
  value = aws_vpc.HASSAN-ELHOUARI-01-vpc.id
}

output "public_subnet_a_id" {
  value = aws_subnet.HASSAN-ELHOUARI-01-subnet-public-a.id
}

output "public_subnet_b_id" {
  value = aws_subnet.HASSAN-ELHOUARI-01-subnet-public-b.id
}

output "public_subnet_c_id" {
  value = aws_subnet.HASSAN-ELHOUARI-01-subnet-public-c.id
}

output "security_group_id_ssh" {
  value = aws_security_group.ssh-inbound.id
}

output "security_group_id_lb_http" {
  value = aws_security_group.lb-http-inbound.id
}

output "security_group_id_http" {
  value = aws_security_group.http-inbound.id
}

# output "key_pair_name" {
#   value = aws_key_pair.epam-tf-ssh-key.key_name
# }

output "iam_instance_profile_name" {
  value = aws_iam_instance_profile.ec2-profile.name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.epam-tf-lab-s3.bucket
}