# Escrevendo configurações do Terraform

## Use `locals` para especificar dependências explícitas entre recursos

Uma maneira útil de dar uma dica ao Terraform de que alguns recursos devem ser excluídos antes mesmo quando não houver dependência direta nas configurações do  Terraform.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Terraform 0.12 - Argumentos obrigarórios vs opcionais

1. O argumento obrigatório `index_document` deve ser definido, se `var.website` não for um mapa vazio.
2. O argumento opcional `error_document` pode ser omitido.

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
