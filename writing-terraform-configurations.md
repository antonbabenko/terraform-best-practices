# כתיבת קונפיגורציות של Terraform

## השתמש ב `locals` כדי לציין תלות מפורשת בין משאבים

דרך מעולה לתת רמז ל  Terraform שיש למחוק כמה משאבים לפני משאבים אחרים. גם כאשר אין תלות ישירה בקונפיגורציה.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Terraform 0.12 - ארגומנטים נדרשים לעומת אופציונליים

1. Required argument `index_document` must be set, if `var.website` is not an empty map.&#x20;
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
