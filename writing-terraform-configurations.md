# Pisanje Terraform konfiguracija

## Korisite `locals` Da bi specificirali ekspicitne zavisnosti izmedju resursa

Koristan nacin da ukazete Terrafromu da bi neki resurs trebao biti izbrisan cak i kad nema direktne zavisnosti u Terrafrom konfiguraciji.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Terraform 0.12 - Zahtijevani vs Opcionalni arguments

1. Zahtjevani argument `index_document` mora biti postavljen, ako `var.website` nije prazan.
2. Opcioni argumenti `error_document` mogu biti izostavljeni.

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
