# Writing Terraform configurations

## Use `locals` to specify explicit dependencies between resources

Helpful way to give a hint to Terraform that some resources should be deleted before even when there is no direct dependency in Terraform configurations.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Terraform 0.12 - Required vs Optional arguments

1. Required argument `index_document` must be set, if `var.website` is not an empty map.
2. Optional argument `error_document` can be omitted.

{% code title="main.tf" %}
```hcl
variable "website" {
  type    = map(string)
  default = {}
}

resource "aws_s3_bucket" "this" {
  # omitted...

  dynamic "website" {
    for_each = length(keys(var.website)) == 0 ? [] : [var.website]

    content {
      index_document = website.value.index_document
      error_document = lookup(website.value, "error_document", null)
    }
  }
}
```
{% endcode %}

{% code title="terraform.tfvars" %}
```hcl
website = {
  index_document = "index.html"
}
```
{% endcode %}

## Use `for_each` and `count` for different purposes

If you want to create multiple resources in a loop for each element in a list or map, always use `for_each`. It will save you if you want to remove some resources dependent on an element in the middle of a list. 

```hcl
resource "aws_instance" "this" {
  for_each = toset(var.availability_zones)
  availability_zone = each.value
  // ... other attributes
}
```
If you want to have resource only if a variable seted to true, use `count`
```hcl
resource "aws_instance" "vpn" {
  count = var.use_vpn ? 1 : 0
  // ... other attributes
}
```