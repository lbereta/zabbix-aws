provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "zabbix_key" {
  key_name   = "zabbix-key"
  public_key = var.zabbix_public_key
}

resource "aws_security_group" "zabbix_sg" {
  name        = "zabbix-sg"
  description = "Allow SSH, HTTP, Zabbix"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 10051
    to_port     = 10051
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "zabbix" {
  ami           = "ami-0c7217cdde317cfec" # Ubuntu 22.04
  instance_type = "t2.micro"
  key_name      = aws_key_pair.zabbix_key.key_name
  vpc_security_group_ids = [aws_security_group.zabbix_sg.id]

  user_data = file("${path.module}/../scripts/install_zabbix.sh")

  tags = {
    Name = "ZabbixServer"
  }
}

output "zabbix_ip" {
  value = aws_instance.zabbix.public_ip
}
