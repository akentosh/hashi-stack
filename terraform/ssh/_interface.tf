# Optional Variables
variable "private_key_filename" {
  default     = "private_key.pem"
  description = "Filename to write the private key data to eg key.pem"
}

# Required variables
variable "ssh_key_name" {
  description = "AWS key pair name that will be created"
}

variable "ssh_private_key" {
  default     = ""
  description = "SSH private key to use"
}

variable "ssh_public_key" {
  default     = ""
  description = "SSH public key to use"
}

# Outputs
output "private_key_data" {
  value = "${var.ssh_private_key != "" ? var.ssh_private_key : tls_private_key.main.private_key_pem}"
}

output "ssh_key_name" {
  value = "${aws_key_pair.main.key_name}"
}

output "public_key_data" {
  value = "${var.ssh_public_key != "" ? var.ssh_public_key : tls_private_key.main.public_key_openssh}"
}
