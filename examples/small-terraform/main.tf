provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    key = "small-terraform/terraform.tfstate"
    # ...
  }
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

module "iam_user" {
  source = "terraform-aws-modules/iam/aws"

  name          = "anton"
  force_destroy = true

  pgp_key = "keybase:me"

  password_reset_required = false
}

resource "aws_iam_group_membership" "team" {
  name = "tf-testing-group-membership"

  group = "my-group"

  users = [
    "${module.iam_user.this_iam_user_name}",
  ]
}
