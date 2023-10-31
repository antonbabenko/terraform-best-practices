# ٹیرافارم (Terraform)کنفیگریشنز لکھنا

## ریسورس  کے درمیان واضح تعلقات کو بیان کرنے کے لئے `locals` کا استعمال کریں۔

ٹیرافارم (Terraform)**کو اشارہ دینے کا مددگار طریقہ کہ کچھریسورس کو اس سے پہلے حذف کر دینا چاہیے جب کہ ٹیرافارم کنفیگریشنز میں براہ راست انحصار نہ ہو**۔

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Terraform 0.12 - مطلوبہ بمقابلہ اختیاری دلائل

1. &#x20;اگر `var.website` ایک خالی map نہیں ہے، تو ضروری ہے کہ argument `index_document` کو سیٹ کیا جائے۔
2. اختیاری argument `error_document` کو چھوڑا جا سکتا ہے۔

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
