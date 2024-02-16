module "vpc1" {
  source                = "./modules/wy_vpc"
  project_name          = var.project_name
  env_prefix            = var.env_prefix1
  vpc_cidr              = var.vpc_cidr1
  public_subnet_cidr    = var.public_subnet_cidr1
  private_subnet_cidr   = var.private_subnet_cidr1
  create_nat            = var.create_nat #if you want to create nat gateway for private subnet, you need to set public_subnet_cidr
  public_subnet_for_nat = var.public_subnet_for_nat
  azs                   = var.azs
}
module "vpc2" {
  source                = "./modules/wy_vpc"
  project_name          = var.project_name
  env_prefix            = var.env_prefix2
  vpc_cidr              = var.vpc_cidr2
  public_subnet_cidr    = var.public_subnet_cidr2
  private_subnet_cidr   = var.private_subnet_cidr2
  create_nat            = var.create_nat #if you want to create nat gateway for private subnet, you need to set public_subnet_cidr
  public_subnet_for_nat = var.public_subnet_for_nat
  azs                   = var.azs
}