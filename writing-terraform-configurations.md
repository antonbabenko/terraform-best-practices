# Terraform 設定ファイルの記述

## `locals` を使用してリソース間の明示的な依存関係を指定する

リソースの直接的な依存関係がTerraformの構成にない場合でも、Terraformに対していくつかのリソースを削除すべきことを示すための便利な方法です。

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Terraform 0.12 - Required 引数 vs Optional 引数

1. `var.website` が空のマップでない場合は、Required引数である `index_document` が設定されている必要があります。
2. Optional引数の `error_document` は省略可能です。

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
