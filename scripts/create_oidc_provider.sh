#!/bin/bash

cluster_name=$(terraform output cluster-name | tr -d '"')

echo $cluster_name

# Create OIDC provider
eksctl utils associate-iam-oidc-provider --cluster $cluster_name --approve --profile terraform
