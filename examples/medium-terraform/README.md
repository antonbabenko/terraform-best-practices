# Small-size infrastructure

## Use-case

This directory contains code as an example of structuring Terraform configurations for a medium-size infrastructure with several AWS accounts, off-the-shelf infrastructure modules, composition pattern.

Everything is simple and a good start for proof of concepts and hobby projects.

## Features

This code illustrates how it is possible to:
1. Create new VPC and Internet Gateway
1. Specify existing VPC and attach Internet Gateway to is 

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| azs | A list of availability zones in the region | list | `<list>` | no |
| cidr | The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden | string | `0.0.0.0/0` | no |
| name | Name to be used on all the resources as identifier | string | `` | no |
| public_subnets | A list of public subnets inside the VPC | list | `<list>` | no |
| vpc_id | Existing VPC to use (specify this, if you don't want to create new VPC) | string | `` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | The ID of the VPC |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
