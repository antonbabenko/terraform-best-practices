# Scrivere configurazioni Terraform

## Usa `locals` per specificare dipendenze esplicite tra le risorse

È una maniera per aiutare Terraform, in modo che capisce che alcune risorse dovrebbero essere cancellate per prima anche se non c'è una dipendenza diretta nelle configurazioni Terraform.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Terraform 0.12 - Argomenti richiesti vs opzionali

1. Argomenti richiesti `index_document` devono essere settati, se `var.website` non è una map vuota.
2. Argomenti Opzionali `error_document` può essere omesso.

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
