

resource "aws_vpc" "firstVPC" {
  cidr_block = var.vpc
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    name = var.tag
  }
}
resource "aws_subnet" "mysecondSUBNET1"  {
  vpc_id = aws_vpc.firstVPC.id
  availability_zone = "us-east-2a"
  cidr_block = "10.0.0.0/26"
  tags = {
    name = var.tag
  }
}
resource "aws_subnet" "mysecondSUBNET2" {
  vpc_id = aws_vpc.firstVPC.id
  availability_zone = var.availzoon1
  cidr_block = "10.0.0.64/26"
  tags = {
    name = var.tag
  }
}
resource "aws_security_group" "mysecgp" {
  name   = "allow ssh1"
  vpc_id = aws_vpc.firstVPC.id


  ingress {
    from_port         = 22
    to_port           = 22
    protocol          = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    protocol  = "TCP"
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    from_port = -1
    protocol  = "icmp"
    to_port   = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "Terra-new-IGW" {
  vpc_id = aws_vpc.firstVPC.id
  tags   = {
    Name = "Terra-new-IGW1"
  }
}
resource "aws_route_table" "route-table-terra" {
  vpc_id = aws_vpc.firstVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Terra-new-IGW.id

  }
}
resource "aws_route_table_association" "test" {
  subnet_id = aws_subnet.mysecondSUBNET1.id
  route_table_id = aws_route_table.route-table-terra.id
}
resource "aws_route_table_association" "test22" {
  subnet_id = aws_subnet.mysecondSUBNET2.id
  route_table_id = aws_route_table.route-table-terra.id
}
resource "aws_instance" "my-ec2-terraform" {
  ami                         = "ami-02d1e544b84bf7502"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  monitoring                  = true
  subnet_id                   = aws_subnet.mysecondSUBNET1.id
  availability_zone           = "us-east-2a"
  disable_api_termination     = true
     vpc_security_group_ids = [aws_security_group.mysecgp.id]
  key_name                   = "ookey"
  user_data =  <<EOF
#!/bin/bash
yum update -y
yum install httpd -y
service httpd start
chkconfig httpd on
cd /var/www/html
echo 'Hello mathi, Welcome To My ec2-insatnce-1' > index.html
aws s3 mb s3://johnny-aws-guru-s3-bootstrap-01
aws s3 cp index.html s3://johnny-aws-guru-s3-bootstrap-01
EOF
  tags                        = {
    name = "terra-ce2"
  }
}
#resource "aws_instance" "my-c2-multipe" {
  #ami = "ami-02d1e544b84bf7502"
  #associate_public_ip_address = true
  #instance_type = "t2.micro"
  #subnet_id = aws_subnet.mysecondSUBNET1.id
  #availability_zone = "us-east-2a"
  #security_groups = [aws_security_group.mysecgp.id]
  #key_name = "terra-key"
  #user_data =  <<EOF
#!/bin/bash
#yum update -y
#yum install httpd -y
#service httpd start
#chkconfig httpd on
#cd /var/www/html
#echo 'Hello mathi, Welcome To My ec2-insatnce-2' > index.html
#aws s3 mb s3://johnny-aws-guru-s3-bootstrap-01
#aws s3 cp index.html s3://johnny-aws-guru-s3-bootstrap-01
#EOF

 # tags = {
   # name = "tera-c2-multi"
#  }
#}
resource "aws_iam_user" "sky" {
  name = "sky"

}
resource "aws_iam_user" "moon" {
  name = "moon-guy"
}
resource "aws_iam_group" "admin-group" {
  name = "admin-group"
}
resource "aws_iam_user_group_membership" "group-add" {
  user = aws_iam_user.sky.name
  groups = [
    aws_iam_group.admin-group.name
  ]
}
resource "aws_iam_group_policy" "systemAdmin" {
  group  = aws_iam_group.admin-group.name
  policy = jsonencode( {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "*",
        "Resource": "*"
      }
    ]
  })
}
#resource "aws_alb" "myfirst-alb" {
  #load_balancer_type = "application"
  #internal           = false
  #security_groups = [aws_security_group.mysecgp.id]
  #subnets = [aws_subnet.mysecondSUBNET1.id,aws_subnet.mysecondSUBNET2.id]
#}
#resource "aws_alb_target_group" "target-ec2" {
  #name = "aws-targ"
 # vpc_id = aws_vpc.firstVPC.id
  #port = 80
 # protocol = "HTTP"

#}
#resource "aws_alb_target_group_attachment" "test" {
  #target_group_arn = aws_alb_target_group.target-ec2.arn
 # target_id        = aws_instance.my-ec2-terraform.id
#}
#resource "aws_alb_target_group_attachment" "test2" {
 # target_group_arn = aws_alb_target_group.target-ec2.arn
  #target_id = aws_instance.my-c2-multipe.id
#}
#resource "aws_alb_listener" "alb-listener" {
 #load_balancer_arn = aws_alb.myfirst-alb.id
  #port              = 80
  #protocol          = "HTTP"
  #default_action {
  #  type = "forward"
   # target_group_arn = aws_alb_target_group.target-ec2.arn
  #}
#}


