module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "v1.44.0"

  name = "${var.name}"

  cidr = "${var.cidr}"

  public_subnets = "${var.public_subnets}"
}
