## Code structure - Examples

### Terraform code structures

| Type | Description | Supported by Atlantis |
|------|-------------|:----:|
| [small](./examples/small) | Few resources, no external dependencies. Single AWS account. Single region. Single environment. | yes |
| [medium-terraform](./examples/medium-terraform) | Several AWS accounts and environments, off-the-shelf infrastructure modules, composition pattern using Terraform. | yes |
| [large-terraform](./examples/large-terraform) | Many AWS accounts, many regions, urgent need to reduce copy-paste, custom infrastructure modules, heavy usage of compositions. Using Terraform | yes |
| [very-large-terraform](./examples/very-large-terraform) | Several providers (AWS, GCP, Azure). Multi-cloud deployments. Using Terraform | yes |

### Terragrunt code structures

| Type | Description | Supported by Atlantis |
|------|-------------|:----:|
| [medium-terragrunt](./examples/medium-terragrunt) | Several AWS accounts and environments, off-the-shelf infrastructure modules, composition pattern using Terragrunt | yes |
| [large-terragrunt](./examples/large-terragrunt) | Many AWS accounts, many regions, urgent need to reduce copy-paste, custom infrastructure modules, heavy usage of compositions. Using Terragrunt | yes |
| [very-large-terragrunt](./examples/very-large-terragrunt) | Several providers (AWS, GCP, Azure). Multi-cloud deployments. Using Terragrunt | yes |

#### * small

##### Pros

- Perfect to get started and refactor as you go 
- Perfect for all resource modules; good for small and linear infrastructure modules (eg, [terraform-aws-atlantis])
- Great for small number of resources (fewer than 20-30)

##### Cons

- Single state file for all resources can make process of working with Terraform slow
- @todo: When using this with large amount of resources, resource targeting will help (`terraform plan -target=...`).

#### * medium-terraform

##### Pros

- Something good

##### Cons

- Something bad

#### * medium-terraform

##### Pros

- Something good

##### Cons

- Something bad

#### * medium-terraform

##### Pros

- Something good

##### Cons

- Something bad

#### * medium-terraform

##### Pros

- Something good

##### Cons

- Something bad

#### * medium-terraform

##### Pros

- Something good

##### Cons

- Something bad

