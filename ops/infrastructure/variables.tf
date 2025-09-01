variable "cluster_name" {
}


variable "region" {
description = "AWS region"
type = string
default = "eu-west-1"
}


variable "vpc_cidr" {
description = "CIDR for VPC"
type = string
default = "10.0.0.0/16"
}


variable "az_count" {
description = "Number of AZs to use"
type = number
default = 3
}


variable "kubernetes_version" {
description = "EKS Kubernetes version"
type = string
default = "1.29"
}


variable "node_instance_types" {
description = "EC2 instance types for default node group"
type = list(string)
default = ["m6i.large", "m5.large"]
}


variable "desired_size" {
description = "Desired node count"
type = number
default = 3
}


variable "min_size" {
description = "Min node count"
type = number
default = 2
}


variable "max_size" {
description = "Max node count"
type = number
default = 6
}


variable "cluster_endpoint_public_access_cidrs" {
description = "CIDRs allowed to access the cluster endpoint when public access is enabled"
type = list(string)
default = ["0.0.0.0/0"]
}


variable "tags" {
description = "Common tags"
type = map(string)
default = {
Project = "k8s-platform"
Environment = "prod"
Terraform = "true"
}
}