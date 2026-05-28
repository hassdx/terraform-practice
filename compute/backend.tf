terraform {
  backend "s3" {
    bucket         = "epam-aws-tf-state-dx560"
    key            = "compute/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "Terraform-Table"
  }
}
