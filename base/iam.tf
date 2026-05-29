module "iam" {
  source      = "./modules/iam"
  name        = "HASSAN-ELHOUARI-01"
  bucket_name = aws_s3_bucket.epam-tf-lab-s3.bucket
}