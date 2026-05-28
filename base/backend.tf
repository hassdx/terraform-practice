terraform {
  backend "s3" {
    bucket         = "epam-aws-tf-state-dx560"
    key            = "base/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "Terraform-Table"
  }
}
