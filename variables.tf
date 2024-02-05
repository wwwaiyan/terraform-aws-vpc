#vpc
variable "project_name" {
  description = "Project Name"
  type        = string
  default = "terraform_aws_vpc"
}
variable "env_prefix" {
  description = "Environment Prefix"
  type        = string
  default = "test"
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
  default     = ["10.90.1.0/24", "10.90.2.0/24"]
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