variable "vpc_subnet_cidr" {
  type        = string
  description = "CIDR range for the custom-mode VPC subnet in the deployment region."
  default     = "10.0.0.0/24"
}
