#!/bin/bash

cd ../infrastructure
cluster_name=$(terraform output cluster-name | tr -d '"')

# Create OIDC provider
eksctl utils associate-iam-oidc-provider --cluster $cluster_name --approve --profile terraform
