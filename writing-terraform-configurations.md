# Terraform 구성(configurations) 작성하기

## `locals`를 사용해 리소스 간의 명시적 종속성 지정하기 <a href="#use-locals-to-specify-explicit-dependencies-between-resources" id="use-locals-to-specify-explicit-dependencies-between-resources"></a>

Terraform 구성(configurations)에 직접적인 의존성이 없는 경우에도 특정 리소스가 삭제되어야 함을 Terraform에 알려주는 유용한 방법입니다.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Terraform 0.12 - 필수적  vs 선택적 인수 <a href="#required-vs-optional-arguments" id="required-vs-optional-arguments"></a>

1. `var.website`가 빈 맵이 아닌 경우 필수적  인수 `index_document`를 반드시 설정해야 합니다.
2. 선택적 인수 `error_document`는 생략할 수 있습니다.

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
