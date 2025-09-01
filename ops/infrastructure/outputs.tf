output "cluster_name" {
value = module.eks.cluster_name
}


output "cluster_endpoint" {
value = module.eks.cluster_endpoint
}


output "cluster_security_group_id" {
value = module.eks.cluster_security_group_id
}


output "oidc_provider_arn" {
value = module.eks.oidc_provider_arn
}


output "kubeconfig" {
description = "Kubeconfig snippet you can save to ~/.kube/config"
value = <<EOT
apiVersion: v1
clusters:
- cluster:
server: ${data.aws_eks_cluster.this.endpoint}
certificate-authority-data: ${data.aws_eks_cluster.this.certificate_authority[0].data}
name: ${module.eks.cluster_name}
contexts:
- context:
cluster: ${module.eks.cluster_name}
user: ${module.eks.cluster_name}
name: ${module.eks.cluster_name}
current-context: ${module.eks.cluster_name}
kind: Config
users:
- name: ${module.eks.cluster_name}
user:
token: ${data.aws_eks_cluster_auth.this.token}
EOT
sensitive = true
}