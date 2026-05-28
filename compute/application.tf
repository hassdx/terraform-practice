resource "aws_launch_template" "epam-tf-lab" {
  name = "epam-tf-lab"

  image_id      = "ami-0236922087fa98b6e"
  instance_type = "t3.micro"
  key_name      = local.key_name

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true

    security_groups = [
      data.aws_security_group.ssh.id,
      data.aws_security_group.lb_http.id
    ]

  }

  iam_instance_profile {
    name = local.iam_instance_profile_name
  }

  metadata_options {
    http_tokens = "optional"
  }
  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum install -y httpd aws-cli
              COMPUTE_MACHINE_UUID=$(cat /sys/devices/virtual/dmi/id/product_uuid | tr '[:upper:]' '[:lower:]')
              COMPUTE_INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
              MESSAGE="This message was generated on instance $${COMPUTE_INSTANCE_ID} with the following UUID $${COMPUTE_MACHINE_UUID}"
              echo "$${MESSAGE}" > /tmp/message.txt
              aws s3 cp /tmp/message.txt s3://${data.terraform_remote_state.base.outputs.s3_bucket_name}/$${COMPUTE_INSTANCE_ID}.txt
              echo "$${MESSAGE}" > /var/www/html/index.html
              systemctl start httpd
              EOF
  )


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
  vpc_id   = data.aws_vpc.my_vpc.id
}

resource "aws_lb" "elb-epam-tf-lab" {
  name               = "elb-epam-tf-lab"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.lb_http.id]
  subnets = [
    data.aws_subnet.public_subnet_a.id,
    data.aws_subnet.public_subnet_b.id,
    data.aws_subnet.public_subnet_c.id
  ]

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "HASSAN_ELHOUARI"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.elb-epam-tf-lab.arn
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
    data.aws_subnet.public_subnet_a.id,
    data.aws_subnet.public_subnet_b.id,
    data.aws_subnet.public_subnet_c.id
  ]

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

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.epam-tf-lab.name
  lb_target_group_arn    = aws_lb_target_group.target_group.arn
}


