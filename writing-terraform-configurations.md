# Writing Terraform configurations

## Use `locals` to specify explicit dependencies between resources

Helpful way to give a hint to Terraform that some resources should be deleted before even when there is no direct dependency in Terraform configurations.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Terraform 0.12 - Required vs Optional arguments

1. Required argument `index_document` must be set, if `var.website` is not an empty map.
1. Optional argument `error_document` can be omitted.

main.tf:
```
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

terraform.tfvars:
```
website = {
  index_document = "index.html"
}
```
