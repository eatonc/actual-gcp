variable "actual_fqdn" {
  type        = string
  description = "FQDN of actual server to use for certificate generation"
}

variable "container_host_network_tags" {
  type        = list(string)
  description = "List of network tags to add for firewall rules"
}

variable "duckdns_subdomains" {
  type        = string
  description = "Comma-delimited list of DuckDNS subdomains"
}

variable "duckdns_token" {
  type        = string
  description = "Authentication token for DuckDNS"
}

variable "public_key_path" {
  type    = string
  default = "~/.ssh/id_gcp_ed25519.pub"
}

variable "public_key" {
  type        = string
  description = "SSH public key to use if public key file doesn't exist (if running in HCP Terraform)"
  default     = ""
}

variable "user" {
  type = string
}

variable "vm_image_family" {
  type        = string
  description = "Family of image to use with VM creation"
}

variable "vm_image_project" {
  type        = string
  description = "Project to which the image belongs."
}

variable "vm_size" {
  type        = string
  description = "VM instance type."
}
