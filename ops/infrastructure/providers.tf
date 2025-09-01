provider "aws" {
  region = var.region
}

# Optionally configure remote backend (uncomment and set your bucket/table)
# terraform {
#   backend "s3" {
#     bucket         = "my-terraform-state-bucket"
#     key            = "eks/terraform.tfstate"
#     region         = "eu-west-1"
#     dynamodb_table = "my-terraform-locks"
#     encrypt        = true
#   }
# }

# Wire Kubernetes & Helm providers to EKS after it is created
# These use the data sources in eks.tf
provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.this.token
  }
}
