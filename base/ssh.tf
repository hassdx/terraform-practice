resource "aws_key_pair" "epam-tf-ssh-key" {
  key_name   = "epam-tf-ssh-key"
  public_key = var.ssh_key

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOAUI"
  }
}
