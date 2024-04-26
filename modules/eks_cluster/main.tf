# EKS Cluster ------------------------------------------------------->

data "aws_iam_policy_document" "eks-cluster-assume-role-policy" {
  version = "2012-10-17"
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks-cluster-role" {
  name = "AmazonEKSClusterRole"

  assume_role_policy  = data.aws_iam_policy_document.eks-cluster-assume-role-policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"]
}



resource "aws_eks_cluster" "my-eks-deployment" {
  name     = "my-eks-deployment"
  version  = "1.29"
  role_arn = aws_iam_role.eks-cluster-role.arn
  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  vpc_config {
    subnet_ids              = [var.private_subnet_1_id, var.private_subnet_2_id, var.public_subnet_1_id, var.public_subnet_2_id]
    endpoint_private_access = true
    endpoint_public_access  = true
  }
}

resource "aws_eks_addon" "coredns" {
  addon_name    = "coredns"
  addon_version = "v1.11.1-eksbuild.4"
  cluster_name  = "my-eks-deployment"

  depends_on = [aws_eks_cluster.my-eks-deployment, aws_eks_node_group.my-eks-deployment-1]
}

resource "aws_eks_addon" "kube-proxy" {
  addon_name    = "kube-proxy"
  addon_version = "v1.29.0-eksbuild.1"
  cluster_name  = "my-eks-deployment"

  depends_on = [aws_eks_cluster.my-eks-deployment]
}

resource "aws_eks_addon" "vpc-cni" {
  addon_name    = "vpc-cni"
  addon_version = "v1.16.0-eksbuild.1"
  cluster_name  = "my-eks-deployment"

  depends_on = [aws_eks_cluster.my-eks-deployment]
}

resource "aws_eks_addon" "eks-pod-identity-agent" {
  addon_name    = "eks-pod-identity-agent"
  addon_version = "v1.2.0-eksbuild.1"
  cluster_name  = "my-eks-deployment"

  depends_on = [aws_eks_cluster.my-eks-deployment]
}

# EKS Cluster ------------------------------------------------------->



# Node Group -------------------------------------------------------->

data "aws_iam_policy_document" "node-role-trust-policy" {
  version = "2012-10-17"
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks-node-role" {
  name = "AmazonEKSNodeRole"

  assume_role_policy  = data.aws_iam_policy_document.node-role-trust-policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy", "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly", "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"]
}



resource "aws_eks_node_group" "my-eks-deployment-1" {
  cluster_name    = aws_eks_cluster.my-eks-deployment.name
  node_group_name = "my-eks-deployment-1"
  node_role_arn   = aws_iam_role.eks-node-role.arn
  subnet_ids      = [var.private_subnet_1_id, var.private_subnet_2_id]

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  ami_type       = "AL2_x86_64"
  disk_size      = 20
  instance_types = ["t3.medium"]

  depends_on = [
    aws_eks_cluster.my-eks-deployment,
    aws_iam_role.eks-node-role
  ]
}

# Node Group -------------------------------------------------------->
