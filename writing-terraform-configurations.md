# Schreiben von Terraform-Konfigurationen

## Verwenden Sie `locals`, um explizite Abhängigkeiten zwischen Ressourcen zu spezifizieren

Hilfreiche Möglichkeit, Terraform einen Hinweis zu geben, dass einige Ressourcen vorher gelöscht werden sollten, auch wenn es keine direkte Abhängigkeit in Terraform-Konfigurationen gibt.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Terraform 0.12 - Erforderliche und optionale Argumente

1. Das erforderliche Argument `index_document` muss gesetzt werden, wenn `var.website` keine leere `map()` ist.
2. Das optionale Argument `error_document` kann weggelassen werden.

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
