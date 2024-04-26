# Writing Terraform configurations

## Use `locals` to specify explicit dependencies between resources

Helpful way to give a hint to Terraform that some resources should be deleted before even when there is no direct dependency in Terraform configurations.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Use only one ternary operator in a single variable assignment.

Terraform ternary operator `count = var.enable ? 1 : 0` has been inherited from other programming languages. Its goal in programming languages is to avoid multi-line if/else statements for a simple if/else condition. It Terraform we don't have a multi-line alternative for the ternary operator

Split your complex conditions into multiple `locals` with a reasonable name instead of using a long ternary operator nesting for reliability.

```hcl
# Hard to read and maintain
locals {
  container_definitions = var.add_logging ? concat(container_definitions, var.use_fluentbit ? local.inhouse_logging_sidecar : local.fluentbit_sidecar) : var.container_definitions
}

# Easier to read and maintain
locals {
  logging_container     = var.use_fluentbit ? local.inhouse_logging_sidecar : local.fluentbit_sidecar
  container_definitions = var.add_logging ? concat(container_definitions, logging_container, ) : var.container_definitions
}

resource "aws_ecs_task_definition" "this" {
  container_definitions = local.container_definitions
  // ... other attributes
}
```

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
