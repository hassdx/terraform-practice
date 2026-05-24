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