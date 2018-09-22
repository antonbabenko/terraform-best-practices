# Naming \(wip\)

## Naming

### Naming in modules - resource arguments, variables, outputs

### resource arguments:

1. Do not repeat resource type in resource id \(not partially, nor completely\)
   * Good: `resource "aws_route_table" "public" {}`
   * Bad: `resource "aws_route_table" "public_route_table" {}`
   * Bad: `resource "aws_route_table" "public_aws_route_table" {}`
2. Resource id should be named `this` if there is no more descriptive and general name available, or if resource module creates single resource of this type \(eg, there is single resource of type `aws_nat_gateway`, but multiple `aws_route_table`, so `aws_nat_gateway` can be named `this`, but `aws_route_table` should be more descriptive - like `private`, `public`, `database`\).
3. Include `count` argument inside resource blocks as the first argument at the top and separate by newline after it.

Good:

```text
   resource "aws_route_table" "public" {
     count = "2"

     vpc_id = "vpc-12345678"
     # ... remaining arguments omited
   }
```

Bad:

```text
   resource "aws_route_table" "public" {
     vpc_id = "vpc-12345678"
     count = "2"`

     # ... remaining arguments omited
   }
```

1. Include `tags` argument, if supported by resource as the last real argument, following my `depends_on` and `lifecycle`, if necessary. All of these should be separated by single empty line.

Good:

```text
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

```text
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

```text
   count = "${var.create_public_subnets}"
```

Good 2:

```text
   count = "${length(var.public_subnets) > 0 ? 1 : 0}"
```

Bad:

```text
   count = "${var.dont_need_public_subnets}"
```

1. To make inverted conditions don't introduce another variable unless really necessary, use `1 - boolean value`.

Good:

```text
   count = "${1 - var.create_public_subnets}"
```

1. Try to avoid using `-` inside resource ids and make it to match `a-z0-9`.
2. Use `-` inside arguments values and in places where value will be available to a human \(eg, inside DNS name of RDS instance\). Use `_` \(underscore\) in all other cases \(in resource names, data source name, variables, outputs, etc\). Names should be lowercase and include only letters and numbers.

## Styling

WIP

