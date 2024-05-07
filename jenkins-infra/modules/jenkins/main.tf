resource "aws_security_group" "jenkins-server" {
  name   = "jenkins-server-sg"
  vpc_id = "vpc-0eca79db8adccba7e"
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.jenkins-server.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "expose-port-1" {
  security_group_id = aws_security_group.jenkins-server.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 8080
  to_port           = 8080
}

resource "aws_vpc_security_group_ingress_rule" "ssh-access" {
  security_group_id = aws_security_group.jenkins-server.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_instance" "jenkins-server" {
  ami                    = "ami-0f58b397bc5c1f2e8"
  instance_type          = "t2.micro"
  key_name               = "jenkins-server-kp"
  subnet_id              = var.subnet-id
  vpc_security_group_ids = [aws_security_group.jenkins-server.id]
  user_data              = filebase64("${path.module}/jenkins_server.sh")

  tags = {
    Name = "Jenkins-Server"
  }
}


# Jenkins Agent
resource "aws_security_group" "jenkins-agent" {
  name   = "jenkins-agent-sg"
  vpc_id = "vpc-0eca79db8adccba7e"
}

resource "aws_vpc_security_group_egress_rule" "ja-all" {
  security_group_id = aws_security_group.jenkins-agent.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "ja-ssh-access" {
  security_group_id = aws_security_group.jenkins-agent.id
  #   cidr_ipv4         = "${aws_instance.jenkins-server.private_ip}/32"
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "ja-all" {
  security_group_id = aws_security_group.jenkins-agent.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "jenkins-agent" {
  ami                    = "ami-0f58b397bc5c1f2e8"
  instance_type          = "t2.micro"
  key_name               = "jenkins-agent-kp"
  subnet_id              = var.subnet-id
  vpc_security_group_ids = [aws_security_group.jenkins-agent.id]
  user_data              = filebase64("${path.module}/jenkins_agent.sh")

  tags = {
    Name = "Jenkins-Agent"
  }
}
