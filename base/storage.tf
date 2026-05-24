resource "random_string" "my_numbers" {
  length  = 6
  special = false
  upper   = false
}

resource "aws_s3_bucket" "epam-tf-lab-s3" {
  bucket = "epam-tf-lab-${random_string.my_numbers.result}"
  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
  }
}

resource "aws_s3_bucket_public_access_block" "access_block" {
  bucket = aws_s3_bucket.epam-tf-lab-s3.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}