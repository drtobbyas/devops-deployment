module "eks" {
  eks_managed_node_groups = {
    default = {
      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      instance_types = var.node_instance_types
      capacity_type  = "ON_DEMAND"

      ami_type = "AL2_x86_64"

      update_config = {
        max_unavailable = 1
      }

      enable_bootstrap_user_data = true

      iam_role_additional_policies = {
        ssm = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      }

      labels = {
        workload = "general"
      }

      taints = []

      metadata_options = {
        http_endpoint               = "enabled"
        http_protocol_ipv6          = "disabled"
        http_put_response_hop_limit = 2
        http_tokens                 = "required" # IMDSv2 only
      }
    }
  }

  tags = var.tags
}

# Data sources to feed providers
data "aws_eks_cluster" "this" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}
