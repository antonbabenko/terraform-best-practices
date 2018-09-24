output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${module.network.vpc_id}"
}
