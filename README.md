# EKS DEPLOYMENT
A web application deployed on Amazon EKS.

## Table of Contents
- [EKS DEPLOYMENT](#eks-deployment)
  - [Description](#description)
  - [Codebase](#codebase)

## Description
Web application installed with the help of Helm on an Amazon EKS cluster.
Installed cert-manager for automated SSL/TLS certificate management and AWS Load Balancer Controller to expose the application to the internet via a Load Balancer service.


## Codebase
### This project is distributed into 3 modules
#### 1. Infrastructure
All of the infrastrucutre required for networking and well running cluster which includes Node Group for worker node has been provisioned with Terraform.
#### 2. Application
The application is split into inter-connected modules in the form of Kubernetes manifests.
#### 3. Scripts
It comes with the scripts to install the cert-manager as well as the AWS Load Balancer Controller required for Load Balancer service.
