provider "aws" {
region = var.region
}

resource "aws_vpc" "main" {
cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
vpc_id = aws_vpc.main.id
cidr_block = "10.0.1.0/24"
map_public_ip_on_launch = true
}

resource "aws_security_group" "web_sg" {
name = "web_sg"
vpc_id = aws_vpc.main.id

ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
from_port = 8080
to_port = 8080
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_instance" "web" {
ami = "ami-0e670eb768a5fc3d4" # Ubuntu 22.04 LTS for ap-south-1
instance_type = var.instance_type
subnet_id = aws_subnet.public.id
vpc_security_group_ids = [aws_security_group.web_sg.id]
associate_public_ip_address = true
key_name = "your-key.pem" # Replace this

tags = {
Name = "DevOpsAppServer"
}
}
