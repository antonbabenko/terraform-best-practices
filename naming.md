# Naming conventions

## General conventions

{% hint style="info" %}
There should be no reason to not follow at least these :\)
{% endhint %}

1. Use `_` \(underscore\) instead of `-` \(dash\) in all: resource names, data source names, variable names, outputs.
  * Beware that actual cloud resources have many hidden restrictions in their naming conventions. Some cannot contain dashes, some must be camel cased. These conventions refer to Terraform names themselves.
2. Only use lowercase letters and numbers.

## Resource and data source arguments

1. Do not repeat resource type in resource name \(not partially, nor completely\):
   * Good: `resource "aws_route_table" "public" {}`
   * Bad: `resource "aws_route_table" "public_route_table" {}`
   * Bad: `resource "aws_route_table" "public_aws_route_table" {}`
2. Resource name should be named `this` if there is no more descriptive and general name available, or if resource module creates single resource of this type \(eg, there is single resource of type `aws_nat_gateway` and multiple resources of type`aws_route_table`, so `aws_nat_gateway` should be named `this` and `aws_route_table` should have more descriptive names - like `private`, `public`, `database`\).
3. Always use singular nouns for names.
4. Use `-` inside arguments values and in places where value will be exposed to a human \(eg, inside DNS name of RDS instance\).
5. Include `count` argument inside resource blocks as the first argument at the top and separate by newline after it. See [example](naming.md#usage-of-count).
6. Include `tags` argument, if supported by resource as the last real argument, following by `depends_on` and `lifecycle`, if necessary. All of these should be separated by single empty line. See [example](naming.md#placement-of-tags).
7. When using condition in `count` argument use boolean value, if it makes sense, otherwise use `length` or other interpolation. See [example](naming.md#conditions-in-count).
8. To make inverted conditions don't introduce another variable unless really necessary, use `1 - boolean value` instead. For example, `count = "${1 - var.create_public_subnets}"`

## Code examples of `resource`

### Usage of `count`

{% hint style="success" %}
{% code-tabs %}
{% code-tabs-item title="main.tf" %}
```text
resource "aws_route_table" "public" {
  count  = "2"

  vpc_id = "vpc-12345678"
  # ... remaining arguments omitted
}
```
{% endcode-tabs-item %}
{% endcode-tabs %}
{% endhint %}

{% hint style="danger" %}
{% code-tabs %}
{% code-tabs-item title="main.tf" %}
```text
resource "aws_route_table" "public" {
  vpc_id = "vpc-12345678"
  count  = "2"

  # ... remaining arguments omitted
}
```
{% endcode-tabs-item %}
{% endcode-tabs %}
{% endhint %}

### Placement of `tags`

{% hint style="success" %}
{% code-tabs %}
{% code-tabs-item title="main.tf" %}
```text
resource "aws_nat_gateway" "this" {
  count         = "1"

  allocation_id = "..."
  subnet_id     = "..."

  tags = {
    Name = "..."
  }

  depends_on = ["aws_internet_gateway.this"]

  lifecycle {
    create_before_destroy = true
  }
}   
```
{% endcode-tabs-item %}
{% endcode-tabs %}
{% endhint %}

{% hint style="danger" %}
{% code-tabs %}
{% code-tabs-item title="main.tf" %}
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
{% endcode-tabs-item %}
{% endcode-tabs %}
{% endhint %}

### Conditions in `count`

{% hint style="success" %}
* {% code-tabs %}
  {% code-tabs-item title="main.tf" %}
  ```text
  count = "${length(var.public_subnets) > 0 ? 1 : 0}"
  ```
  {% endcode-tabs-item %}
  {% endcode-tabs %}
* {% code-tabs %}
  {% code-tabs-item title="main.tf" %}
  ```
  count = "${var.create_public_subnets}"
  ```
  {% endcode-tabs-item %}
  {% endcode-tabs %}
{% endhint %}

## Variables

1. Don't reinvent the wheel in resource modules - use the same variable names, description and default as defined in "Argument Reference" section for the resource you are working on.
2. Omit `type = "list"` declaration if there is `default = []` also.
3. Omit `type = "map"` declaration if there is `default = {}` also.
4. Use plural form in name of variables of type `list`  and `map`.
5. When defining variables order the keys: `description` , `type`, `default` .
6. Always include `description` for all variables even if you think it is obvious.

## Outputs

Name for the outputs is important to make them consistent and understandable outside of its scope \(when user is using a module it should be obvious what type and attribute of the value is returned\).

1. The general recommendation for the names of outputs is that it should be descriptive for the value it contains and be less free-form than you would normally want.
2. Good structure for names of output looks like `{name}_{type}_{attribute}` , where:
   1. `{name}` is a resource or data source name without provider prefix. `{name}` for `aws_subnet` is `subnet`,  for`aws_vpc` it is `vpc`.
   2. `{type}` is a type of a resource sources
   3. `{attribute}` is an attribute returned by the output
   4. [See examples](naming.md#code-examples-of-output).
3. If output is returning a value with interpolation functions and multiple resources, the `{name}` and `{type}` there should be as generic as possible \(`this` is often the most generic and should be preferred\). [See example](naming.md#code-examples-of-output).
4. If the returned value is a list it should have plural name. [See example](naming.md#use-plural-name-if-the-returning-value-is-a-list).
5. Always include `description` for all outputs even if you think it is obvious.

### Code examples of `output`

Return at most one ID of security group:

{% hint style="success" %}
{% code-tabs %}
{% code-tabs-item title="outputs.tf" %}
```text
output "this_security_group_id" {
  description = "The ID of the security group"
  value       = "${element(concat(coalescelist(aws_security_group.this.*.id, aws_security_group.this_name_prefix.*.id), list("")), 0)}"
}
```
{% endcode-tabs-item %}
{% endcode-tabs %}
{% endhint %}

When there are multiple resources of the same type, `this` should be preferred and it should be part of name in output, also `another_security_group_id`  should be named `web_security_group_id`:

{% hint style="danger" %}
{% code-tabs %}
{% code-tabs-item title="outputs.tf" %}
```text
output "security_group_id" {
  description = "The ID of the security group"
  value       = "${element(concat(coalescelist(aws_security_group.this.*.id, aws_security_group.web.*.id), list("")), 0)}"
}

output "another_security_group_id" {
  description = "The ID of web security group"
  value       = "${element(concat(aws_security_group.web.*.id, list("")), 0)}"
}
```
{% endcode-tabs-item %}
{% endcode-tabs %}
{% endhint %}

### Use plural name if the returning value is a list

{% hint style="success" %}
{% code-tabs %}
{% code-tabs-item title="outputs.tf" %}
```text
output "this_rds_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = ["${aws_rds_cluster_instance.this.*.endpoint}"]
}
```
{% endcode-tabs-item %}
{% endcode-tabs %}
{% endhint %}

### Conditions in `output`

There are two resources of type `aws_db_instance`  with names `this` and `this_mssql` where at most one resource can be created at the same time.

{% hint style="success" %}
{% code-tabs %}
{% code-tabs-item title="outputs.tf" %}
```text
output "this_db_instance_id" {
  description = "The RDS instance ID"
  value       = "${element(concat(coalescelist(aws_db_instance.this_mssql.*.id, aws_db_instance.this.*.id), list("")), 0)}"
}
```
{% endcode-tabs-item %}
{% endcode-tabs %}
{% endhint %}

\*\*\*\*
