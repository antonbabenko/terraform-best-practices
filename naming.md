# Naming conventions

## General conventions

{% hint style="info" %}
There should be no reason to not follow at least these conventions :)
{% endhint %}

{% hint style="info" %}
Beware that actual cloud resources often have restrictions in allowed names. Some resources, for example, can't contain dashes, some must be camel-cased. The conventions in this book refer to Terraform names themselves.
{% endhint %}

1. Use `_` (underscore) instead of `-` (dash) everywhere (in resource names, data source names, variable names, outputs, etc).
2. Prefer to use lowercase letters and numbers (even though UTF-8 is supported).

## Resource and data source arguments

1. Do not repeat resource type in resource name (not partially, nor completely):

{% hint style="success" %}
```
`resource "aws_route_table" "public" {}`
```
{% endhint %}

{% hint style="danger" %}
```
`resource "aws_route_table" "public_route_table" {}`
```
{% endhint %}

{% hint style="danger" %}
```
`resource "aws_route_table" "public_aws_route_table" {}`
```
{% endhint %}

2. Resource name should be named `this` if there is no more descriptive and general name available, or if the resource module creates a single resource of this type (eg, in [AWS VPC module](https://github.com/terraform-aws-modules/terraform-aws-vpc) there is a single resource of type `aws_nat_gateway` and multiple resources of type`aws_route_table`, so `aws_nat_gateway` should be named `this` and `aws_route_table` should have more descriptive names - like `private`, `public`, `database`).
3. Always use singular nouns for names.
4. Use `-` inside arguments values and in places where value will be exposed to a human (eg, inside DNS name of RDS instance).
5. Include argument `count` / `for_each` inside resource or data source block as the first argument at the top and separate by newline after it.
6. Include argument `tags,` if supported by resource, as the last real argument, following by `depends_on` and `lifecycle`, if necessary. All of these should be separated by a single empty line.
7. When using conditions in an argument`count` / `for_each` prefer boolean values instead of using `length` or other expressions.

## Code examples of `resource`

### Usage of `count` / `for_each`

{% hint style="success" %}
{% code title="main.tf" %}
```hcl
resource "aws_route_table" "public" {
  count = 2

  vpc_id = "vpc-12345678"
  # ... remaining arguments omitted
}

resource "aws_route_table" "private" {
  for_each = toset(["one", "two"])

  vpc_id = "vpc-12345678"
  # ... remaining arguments omitted
}
```
{% endcode %}
{% endhint %}

{% hint style="danger" %}
{% code title="main.tf" %}
```hcl
resource "aws_route_table" "public" {
  vpc_id = "vpc-12345678"
  count  = 2

  # ... remaining arguments omitted
}
```
{% endcode %}
{% endhint %}

### Placement of `tags`

{% hint style="success" %}
{% code title="main.tf" %}
```hcl
resource "aws_nat_gateway" "this" {
  count = 2

  allocation_id = "..."
  subnet_id     = "..."

  tags = {
    Name = "..."
  }

  depends_on = [aws_internet_gateway.this]

  lifecycle {
    create_before_destroy = true
  }
}   
```
{% endcode %}
{% endhint %}

{% hint style="danger" %}
{% code title="main.tf" %}
```hcl
resource "aws_nat_gateway" "this" {
  count = 2

  tags = "..."

  depends_on = [aws_internet_gateway.this]

  lifecycle {
    create_before_destroy = true
  }

  allocation_id = "..."
  subnet_id     = "..."
}
```
{% endcode %}
{% endhint %}

### Conditions in `count`

{% hint style="success" %}
{% code title="outputs.tf" %}
```hcl
resource "aws_nat_gateway" "that" {    # Best
  count = var.create_public_subnets ? 1 : 0
}

resource "aws_nat_gateway" "this" {    # Good
  count = length(var.public_subnets) > 0 ? 1 : 0
}
```
{% endcode %}
{% endhint %}

## Variables

1. Don't reinvent the wheel in resource modules: use `name`, `description`, and `default` value for variables as defined in the "Argument Reference" section for the resource you are working with.
2. Support for validation in variables is rather limited (e.g. can't access other variables or do lookups). Plan accordingly because in many cases this feature is useless.
3. Use the plural form in a variable name when type is `list(...)` or `map(...)`.
4. Order keys in a variable block like this: `description` , `type`, `default`, `validation`.
5. Always include `description` on all variables even if you think it is obvious (you will need it in the future).
6. Prefer using simple types (`number`, `string`, `list(...)`, `map(...)`, `any`) over specific type like `object()` unless you need to have strict constraints on each key.
7. Use specific types like `map(map(string))` if all elements of the map have the same type (e.g. `string`) or can be converted to it (e.g. `number` type can be converted to `string`).
8. Use type `any` to disable type validation starting from a certain depth or when multiple types should be supported.
9. Value `{}` is sometimes a map but sometimes an object. Use `tomap(...)` to make a map because there is no way to make an object.

## Outputs

Make outputs consistent and understandable outside of its scope (when a user is using a module it should be obvious what type and attribute of the value it returns).

1. The name of output should describe the property it contains and be less free-form than you would normally want.
2. Good structure for the name of output looks like `{name}_{type}_{attribute}` , where:
   1. `{name}` is a resource or data source name
      * `{name}` for `data "aws_subnet" "private"` is `private`
      * `{name}` for `resource "aws_vpc_endpoint_policy" "test"` is `test`
   2. `{type}` is a resource or data source type without a provider prefix
      * `{type}` for `data "aws_subnet" "private"` is `subnet`
      * `{type}` for `resource "aws_vpc_endpoint_policy" "test"` is `vpc_endpoint_policy`
   3. `{attribute}` is an attribute returned by the output
   4. [See examples](naming.md#code-examples-of-output).
3. If the output is returning a value with interpolation functions and multiple resources, `{name}` and `{type}` there should be as generic as possible (`this` as prefix should be omitted). [See example](naming.md#code-examples-of-output).
4. If the returned value is a list it should have a plural name. [See example](naming.md#use-plural-name-if-the-returning-value-is-a-list).
5. Always include `description` for all outputs even if you think it is obvious.
6. Avoid setting `sensitive` argument unless you fully control usage of this output in all places in all modules.
7. Prefer `try()` (available since Terraform 0.13) over `element(concat(...))` (legacy approach for the version before 0.13)

### Code examples of `output`

Return at most one ID of security group:

{% hint style="success" %}
{% code title="outputs.tf" %}
```hcl
output "security_group_id" {
  description = "The ID of the security group"
  value       = try(aws_security_group.this[0].id, aws_security_group.name_prefix[0].id, "")
}
```
{% endcode %}
{% endhint %}

When having multiple resources of the same type, `this` should be omitted in the name of output:

{% hint style="danger" %}
{% code title="outputs.tf" %}
```hcl
output "this_security_group_id" {
  description = "The ID of the security group"
  value       = element(concat(coalescelist(aws_security_group.this.*.id, aws_security_group.web.*.id), [""]), 0)
}
```
{% endcode %}
{% endhint %}

### Use plural name if the returning value is a list

{% hint style="success" %}
{% code title="outputs.tf" %}
```hcl
output "rds_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = aws_rds_cluster_instance.this.*.endpoint
}
```
{% endcode %}
{% endhint %}
