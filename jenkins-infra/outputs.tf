output "jenkins-server-domain-name" {
  value = module.jenkins.domain-name
}

output "jenkins-agent-domain-name" {
  value = module.jenkins.agent-domain-name
}

output "jenkins-agent-private-ip" {
    value = module.jenkins.agent-private-ip
}