# DEVOPS PIPELINE
3-tier web application deployed on EKS cluster, following the DevOps lifecycle.

## Table of Contents
- [DEVOPS PIPELINE](#devops-pipeline)
  - [Description](#description)

## Description
This project employes containerization, CI/CD pipelines and Infrastrcture as a Code. The process includes automated testing and building, configuration management and monitoring.

EC2 instance to run Jekins Server-Agent architecture for Continuous Integration. Nginx as a reverse proxy infront of the Jenkins server.
Terraform to provision the infrastructure and Ansible to mangage the configuration of the nodes.

The application is packaged in Docker images and pushed to Docker Hub with the help of Jenkins CI and deployed to an Terraform provisioned EKS cluster on AWS with the help of Kubernetes and Helm. The continuous delivery is handled by Argo CD for the Kubernetes deployment.

Promethues and Grafana serve to monitor the infrastructure for performance and reliability.

