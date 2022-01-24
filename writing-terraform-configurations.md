# Ecrire des configurations Terraform

## Utilisez `locals` pour spécifier des dépendances explicites entre les ressources

Moyen utile d'indiquer à Terraform que certaines ressources doivent être supprimées au préalable  lorsqu'il n'y a pas de dépendance directe dans les configurations Terraform.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Terraform 0.12 - Arguments réquis ou optionnels

1. L'argument obligatoire `index_document`doit être défini, si `var.website` n'est pas une map vide.
2. L'argument optionnel `error_document` peut être omis.

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
