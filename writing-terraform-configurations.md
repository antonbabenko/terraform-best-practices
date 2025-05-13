# Writing Terraform configurations

## Use `locals` to specify explicit dependencies between resources

Helpful way to give a hint to Terraform that some resources should be deleted before even when there is no direct dependency in Terraform configurations.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Terraform 0.12 - Required vs Optional arguments

1. Required argument `index_document` must be set, if `var.website` is not an empty map.
2. Optional argument `error_document` can be omitted.

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

## Managing Secrets in Terraform

Secrets are sensitive data that can be anything from passwords and encryption keys to API tokens and service certificates. They are typically used to set up authentication and authorization for cloud resources. Safeguarding these sensitive resources is crucial because exposure could lead to security breaches. It’s highly recommended to avoid storing secrets in Terraform config and state, as anyone with access to version control can access them. Instead, consider using external data sources to fetch secrets from external sources at runtime. For instance, if you’re using AWS Secrets Manager, you can use the `aws_secretsmanager_secret_version` data source to access the secret value. The following example uses write-only arguments, which are supported in Terraform 1.11+, and keep the value out of Terraform state.


{% code title="main.tf" %}
```hcl
# Fetch the secret’s metadata
data "aws_secretsmanager_secret" "db_password" {
  name = "my-database-password"
}

# Get the latest secret value
data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = data.aws_secretsmanager_secret.db_password.id
}

# Use the secret without persisting it to state
resource "aws_db_instance" "example" {
  engine         = "mysql"
  instance_class = "db.t3.micro"
  name           = "exampledb"
  username       = "admin"

  # write-only: Terraform sends it to AWS then forgets it
  password_wo = data.aws_secretsmanager_secret_version.db_password.secret_string
```
{% endcode %}

