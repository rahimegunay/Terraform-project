resource "aws_key_pair" "my_project" {
  key_name = "main-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDWFgluUIqZxH5cU6+CrnkZ/+zuQqdlp1cSfbk2KxJkObKws3mi8i8hLMkVtXgVATs3iyuiM4xJzRKkphQzhPT8j7OEesiDs1bhD0fpJH/CLAlMWV9mFPAHzn41KeUO5i0VRrhDm9Bx5y0z+iicQYw3kaiX7isl5h6AGXa/4nH9aMg/ogoUo8uC7VAK17b0vnoeYXe6AfqJNNTEsLMVH7K8Xte+S/9YHqMe4xGz3t/URQaPRP7it15K809mbYIXsvtza40R8s35nGQ+2wHsRYD4xXtlj46en9l3nvzyhpv8k1FftKEnAwXt4t7HGnv9njCC49NMKD8MmeZZftRWV791sBrjcwf/WgGr2P+aSEAbJLT4nbcyyAwSQ1s3uZIHyLKk8PtT+B0T9KdvZLf7aELhh2gw1e3XeGb1qAJincCy80a2bA1iDPPS7VC+Blx9IkqTvVC2UBTlAXRGEWiQRSabIMVf4IVcmp8+atLs6EyFmyWi71g4JBoILCAsKuJz3TU="
}

resource "aws_launch_template" "myproject_temp"{
  name              = "myproject_temp"
  image_id          = data.aws_ami.ubuntu.id
  instance_type     = "t2.micro"
  key_name          = aws_key_pair.my_project.id
  vpc_security_group_ids = [aws_security_group.myproject_sg.id, aws_security_group.myproject_alb.id]
  user_data         = filebase64("${path.module}/userdata.tpl")

}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_autoscaling_group" "myproject_asg" {
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1
  vpc_zone_identifier = [aws_subnet.public_subnet1.id]
  target_group_arns =[aws_lb_target_group.myproject_alb_tg.arn]

  launch_template {
    id      = aws_launch_template.myproject_temp.id
    version = "$Latest"
  }
}

resource "aws_lb" "myproject_lb" {
  name               = "myproject-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.myproject_sg.id]
  subnets            = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]

  enable_deletion_protection = false

  
  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "myproject_alb_tg" {
  name     = "project1-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.project_1.id
}

resource "aws_lb_listener" "myproject_lb" {
  load_balancer_arn = aws_lb.myproject_lb.arn
  port              = "80"
  protocol          = "HTTP"

  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.myproject_alb_tg.arn
  }
}
