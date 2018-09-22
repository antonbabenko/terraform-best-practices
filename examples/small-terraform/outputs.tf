output "this_vpc_id" {
  description = "The ID of the VPC"
  value       = "${coalescelist(data.aws_vpc.selected.*.id, aws_vpc.this.*.id)}"
}
