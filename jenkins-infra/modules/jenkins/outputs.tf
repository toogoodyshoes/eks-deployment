output "domain-name" {
  description = "Domain Name"
  value = aws_instance.jenkins-server.public_dns
}

output "agent-domain-name" {
  description = "Domain Name"
  value = aws_instance.jenkins-agent.public_dns
}

output "agent-private-ip" {
  value = aws_instance.jenkins-agent.private_ip
}