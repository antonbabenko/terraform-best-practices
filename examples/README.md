# Code structure examples

## Terraform code structures

{% hint style="info" %}
These examples are showing AWS provider but the majority of principles showed in the examples can be applied to other public cloud providers as well as other kind of providers \(DNS, DB, Monitoring, etc\)
{% endhint %}

| Type | Description |
| :--- | :--- |
| [small](https://github.com/antonbabenko/terraform-best-practices/tree/5957e997ea023df0f5b27891cef944be74b45706/examples/small/README.md) | Few resources, no external dependencies. Single AWS account. Single region. Single environment. |
| [medium-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/5957e997ea023df0f5b27891cef944be74b45706/examples/medium-terraform/README.md) | Several AWS accounts and environments, off-the-shelf infrastructure modules, composition pattern using Terraform. |
| [large-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/5957e997ea023df0f5b27891cef944be74b45706/examples/large-terraform/README.md) | Many AWS accounts, many regions, urgent need to reduce copy-paste, custom infrastructure modules, heavy usage of compositions. Using Terraform |
| [very-large-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/5957e997ea023df0f5b27891cef944be74b45706/examples/very-large-terraform/README.md) | Several providers \(AWS, GCP, Azure\). Multi-cloud deployments. Using Terraform |

## Terragrunt code structures

| Type | Description |
| :--- | :--- |
| [medium-terragrunt](https://github.com/antonbabenko/terraform-best-practices/tree/5957e997ea023df0f5b27891cef944be74b45706/examples/medium-terragrunt/README.md) | Several AWS accounts and environments, off-the-shelf infrastructure modules, composition pattern using Terragrunt |
| [large-terragrunt](https://github.com/antonbabenko/terraform-best-practices/tree/5957e997ea023df0f5b27891cef944be74b45706/examples/large-terragrunt/README.md) | Many AWS accounts, many regions, urgent need to reduce copy-paste, custom infrastructure modules, heavy usage of compositions. Using Terragrunt |
| [very-large-terragrunt](https://github.com/antonbabenko/terraform-best-practices/tree/5957e997ea023df0f5b27891cef944be74b45706/examples/very-large-terragrunt/README.md) | Several providers \(AWS, GCP, Azure\). Multi-cloud deployments. Using Terragrunt |

### \* small

#### Pros

* Perfect to get started and refactor as you go 
* Perfect for all resource modules; good for small and linear infrastructure modules \(eg, \[terraform-aws-atlantis\]\)
* Great for small number of resources \(less then 20-30\)

#### Cons

* Single state file for all resources can make process of working with Terraform slow
* @todo: When using this with large amount of resources, resource targeting will help \(`terraform plan -target=...`\).

### \* medium-terraform

#### Pros

* Something good

#### Cons

* Something bad

### \* medium-terraform

#### Pros

* Something good

#### Cons

* Something bad

### \* medium-terraform

#### Pros

* Something good

#### Cons

* Something bad

### \* medium-terraform

#### Pros

* Something good

#### Cons

* Something bad

### \* medium-terraform

#### Pros

* Something good

#### Cons

* Something bad

