#######modules/eks/variables.tf

variable "aws_key_pair" {
  default = "devsecops"
}

variable "aws_public_subnet" {
  type    = list(string)
  default = ["use1-az1", "use1-az1", "use1-az3"]
}

variable "vpc_id" {}

variable "cluster_name" {}

variable "endpoint_private_access" {}

variable "endpoint_public_access" {}

variable "public_access_cidrs" {}

variable "node_group_name" {}

variable "scaling_desired_size" {}

variable "scaling_max_size" {}

variable "scaling_min_size" {}

variable "instance_types" {}

# variable "key_pair" {}