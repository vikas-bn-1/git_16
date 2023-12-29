######Key generation######

resource "aws_key_pair" "privatekey" {
  key_name   = "${var.project_name}-${var.project_env}"
  public_key = file("auth_key.pub")
  tags = {
    name    = "${var.project_name}-${var.project_env}"
    project = var.project_name
    env     = var.project_env
    owner   = var.project_owner  
  }
}

######Security group added######

resource "aws_security_group" "frontend_access" {
  name = "${var.project_name}-${var.project_env}-frontend_access"

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
    
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.project_env}-frontend_access"
  }
}

######ec2 instance added######

resource "aws_instance" "webserver" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.privatekey.key_name
  vpc_security_group_ids = [aws_security_group.frontend_access.id]
  tags = {
    Name = "${var.project_name}-${var.project_env}-webserver"
  }
}

######route53 added######

resource "aws_route53_record" "webserver" {
        
  zone_id = data.aws_route53_zone.rootdomain.id
  name    = "${var.hostname}.${var.hostname_domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.webserver.public_ip]
}
