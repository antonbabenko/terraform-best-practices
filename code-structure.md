- How to structure code?
  - Relations (glue, datasources)
  - Examples of directory structure


## Code structure

Putting all code in one file (often `main.tf`) is a good idea when you are getting started or writing an example code. In most of other cases you will be better having several files split logically. Recommended approach is to have:
1. `main.tf` - call modules, locals and data-sources to create all resources
1. `variables.tf` - contains declarations of variables used in `main.tf`
1. `outputs.tf` - contains outputs from the resources created in `main.tf`

`terraform.tfvars` should not be used anywhere except composition. See example structure below.

### How to think about structure?

For the simplicity let's split structures by the complexity - from small to very-large infrastructures. This separation is not strict, so please check other structures also.

Another way of splitting structures provided in this repository is by whether Terraform or Terragrunt is used ([read more about Terragrunt](https://github.com/gruntwork-io/terragrunt#use-cases)).

> Notes:
> 1. Supported by Atlantis - means if Atlantis recognizes the structure natively
> 1. Terragrunt-ready - means if Terragrunt is used
