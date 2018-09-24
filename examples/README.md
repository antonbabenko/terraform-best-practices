# Code structure examples

## Terraform code structures

{% hint style="info" %}
These examples are showing AWS provider but the majority of principles showed in the examples can be applied to other public cloud providers as well as other kind of providers \(DNS, DB, Monitoring, etc\)
{% endhint %}

| Type | Description | Readiness |
| :--- | :--- | :--- |
| [small](terraform-1/terraform.md#terraform-small) | Few resources, no external dependencies. Single AWS account. Single region. Single environment. | Yes |
| [medium](terraform-1/terraform.md#terraform-medium) | Several AWS accounts and environments, off-the-shelf infrastructure modules using Terraform. | Yes |
| [large](https://github.com/antonbabenko/terraform-best-practices/tree/5957e997ea023df0f5b27891cef944be74b45706/examples/large-terraform/README.md) | Many AWS accounts, many regions, urgent need to reduce copy-paste, custom infrastructure modules, heavy usage of compositions. Using Terraform. | WIP |
| [very-large](https://github.com/antonbabenko/terraform-best-practices/tree/5957e997ea023df0f5b27891cef944be74b45706/examples/very-large-terraform/README.md) | Several providers \(AWS, GCP, Azure\). Multi-cloud deployments. Using Terraform. | No |

## Terragrunt code structures

| Type | Description | Readiness |
| :--- | :--- | :--- |
| [medium](https://github.com/antonbabenko/terraform-best-practices/tree/5957e997ea023df0f5b27891cef944be74b45706/examples/medium-terragrunt/README.md) | Several AWS accounts and environments, off-the-shelf infrastructure modules, composition pattern using Terragrunt. | No |
| [large](https://github.com/antonbabenko/terraform-best-practices/tree/5957e997ea023df0f5b27891cef944be74b45706/examples/large-terragrunt/README.md) | Many AWS accounts, many regions, urgent need to reduce copy-paste, custom infrastructure modules, heavy usage of compositions. Using Terragrunt. | No |
| [very-large](https://github.com/antonbabenko/terraform-best-practices/tree/5957e997ea023df0f5b27891cef944be74b45706/examples/very-large-terragrunt/README.md) | Several providers \(AWS, GCP, Azure\). Multi-cloud deployments. Using Terragrunt. | No |

### 

