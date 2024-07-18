## random

resource "random_pet" "sg" {}

## VPC

resource "aws_vpc" "awsec2_demo" {
  cidr_block = "172.16.0.0/16"
}

## Subnet

resource "aws_subnet" "awsec2_demo" {
  vpc_id = aws_vpc.awsec2_demo.id
  cidr_block = "172.16.10.0/24"
  tags = {
    Name = "subnet-github_actions"
  }
}

## Network Interface

resource "aws_network_interface" "awsec2_demo" {
    subnet_id = aws_subnet.awsec2_demo.id
    private_ips = ["172.16.10.100"]
    tags = {
      Name = "NI-EC2Demo"
    }
  
}

## Security Group

resource "aws_security_group" "awsec2_demo" {
  name = "${random_pet.sg.id}-sg"
  vpc_id = aws_vpc.awsec2_demo.id
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## VPC EC2
resource "aws_instance" "awsec2_demo" {
  ami = "ami-0b72821e2f351e396"
  instance_type = "t2.micro"
  network_interface {
    network_interface_id = aws_network_interface.awsec2_demo.id
    device_index = 0
  }
}


