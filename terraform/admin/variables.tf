variable "ssh_key_name" {}
variable "public_key_data" {}
variable "private_key_data" {}
variable "vpc_id" {}
variable "environment_name" {}
variable "cluster_name" {}
variable "region" {}
variable "instance_profile" {}
variable "owner" {}
variable "ttl" {}
variable "image_owner" {}
variable "image_release" {}

variable "subnet_ids" {
  type = "list"
}

variable "remote_regions" {
  type = "list"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "AWS instance type to use eg m4.large"
}

variable "aws_auth_access_key" {
  type        = "string"
  description = "AWS access key used by Vault to validate AWS authentication attempts"
}

variable "aws_auth_secret_key" {
  type        = "string"
  description = "AWS secret key used by Vault to validate AWS authentication attempts"
}

variable "hashistack_instance_arn" {
  description = "AWS IAM role ARN value for Hashistack node"
}

variable "aviato_instance_arn" {
  description = "AWS IAM role ARN value for aviato node"
}

variable "operating_system" {
  default     = "centos"
  description = "Operating system type, supported options are centos"
}

variable "operating_system_version" {
  default     = "7"
  description = "Operating system version, supported options are 7 for CentOS"
}

variable "ssh_user_name" {
  default     = "centos"
  description = "Default ssh username for provisioning, centos for CentOS systems"
}

variable "vault_cloud_auto_init_and_unseal" {
  type        = "string"
  description = "Enable or disable automatic Vault initialization and unseal. True or false, string."
}

variable "vault_auto_replication_setup" {
  type        = "string"
  description = "Enable or disable automatic replication configuration between Vault clusters. True or false, string."
}

variable "vanity_domain" {
  default     = "none"
  description = "Vanity domain name to use"
}

variable "launch_nomad_jobs_automatically" {
  type        = "string"
  default     = "true"
  description = "Enable or disable automatic Nomad deployment of Fabio and other demo applications"
}
