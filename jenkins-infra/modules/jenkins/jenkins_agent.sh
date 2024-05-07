#!/bin/bash

sudo apt update
sudo apt upgrade

# Add user jenkins
sudo adduser jenkins    

# Grant sudo rights to jenkins
sudo usermod -aG sudo jenkins

# Switch to root
sudo bash

# Add adoptium repository
wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc
echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list

# Install java
apt update
apt install -y temurin-11-jdk
/usr/bin/java --version


sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release

# Install docker
mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Add user to docker group
usermod -aG docker jenkins

# Activate changes to group docker
newgrp docker
