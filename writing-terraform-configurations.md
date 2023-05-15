# كتابة ملفات أداة Terraform

## استعمل locals لتحديد الاعتماديات الصريحة بين الموارد

من الطرق المساعدة لإخبار Terraform أنه يجب حذف بعض الموارد حتى عندما لا يوجد اعتمادية مباشرة عليها&#x20;

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## &#x20;إصدار Terraform 0.12 - الوسيطات الإجبارية والاختيارية&#x20;

1. الوسيط `index_document`هو وسيط إجباري يجب تحديده، إذا كانت`var.website`ليست`map`فارغة
2. الوسيط `error_document`هو وسيط اختياري من الممكن عدم ذكره

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
