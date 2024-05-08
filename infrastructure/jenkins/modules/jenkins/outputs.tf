output "server-domain-name" {
  value = aws_instance.jenkins-server.public_dns
}

output "agent-domain-name" {
  value = aws_instance.jenkins-agent.public_dns
}

output "server-private-ip" {
  value = aws_instance.jenkins-server.private_ip
}

output "agent-private-ip" {
  value = aws_instance.jenkins-agent.private_ip
}