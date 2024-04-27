#!/bin/bash

# Add the helm repository
helm repo add jetstack https://charts.jetstack.io --force-update

# Update local Helm chart repository cache
helm repo update

# Create namespace cert-manager
kubectl create namespace cert-manager

# Install cert-manager
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.14.5 \
  --set installCRDs=true