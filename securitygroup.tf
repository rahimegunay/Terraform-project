resource "aws_security_group" "myproject_sg" {
  name        = "allow_traffic"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.project_1.id

  ingress {
    description      = "HTTPS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["86.14.208.120/32"]

  }

  ingress {
    description      = "HTTP from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["86.14.208.120/32"]

  }
  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["86.14.208.120/32"]

  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "allow traffic"
  }
}


resource "aws_security_group" "myproject_alb" {
    name        = "allow outbound traffic"
    vpc_id      = aws_vpc.project_1.id

  ingress {
    
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  
  tags = {
    Name = "project1-alb"
  }
}
