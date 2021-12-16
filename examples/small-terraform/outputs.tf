output "vpc_id" {
  description = "ID of the VPC"
  value       = try(data.aws_vpc.selected[0].id, aws_vpc.this[0].id)
}
