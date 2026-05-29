# output "key_pair_name" {
#   value = aws_key_pair.epam-tf-ssh-key.key_name
# }



output "s3_bucket_name" {
  value = aws_s3_bucket.epam-tf-lab-s3.bucket
}