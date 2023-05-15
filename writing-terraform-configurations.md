# 编写Terraform配置

## 使用 `locals` 指定资源之间的显式依赖关系

这是一种有用的方法，可以向Terraform提供提示，即使在Terraform配置中没有直接依赖关系，某些资源也应该在其它资源之前被删除。

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Terraform 0.12 - 必需参数与可选参数

1. 如果`var.website`不是一个空的map，则必须设置必需参数 `index_document`。
2. 可选参数`error_document`可以省略。

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
