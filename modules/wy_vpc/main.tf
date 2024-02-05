locals {
  len_vpc               = length(var.vpc_cidr)
  len_public_subnet     = length(var.public_subnet_cidr)
  len_private_subnet    = length(var.private_subnet_cidr)
  public_subnet_for_nat = var.public_subnet_for_nat
  azs                   = length(var.azs) > 0 ? var.azs : data.aws_availability_zones.available.names
  create_nat            = var.create_nat
}
data "aws_availability_zones" "available" {
  state = "available"
}
resource "aws_default_vpc" "default" {
    #default_vpc
}
resource "aws_vpc" "vpc" {
  count      = local.len_vpc > 0 ? 1 : 0
  cidr_block = var.vpc_cidr
  tags = {
    Name        = "${var.project_name}-${var.env_prefix}-vpc"
    Project     = var.project_name
    Environment = var.env_prefix
  }
}
# public_subnet
resource "aws_subnet" "public_subnet" {
  count                   = local.len_public_subnet > 0 ? local.len_public_subnet : 0
  cidr_block              = var.public_subnet_cidr[count.index]
  vpc_id                  = aws_vpc.vpc[0].id
  availability_zone       = element(local.azs, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    Name        = "${var.project_name}-${var.env_prefix}-public_subnet-${count.index + 1}"
    Project     = var.project_name
    Environment = var.env_prefix
  }
}
resource "aws_internet_gateway" "igw" {
  count  = local.len_public_subnet > 0 ? 1 : 0
  vpc_id = aws_vpc.vpc[0].id
  tags = {
    Name        = "${var.project_name}-${var.env_prefix}-igw"
    Project     = var.project_name
    Environment = var.env_prefix
  }
}
resource "aws_route_table" "public_rt" {
  count  = local.len_public_subnet > 0 ? 1 : 0
  vpc_id = aws_vpc.vpc[0].id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[0].id
  }
  tags = {
    Name        = "${var.project_name}-${var.env_prefix}-public-rt"
    Project     = var.project_name
    Environment = var.env_prefix
  }
}
resource "aws_route_table_association" "public_rt_association" {
  count          = local.len_public_subnet > 0 ? local.len_public_subnet : 0
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt[0].id
}
# #private_subnet
resource "aws_subnet" "private_subnet" {
  count             = local.len_private_subnet > 0 ? local.len_private_subnet : 0
  cidr_block        = var.private_subnet_cidr[count.index]
  vpc_id            = aws_vpc.vpc[0].id
  availability_zone = element(local.azs, count.index)
  tags = {
    Name        = "${var.project_name}-${var.env_prefix}-private_subnet-${count.index + 1}"
    Project     = var.project_name
    Environment = var.env_prefix
  }
}
resource "aws_eip" "nat_eip" {
  count = local.create_nat && local.len_private_subnet > 0 && local.len_public_subnet > 0 ? 1 : 0
  tags = {
    Name        = "${var.project_name}-${var.env_prefix}-nat_eip"
    Project     = var.project_name
    Environment = var.env_prefix
  }
}
resource "aws_nat_gateway" "nat_gw" {
  count         = local.create_nat && local.len_private_subnet > 0 && local.len_public_subnet > 0 ? 1 : 0
  subnet_id     = aws_subnet.public_subnet[local.public_subnet_for_nat].id
  allocation_id = aws_eip.nat_eip[0].id
  depends_on    = [aws_eip.nat_eip]
  tags = {
    Name        = "${var.project_name}-${var.env_prefix}-nat_gw"
    Project     = var.project_name
    Environment = var.env_prefix
  }
}
resource "aws_route_table" "private_rt" {
  count  = local.len_private_subnet > 0 && length(aws_nat_gateway.nat_gw) > 0 ? 1 : 0
  vpc_id = aws_vpc.vpc[0].id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw[0].id
  }
  tags = {
    Name        = "${var.project_name}-${var.env_prefix}-private-rt"
    Project     = var.project_name
    Environment = var.env_prefix
  }
}
resource "aws_route_table_association" "private_rt_association" {
  count          = local.create_nat && local.len_public_subnet > 0 && local.len_private_subnet > 0 ? local.len_private_subnet : 0
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt[0].id
}