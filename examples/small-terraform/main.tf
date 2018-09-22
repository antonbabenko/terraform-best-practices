provider "aws" {
  region = "eu-west-1"
}

locals {
  create_vpc = "${var.vpc_id == "" ? 1 : 0}"
}

data "aws_vpc" "selected" {
  count = "${1 - local.create_vpc}"

  id = "${var.vpc_id}"
}

resource "aws_vpc" "this" {
  count = "${local.create_vpc}"

  cidr_block = "${var.cidr}"
}

resource "aws_internet_gateway" "selected" {
  count = "${1 - local.create_vpc}"

  vpc_id = "${data.aws_vpc.selected.id}"
}

resource "aws_internet_gateway" "this" {
  count = "${local.create_vpc}"

  vpc_id = "${aws_vpc.this.id}"
}
