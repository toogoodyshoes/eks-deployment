output "oidc-provider-url" {
    value = module.eks_cluster.eks-cluster-oidc-provider-url
}

output "cluster-name" {
    value = module.eks_cluster.eks-cluster-name
}