# Terraform კონფიგურაციის წერა

## გამოიყენეთ `locals` რესურსებს შორის აშკარა დამოკიდებულების დასაზუსტებლად

სასარგებლო გზა Terraform-ისთვის მინიშნებას მისაცემად, რომ ზოგიერთი რესურსი მანამდე უნდა წაიშალოს მაშინაც კი, როცა Terraform-ის კონფიგურაციებში პირდაპირი დამოკიდებულება არ არსებობს.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Terraform 0.12 - საჭირო vs არჩევითი არგუმენტები

1. საჭირო არგუმენტი `index_document` უნდა იყოს არჩეული თუ `var.website` არ არის ცარიელი map.
2. არჩევითი არგუმენტი `error_document` შეიძლება გამოტოვოთ.

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
