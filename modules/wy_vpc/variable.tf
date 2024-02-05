#vpc
variable "project_name" {
  description = "Project Name"
  type        = string
}
variable "env_prefix" {
  description = "Environment Prefix"
  type        = string
}
variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default = "10.90.0.0/16"
}
#availability_zone
variable "azs" {
  description = "Availability Zone"
  type        = list(string)
  default     = []
}
#public_subnet
variable "public_subnet_cidr" {
  description = "Public Subnet CIDR"
  type        = list(string)
  default     = []
}
variable "map_public_ip_on_launch" {
  description = "Map Public IP on Launch"
  type        = bool
  default     = true
}
#private_subnet
variable "private_subnet_cidr" {
  description = "Private Subnet CIDR"
  type        = list(string)
  default     = []
}
variable "create_nat" {
  description = "Create NAT Gateway"
  type        = bool
  default     = false
}
variable "public_subnet_for_nat" {
  description = "Public Subnet for NAT Gateway"
  type        = number
  default     = 0
}