output "eks-cluster-oidc-provider-url" {
  value = aws_eks_cluster.my-eks-deployment.identity[0].oidc[0].issuer
}