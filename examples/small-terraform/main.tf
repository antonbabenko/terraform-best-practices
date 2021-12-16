locals {
  create_vpc = var.vpc_id == ""
}

data "aws_vpc" "selected" {
  count = local.create_vpc ? 0 : 1

  id = var.vpc_id
}

resource "aws_vpc" "this" {
  count = local.create_vpc ? 1 : 0

  cidr_block = var.cidr
}

resource "aws_internet_gateway" "this" {
  vpc_id = try(data.aws_vpc.selected[0].id, aws_vpc.this[0].id)
}
