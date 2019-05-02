variable "ssh_key_name" {}
variable "public_key_data" {}
variable "private_key_data" {}
variable "vpc_id" {}
variable "environment_name" {}
variable "cluster_name" {}
variable "region" {}
variable "instance_profile" {}
variable "kms_id" {}
variable "owner" {}
variable "ttl" {}
variable "image_owner" {}
variable "image_release" {}

variable "subnet_ids" {
  type = "list"
}

variable "public_subnet_ids" {
  type = "list"
}

variable "cluster_size" {
  default     = "3"
  description = "Number of instances to launch in the cluster"
}

variable "instance_type" {
  default     = "t3.large"
  description = "AWS instance type to use"
}

variable "operating_system" {
  default     = "centos"
  description = "Operating system type, supported options are centos"
}

variable "operating_system_version" {
  default     = "7"
  description = "Operating system version, supported options are 7 for centos"
}

variable "ssh_user_name" {
  default     = "centos"
  description = "Default ssh username for provisioning, centos for CentOS systems"
}

variable "remote_regions" {
  type = "list"
}

variable "vanity_domain" {
  default     = "none"
  description = "Vanity domain name to use"
}
