output "jenkins-server-domain-name" {
  value = module.jenkins.server-domain-name
}

output "jenkins-server-private-ip" {
  value = module.jenkins.server-private-ip
}

output "jenkins-agent-domain-name" {
  value = module.jenkins.agent-domain-name
}

output "jenkins-agent-private-ip" {
    value = module.jenkins.agent-private-ip
}