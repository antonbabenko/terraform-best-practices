# Написання конфігурацій Terraform

## Використовуйте `locals` щоб вказати явні залежності між ресурсами

Корисний спосіб дати підказку Terraform про те, що деякі ресурси слід видаляти раніше, навіть якщо немає прямої залежності в конфігураціях Terraform.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Terraform 0.12 - Обов’язкові та необов’язкові аргументи

1. Обов'язковий аргумент `index_document`необхідно встановити, якщо `var.website -` це не порожній map
2. Необов'язковий аргумент`error_document` можна пропустити.

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
