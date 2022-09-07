# Scrierea configurațiilor Terraform

## Utilizați `locals` pentru a specifica dependențe explicite între resurse

Un mod util de a da un indiciu pentru Terraform că unele resurse ar trebui șterse înainte chiar și atunci când nu există nicio dependență directă în configurațiile Terraform.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Terraform 0.12 - Argumente obligatorii vs argumente opționale

1. Argumentul obligatoriu `index_document` trebuie setat, dacă `var.website` nu este o hartă (map) goală.
2. Argumentul opțional `error_document` poate fi omis.

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
