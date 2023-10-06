# -----------------------------
# Variables
# -----------------------------
variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "region"
  type        = string
}

variable "availability_zone" {
  description = "availability zone"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "project_account_id" {
  description = "Project account id"
  type        = string
}

# -----------------------------
# network
# -----------------------------
variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  type        = string
}

variable "subnet_public_cidr_block" {
  description = "Public subnet"
  type        = string
}

# -----------------------------
# ami
# -----------------------------
variable "ami_web_server" {
  description = "AMI for web server"
  type        = string
}

variable "ami_windows_client" {
  description = "AMI for windows client"
  type        = string
}

variable "ami_dns_server" {
  description = "AMI for dns server"
  type        = string
}

variable "ami_proxy_server" {
  description = "AMI for proxy server"
  type        = string
}

# -----------------------------
# ssh key pair
# -----------------------------
variable "ssh_private_key" {
  description = "SSH private key"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
}

# -----------------------------
# file_path
# -----------------------------
variable "file_path_web_server" {
  description = "File path for web server"
  type        = string
}

variable "file_path_windows_client" {
  description = "File path for windows client"
  type        = string
}

variable "file_path_dns_server" {
  description = "File path for dns server"
  type        = string
}

variable "file_path_proxy_server" {
  description = "File path for proxy server"
  type        = string
}

variable "file_path_cloud9" {
  description = "File path for cloud9"
  type        = string
}

# -----------------------------
# private_ip
# -----------------------------
variable "private_ip_web_server" {
  description = "Private IP for web server"
  type        = string
}

variable "private_ip_windows_client" {
  description = "Private IP for windows client"
  type        = string
}

variable "private_ip_dns_server" {
  description = "Private IP for dns server"
  type        = string
}

variable "private_ip_proxy_server" {
  description = "Private IP for proxy server"
  type        = string
}

# -----------------------------
# public_ip
# -----------------------------
variable "public_ip_client" {
  description = "Public IP for client"
  type        = string
}
