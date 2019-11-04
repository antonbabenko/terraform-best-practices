# Code structure examples

## Terraform code structures

{% hint style="info" %}
These examples are showing AWS provider but the majority of principles showed in the examples can be applied to other public cloud providers as well as other kind of providers \(DNS, DB, Monitoring, etc\)
{% endhint %}

| Type | Description | Readiness |
| :--- | :--- | :--- |
| [small](small-terraform/README.md) | Few resources, no external dependencies. Single AWS account. Single region. Single environment. | Yes |
| [medium](medium-terraform/README.md) | Several AWS accounts and environments, off-the-shelf infrastructure modules using Terraform. | Yes |
| [large](large-terraform/README.md) | Many AWS accounts, many regions, urgent need to reduce copy-paste, custom infrastructure modules, heavy usage of compositions. Using Terraform. | WIP |
| very-large | Several providers \(AWS, GCP, Azure\). Multi-cloud deployments. Using Terraform. | No |

## Terragrunt code structures

| Type | Description | Readiness |
| :--- | :--- | :--- |
| [medium](medium-terragrunt/README.md) | Several AWS accounts and environments, off-the-shelf infrastructure modules, composition pattern using Terragrunt. | No |
| large | Many AWS accounts, many regions, urgent need to reduce copy-paste, custom infrastructure modules, heavy usage of compositions. Using Terragrunt. | No |
| very-large | Several providers \(AWS, GCP, Azure\). Multi-cloud deployments. Using Terragrunt. | No |

### 

