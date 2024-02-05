output "vpc" {
  # value =  local.create_vpc ? flatten(aws_vpc.vpc[0]) : flatten(aws_default_vpc.default)
  value = aws_vpc.vpc
}
output "public_subnet_ids" {
    value = aws_subnet.public_subnet[*].id
}
output "private_subnet_ids" {
    value = aws_subnet.private_subnet[*].id
}