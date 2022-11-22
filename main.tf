data "aws_ami" "amazon-linux-2" {
  owners = ["amazon"] # Canonical
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }

  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }

  filter {
    name = "owner-alias"
    values = [ "amazon" ]
  }  
}

data "template_file" "userdata" {
  template = file("${abspath(path.module)}/userdata.sh")
  vars = {
    server-name = var.server_name
  }
}

resource "aws_instance" "tf_my_ec2" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = var.instance_type
  count = var.number_of_intance
  key_name = var.key_name
  vpc_security_group_ids = [ aws_security_group.tf-sec-gr.id ]
  user_data = data.template_file.userdata.rendered

  tags = {
    Name = var.tag 
  }
}

resource "aws_security_group" "tf-sec-gr" {
  name        = "${var.tag}-terraform-sec-grp"
  description = "Allow SSH, HTTP, 8080 ports inbound traffic"

  dynamic "ingress" {
    for_each = var.docker_instance_ports
    iterator = port
    content {
        from_port        = port.value
        to_port          = port.value
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }   
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.tag 
  }
}


