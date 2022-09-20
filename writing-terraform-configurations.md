# Terraform Konfigürasyonu Yazma

## Kaynaklar arasındaki açık bağımlılıkları belirtmek için `locals` kullanın

Terraform konfigürasyonlarında doğrudan bağımlılık olmasa bile bazı kaynakların daha önce silinmesi gerektiğine dair Terraform'a bir ipucu vermenin yararlı yolu.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Terraform 0.12 - Zorunlu Zorunlu(Requiered) vs. Opsiyonel(Optional) Argümanlar

1. `var.website` boş bir map değilse, zorunlu argüman `index_document` ayarlanmalıdır.
2. İsteğe bağlı argüman `error_document` göz ardı edilebilir

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
