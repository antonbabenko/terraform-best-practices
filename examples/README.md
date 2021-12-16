# Code structure examples

## Terraform code structures

{% hint style="info" %}
These examples are showing AWS provider but the majority of principles shown in the examples can be applied to other public cloud providers as well as other kinds of providers (DNS, DB, Monitoring, etc)
{% endhint %}

| Type                                                           | Description                                                                                                                                     | Readiness |
| -------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| [small](terraform/small-size-infrastructure.md)                | Few resources, no external dependencies. Single AWS account. Single region. Single environment.                                                 | Yes       |
| [medium](terraform/medium-size-infrastructure.md)              | Several AWS accounts and environments, off-the-shelf infrastructure modules using Terraform.                                                    | Yes       |
| [large](terraform/large-size-infrastructure-with-terraform.md) | Many AWS accounts, many regions, urgent need to reduce copy-paste, custom infrastructure modules, heavy usage of compositions. Using Terraform. | WIP       |
| very-large                                                     | Several providers (AWS, GCP, Azure). Multi-cloud deployments. Using Terraform.                                                                  | No        |

## Terragrunt code structures

| Type       | Description                                                                                                                                      | Readiness |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------ | --------- |
| medium     | Several AWS accounts and environments, off-the-shelf infrastructure modules, composition pattern using Terragrunt.                               | No        |
| large      | Many AWS accounts, many regions, urgent need to reduce copy-paste, custom infrastructure modules, heavy usage of compositions. Using Terragrunt. | No        |
| very-large | Several providers (AWS, GCP, Azure). Multi-cloud deployments. Using Terragrunt.                                                                  | No        |
