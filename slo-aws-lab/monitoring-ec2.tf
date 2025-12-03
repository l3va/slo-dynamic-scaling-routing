resource "aws_security_group" "monitoring_sg" {
  name        = "${var.project_name}-monitoring-sg"
  description = "Allow SSH, Prometheus and Grafana"
  vpc_id      = aws_vpc.main.id

  # SSH (так, для лаби можна 0.0.0.0/0, але це небезпечно для продакшена)
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Prometheus
  ingress {
    description = "Prometheus"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Grafana
  ingress {
    description = "Grafana"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Весь вихідний трафік дозволений
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-monitoring-sg"
  }
}

resource "aws_instance" "monitoring" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.monitoring_instance_type
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.monitoring_sg.id]
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/user_data/monitoring.sh.tftpl", {
    alb_dns = aws_lb.this.dns_name
  })

  root_block_device {
    volume_size = var.monitoring_disk_size
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_name}-monitoring-ec2"
  }
}
