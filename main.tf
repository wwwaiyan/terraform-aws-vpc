module "vpc" {
  source                = "./modules/wy_vpc"
  project_name          = var.project_name
  env_prefix            = var.env_prefix
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidr    = var.public_subnet_cidr
  private_subnet_cidr   = var.private_subnet_cidr
  create_nat            = var.create_nat #if you want to create nat gateway for private subnet, you need to set public_subnet_cidr
  public_subnet_for_nat = var.public_subnet_for_nat
  azs                   = var.azs
}