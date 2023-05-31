# Γράφοντας ρυθμίσεις για την Τerraform

## Χρησιμοποιήστε `locals` για να καθορίσετε ρητές εξαρτήσεις μεταξύ πόρων

Χρήσιμος τρόπος για να δώσετε μια υπόδειξη στην Terraform ότι κάποιοι πόροι πρέπει να διαγραφούν πριν, ακόμη και όταν δεν υπάρχει άμεση εξάρτηση στις ρυθμίσεις της Terraform.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Terraform 0.12 - Απαιτούμενα εναντίον Προαιρετικών ορισμάτων

1. Το Απαιτούμενο όρισμα `index_document` πρέπει να οριστεί, αν το `var.website` δεν είναι ένα κενό map.&#x20;
2. Το προαιρετικό όρισμα `error_document` μπορεί να παραληφθεί.

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
