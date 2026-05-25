resource "aws_launch_template" "epam-tf-lab" {
  name = "epam-tf-lab"

  image_id      = "ami-0236922087fa98b6e"
  instance_type = "t2.micro"
  key_name      = data.terraform_remote_state.base.outputs.key_pair_name

  vpc_security_group_ids = [
    data.terraform_remote_state.base.outputs.security_group_id_ssh,
    data.terraform_remote_state.base.outputs.security_group_id_http
  ]

  iam_instance_profile {
    name = data.terraform_remote_state.base.outputs.iam_instance_profile_name
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              COMPUTE_MACHINE_UUID=$(cat /sys/devices/virtual/dmi/id/product_uuid | tr '[:upper:]' '[:lower:]')
              COMPUTE_INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

              echo "This message was generated on instance {COMPUTE_INSTANCE_ID} with the following UUID {COMPUTE_MACHINE_UUID}" > /tmp/message.txt

              aws s3 cp /tmp/message.txt s3://$(data.terraform_remote_state.base.outputs.s3_bucket_name)/message.txt
              
              echo "TASK 8: Message uploaded to S3 bucket" > /var/www/html/index.html
              EOF
  )


  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
  }

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.base.outputs.vpc_id
}

resource "aws_lb" "application_lb" {
  name               = "application-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.terraform_remote_state.base.outputs.security_group_id_lb_http]
  subnets = [
    data.terraform_remote_state.base.outputs.public_subnet_a_id,
    data.terraform_remote_state.base.outputs.public_subnet_b_id,
    data.terraform_remote_state.base.outputs.public_subnet_c_id
  ]

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.application_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}


resource "aws_autoscaling_group" "epam-tf-lab" {
  name             = "epam-tf-lab"
  max_size         = 1
  min_size         = 1
  desired_capacity = 1

  vpc_zone_identifier = [
    data.terraform_remote_state.base.outputs.public_subnet_a_id,
    data.terraform_remote_state.base.outputs.public_subnet_b_id,
    data.terraform_remote_state.base.outputs.public_subnet_c_id
  ]

  target_group_arns = [aws_lb_target_group.target_group.arn]

  launch_template {
    id      = aws_launch_template.epam-tf-lab.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [
      load_balancers,
      target_group_arns
    ]
  }
}


