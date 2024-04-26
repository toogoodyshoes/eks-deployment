#!/bin/bash

cluster_name=$(terraform output cluster-name | tr -d '"')

# Get the dns name
fqdn=$(kubectl get service -n ui ui-nlb -o jsonpath="{.status.loadBalancer.ingress[*].hostname}{'\n'}")

# Upgrade the AWS Controller Load Balancer Config
helm upgrade aws-load-balancer-controller eks/aws-load-balancer-controller \
  --set cluster.dnsDomain=$fqdn

