locals {
# Pick AZs dynamically based on region and az_count
azs = slice(data.aws_availability_zones.available.names, 0, var.az_count)
}


data "aws_availability_zones" "available" {
state = "available"
}