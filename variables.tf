#vpc
variable "project_name" {
  description = "Project Name"
  type        = string
  default = "terraform_aws_vpc"
}
variable "env_prefix1" {
  description = "Environment Prefix"
  type        = string
  default = "one"
}
variable "env_prefix2" {
  description = "Environment Prefix"
  type        = string
  default = "two"
}
variable "vpc_cidr1" {
  description = "VPC CIDR"
  type        = string
  default = "10.90.0.0/16"
}
variable "vpc_cidr2" {
  description = "VPC CIDR"
  type        = string
  default = "11.90.0.0/16"
}
#availability_zone
variable "azs" {
  description = "Availability Zone"
  type        = list(string)
  default     = []
}
#public_subnet
variable "public_subnet_cidr1" {
  description = "Public Subnet CIDR"
  type        = list(string)
  default     = ["10.90.1.0/24", "10.90.2.0/24"]
}
variable "public_subnet_cidr2" {
  description = "Public Subnet CIDR"
  type        = list(string)
  default     = ["11.90.1.0/24", "11.90.2.0/24"]
}
variable "map_public_ip_on_launch" {
  description = "Map Public IP on Launch"
  type        = bool
  default     = true
}
#private_subnet
variable "private_subnet_cidr1" {
  description = "Private Subnet CIDR"
  type        = list(string)
  default     = ["10.90.3.0/24", "10.90.4.0/24"]
}
variable "private_subnet_cidr2" {
  description = "Private Subnet CIDR"
  type        = list(string)
  default     = ["11.90.3.0/24", "11.90.4.0/24"]
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