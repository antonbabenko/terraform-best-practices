# Use `local.vpc_id` to give a hint to Terraform that subnets should be deleted before secondary CIDR blocks can be free!
locals {
  vpc_id = "${element(concat(aws_vpc_ipv4_cidr_block_association.this.*.vpc_id, aws_vpc.this.*.id, list("")), 0)}"
}

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
  # ...
}

resource "aws_vpc_ipv4_cidr_block_association" "this" {
  vpc_id     = "${aws_vpc.this.id}"
  cidr_block = "10.1.0.0/16"
  # ...
}

resource "aws_subnet" "public" {
  vpc_id     = "${local.vpc_id}"
  cidr_block = "10.1.0.0/24" # This CIDR belongs to secondary cidr_block defined in aws_vpc_ipv4_cidr_block_association
  # ...
}
