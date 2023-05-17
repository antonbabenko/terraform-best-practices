# ಟೆರ್ರಾಫಾರ್ಮ್ ಕಾಂಫಿಗುರೇಶನ್ ಗಳನ್ನು ಬರೆಯುವ ಬಗ್ಗೆ

## ಸಂಪನ್ಮೂಲಗಳ ನಡುವೆ ಸ್ಪಷ್ಟವಾದ ಅವಲಂಬನೆಗಳನ್ನು ನಿರ್ದಿಷ್ಟಪಡಿಸಲು  `locals(`ಲೋಕಲ್ಸ್)ಅನ್ನು ಬಳಸಿ

ಟೆರ್ರಾಫಾರ್ಮ್ ಕಾಂಫಿಗುರೇಶನ್ ಗಳಲ್ಲಿ ಯಾವುದೇ ನೇರ ಅವಲಂಬನೆ ಇಲ್ಲದಿರುವಾಗಲೂ ಕೆಲವು ಸಂಪನ್ಮೂಲಗಳನ್ನು ಮೊದಲು ಅಳಿಸಬೇಕು ಎಂದು ಟೆರಾಫಾರ್ಮ್‌ಗೆ ಸುಳಿವು ನೀಡಲು ಸಹಾಯಕವಾದ ಮಾರ್ಗ.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## ಟೆರಾಫಾರ್ಮ್ 0.12 - ಅಗತ್ಯ ಮತ್ತು ಐಚ್ಛಿಕ ಆರ್ಗ್ಯುಮೆಂಟ್‌ಗಳು

1. `var.website`ಖಾಲಿ ನಕ್ಷೆಯಾಗಿರದಿದ್ದರೆ,ಅಗತ್ಯವಿರುವ ಆರ್ಗ್ಯುಮೆಂಟ್t `index_document`ಅನ್ನು ಸೆಟ್ ಮಾಡಬೇಕು.
2. ಐಚ್ಛಿಕ ಆರ್ಗ್ಯುಮೆಂಟ್ `error_document` ಅನ್ನು ಬಿಟ್ಟುಬಿಡಬಹುದು.

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
