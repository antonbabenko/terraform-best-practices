# Menulis Konfigurasi Terraform

## Gunakan `locals` untuk menetapkan dependensi antar sumber daya secara eksplisit

Hal ini merupakan cara yang baik untuk memberi petunjuk kepada Terraform bahwa beberapa sumber daya seharusnya dihapus terlebih dahulu bahkan ketika tidak ada dependensi langsung di dalam konfigurasi Terraform.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Terraform 0.12 - Argumen wajib dan pilihan

1. Argumen wajib `index_document` harus diisi jika `var.website` bukanlah _map_ kosong
2. Argumen pilihan `error_document` bisa diabaikan

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
