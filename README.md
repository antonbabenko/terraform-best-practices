# Terraform best practices for writing modules

This document is an attempt to systematically describe key points in writing good reusable Terraform modules. 

Author: Anton Babenko
Date: 27.11.2017

### STATUS: Requires proof-reading, corrections, additions, not ready for public yet :)


## Terms of content
1. Concepts
1. Examples of directory structure
1. Naming
1. Styling

## Concepts
There are these key concepts:
* Resource
* Resource module
* Infrastructure module
* Composition
* Data sources
* Remote state
* Provider, provisioner, etc

### Resource
Resource is `aws_vpc`, `aws_db_instance`, etc. Resource belongs to provider, accepts arguments, outputs attributes.

### Resource module
Resource module is a collection of connected resources which together perform the common action (for eg, [AWS VPC Terraform module](terraform-aws-vpc) creates VPC, subnets, NAT gateway, etc). It depends on provider configuration, which can be defined in it, or in higher level structures (eg, infrastructure module).

### Infrastructure module
Infrastructure module is a collection of resource modules, which can be logically not connected, but in current situation/project/setup are serving the same purpose. It defines configuration for providers, which is passed to the downstream resource modules and to resources. It is normally limited to work in one entity per logical separator (eg, AWS Region, Google Project)

### Composition
Composition is a collection of infrastructure modules, which can span across several logically separated areas (eg., AWS Regions, several AWS accounts). Composition is used to describe the complete infrastructure required for the whole organization/project. 

Composition consists of infrastructure modules, which consist of resources modules, which implement individual resources.

### Data source
Since data source performs read-only operation and is dependant on provider configuration, it is used in a resource module or an infrastructure module.

Data source `terraform_remote_state` acts as a glue for higher level modules and compositions. 

### Remote state
Infrastructure modules and compositions should persist their state in a remote location which can be reached by others in a controllable way (ACL, versioning, logging).

### Provider, provisioner, etc
Providers, provisioners and few other terms are described very well on the official documentation and there is no point to repeat it here. To my opinion they have little to do with writing good Terraform modules.

## Why so difficult?
While individual resources are like atoms in the infrastructure, resource module is a molecule. It is a smallest versioned and shareable unit. It has exact list of arguments, implement basic logic for such unit to do required function. Eg. terraform-aws-security-group creates aws_security_group and aws_security_group_list based on dynamic input. This resource module by itself can be used together with other modules to create infrastructure module.

Access between molecules (resource modules and infrastructure modules) is performed using data sources.

## Example of directory structure of composition

```
.
├── README.md
├── ...

112213 directories, 122110 files
```


## Naming

### Naming in modules - resource arguments, variables, outputs

### resource arguments:

1. Do not repeat resource type in resource id (not partially, nor completely)

Good: `resource "aws_route_table" "public" {}`
Bad: `resource "aws_route_table" "public_route_table" {}`
Bad: `resource "aws_route_table" "public_aws_route_table" {}`

1. Resource id should be named `this` if there is no more descriptive and general name available, or if resource module creates single resource of this type (eg, there is single resource of type `aws_nat_gateway`, but multiple `aws_route_table`, so `aws_nat_gateway` can be named `this`, but `aws_route_table` should be more descriptive).

1. Include `count` argument inside resource blocks as the first argument at the top and separate by newline after it.

Good:
```
resource "aws_route_table" "public" {
  count = "2"`
  
  vpc_id = "vpc-12345678"
  # ... remaining arguments omited
}
```
Bad:
```
resource "aws_route_table" "public" {
  vpc_id = "vpc-12345678"
  count = "2"`
  
  # ... remaining arguments omited
}
```

1. Include `tags` argument, if supported by resource as the last real argument, following my `depends_on` and `lifecycle`, if necessary. All of these should be separated by single empty line.

Good:
```
resource "aws_nat_gateway" "this" {
  count = "1"

  allocation_id = "..."
  subnet_id     = "..."

  tags = "..."

  depends_on = ["aws_internet_gateway.this"]
  
  lifecycle {
    create_before_destroy = true
  }
}
```

Bad:
```
resource "aws_nat_gateway" "this" {
  count = "1"

  tags = "..."

  depends_on = ["aws_internet_gateway.this"]
  
  lifecycle {
    create_before_destroy = true
  }
  
  allocation_id = "..."
  subnet_id     = "..."
}
```

1. When using condition in `count` argument use boolean value, if it makes sense, otherwise use `length` or other interpolation.
Good 1:
```
count = "${var.create_public_subnets}"
```

Good 2:
```
count = "${length(var.public_subnets) > 0 ? 1 : 0}"
```

Bad:
```
count = "${var.dont_need_public_subnets}"
```

1. To make inverted conditions don't introduce another variable unless really necessary, use `1 - boolean value`.
Good:
```
count = "${1 - var.create_public_subnets}"
```

1. Try to avoid using `-` inside resource ids and make it to match `a-z0-9_`.

1. 

## Styling
