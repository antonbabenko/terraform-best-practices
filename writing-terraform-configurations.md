# टेराफ़ॉर्म कॉन्फ़िगरेशन लिखना

## संसाधनों के बीच स्पष्ट निर्भरता निर्दिष्ट करने के लिए `locals` का प्रयोग करें

टेराफॉर्म को संकेत देने का मददगार तरीका कि टेराफॉर्म कॉन्फ़िगरेशन में कोई प्रत्यक्ष निर्भरता न होने पर भी कुछ संसाधनों को पहले हटा दिया जाना चाहिए।

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## टेराफॉर्म 0.12 - आवश्यक बनाम वैकल्पिक तर्क&#x20;

1. आवश्यक तर्क index\_document सेट किया जाना चाहिए, यदि var.website एक खाली नक्शा नहीं है।
2. वैकल्पिक तर्क `error_document` छोड़ा जा सकता है।

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
