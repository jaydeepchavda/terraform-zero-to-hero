output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

output "default_route_table" {
  value = aws_vpc.main.default_route_table_id
}

output "default_security_group" {
  value = aws_vpc.main.default_security_group_id
}