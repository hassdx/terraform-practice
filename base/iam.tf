resource "aws_iam_group" "HASSAN-ELHOUARI-01-group" {
  name = "HASSAN-ELHOUARI-01-group"
}

resource "aws_iam_policy" "write-to-epam-tf-lab" {
  name        = "write-to-epam-tf-lab"
  description = "Policy for S3 access"
  policy = templatefile("${path.module}/files/s3-policy.json", {
    bucket_name = aws_s3_bucket.epam-tf-lab-s3.bucket
  })

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
  }
}

resource "aws_iam_group_policy_attachment" "attach_policy" {
  group      = aws_iam_group.HASSAN-ELHOUARI-01-group.name
  policy_arn = aws_iam_policy.write-to-epam-tf-lab.arn
}

resource "aws_iam_role" "HASSAN-ELHOUARI-01-role" {
  name        = "HASSAN-ELHOUARI-01-role"
  description = "IAM role for EC2 instance"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
  }
}

resource "aws_iam_role_policy_attachment" "attach_policy_to_role" {
  role       = aws_iam_role.HASSAN-ELHOUARI-01-role.name
  policy_arn = aws_iam_policy.write-to-epam-tf-lab.arn
}

resource "aws_iam_instance_profile" "ec2-profile" {
  name = "HASSAN-ELHOUARI-01-instance-profile"
  role = aws_iam_role.HASSAN-ELHOUARI-01-role.name

}
