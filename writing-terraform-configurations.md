# Pisanie konfiguracji Terraform

## Użyj zmiennych lokalnych (`locals`), aby określić jawne zależności między zasobami

Przydatny sposób na wskazanie Terraform, że niektóre zasoby powinny zostać usunięte wcześniej, nawet jeśli nie ma bezpośredniej zależności w konfiguracjach.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Terraform 0.12 - argumenty wymagane vs opcjonalne

1. Wymagany argument `index_document` musi być ustawiony, jeśli `var.website` nie jest pustą mapą.
2. Opcjonalny argument `error_document` można pominąć.

{% code title="main.tf" %}
```hcl
variable "website" {
  type    = map(string)
  default = {}
}

resource "aws_s3_bucket" "this" {
  # pomijamy...

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
