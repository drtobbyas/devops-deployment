module "vpc" {
source = "terraform-aws-modules/vpc/aws"
version = "~> 5.0"


name = "${var.cluster_name}-vpc"
cidr = var.vpc_cidr


azs = local.azs
private_subnets = [for idx, az in local.azs : cidrsubnet(var.vpc_cidr, 4, idx)]
public_subnets = [for idx, az in local.azs : cidrsubnet(var.vpc_cidr, 8, idx + 48)]


enable_nat_gateway = true
single_nat_gateway = false
one_nat_gateway_per_az = true


public_subnet_tags = {
"kubernetes.io/role/elb" = 1
}


private_subnet_tags = {
"kubernetes.io/role/internal-elb" = 1
}


tags = var.tags
}