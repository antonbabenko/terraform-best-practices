# Terraform best practices

This document is an attempt to systematically describe best practices when using Terraform (and Terraform modules specifically).

```
Author: Anton Babenko
Date: 1.6.2018
```

### STATUS: Requires proof-reading, corrections, additions, not ready for public yet.


## Terms of content

- Key Concepts
  - Resource
  - Resource module
  - Infrastructure module
  - Composition
  - Data sources
  - Remote state
  - Provider, provisioner, etc

- How to structure code?
  - Relations (glue, datasources)
  - Examples of directory structure

- How to collaborate on Terraform code

- Naming

- Formatting

- Tools

- Troubleshooting
  - General
  - By command:
    - terraform init
    - terraform plan
    - terraform apply
    - terraform destroy

- References

- How to contribute?

```
## To describe:
* monorepo vs several repos (mbt, http get, size)
* scale-up or scale-down for code structures
* how to handle secrets in Terraform - https://tosbourn.com/hiding-secrets-terraform/
* include and describe terragrunt scripts
* infrastructure versioning, gitops
* pipelines (+- Spinnaker)
* CI-CD in general
* changelog of this repo, gitbook
* working with multiple instances of the same providers in close proximity (same infrastructure module). Eg, AWS VPC peering, Route53 zone/records.
* Review how https://github.com/travis-ci/terraform-config is organized (main Makefiles in root, modules, workflow)
* Couple sentences as a review of Terraform related projects - Atlantis, terragrunt
* https://youtu.be/ShKNCBDQpd4?t=16m34s - about resource and infrastructure modules
* https://stackoverflow.com/questions/52134830/using-terraform-modules-for-multiple-regional-api-gateway - and similar questions. Multiple providers aliases should be part of composition (often) rather than individual infra modules.
* Show example of using `http` and `external` data sources to add missing features from external APIs
* Cross-regions VPC peering - show example code, external orrationc

terraform-quiz
```

## Key concepts

### Resource

Resource is `aws_vpc`, `aws_db_instance`, etc. Resource belongs to provider, accepts arguments, outputs attributes, has lifecycles. Resource can be created, retrieved, updated, and deleted.

### Resource module

Resource module is a collection of connected resources which together perform the common action (for eg, [AWS VPC Terraform module](terraform-aws-vpc) creates VPC, subnets, NAT gateway, etc). It depends on provider configuration, which can be defined in it, or in higher level structures (eg, infrastructure module).

### Infrastructure module

Infrastructure module is a collection of resource modules, which can be logically not connected, but in the current situation/project/setup are serving the same purpose. It defines configuration for providers, which is passed to the downstream resource modules and to resources. It is normally limited to work in one entity per logical separator (eg, AWS Region, Google Project). An example is [terraform-aws-atlantis](terraform-aws-atlantis) which uses resource modules like [terraform-aws-vpc](terraform-aws-vpc) and [terraform-aws-security-group](terraform-aws-security-group) to create infrastructure required for running [Atlantis] on AWS Fargate.

### Composition

Composition is a collection of infrastructure modules, which can span across several logically separated areas (eg., AWS Regions, several AWS accounts). Composition is used to describe the complete infrastructure required for the whole organization/project. 

Composition consists of infrastructure modules, which consist of resources modules, which implement individual resources.

### Data source

Data source performs read-only operation and is dependant on provider configuration, it is used in a resource module and an infrastructure module.

Data source `terraform_remote_state` acts as a glue for higher level modules and compositions.
 
The [external](https://www.terraform.io/docs/providers/external/data_source.html) data source allows an external program to act as a data source, exposing arbitrary data for use elsewhere in the Terraform configuration.

The [http](https://www.terraform.io/docs/providers/http/data_source.html) data source makes an HTTP GET request to the given URL and exports information about the response which is often useful to get information from endpoints where native Terraform provider does not exist.


### Remote state

Infrastructure modules and compositions should persist their state in a remote location which can be reached by others in a controllable way (ACL, versioning, logging).

### Provider, provisioner, etc

Providers, provisioners and few other terms are described very well on the official documentation and there is no point to repeat it here. To my opinion they have little to do with writing good Terraform modules. More details will be provided later.

## Why so difficult?

While individual resources are like atoms in the infrastructure, resource modules are molecules. Module is a smallest versioned and shareable unit. It has exact list of arguments, implement basic logic for such unit to do required function. Eg. terraform-aws-security-group creates aws_security_group and aws_security_group_list based on input. This resource module by itself can be used together with other modules to create infrastructure module.

Access between molecules (resource modules and infrastructure modules) is performed using data sources.

Access between compositions is performed using remote states data sources.

When putting things in pseudo-relations it may look like this:

```
composition-1 {
  infrastructure-module-1 {
    data-source-1 => d1
    
    resource-module-1 {
      data-source-2 => d2
      resource-1 (d1, d2)
      resource-2 (d2)
    }

    resource-module-2 {
      data-source-3 => d3
      resource-3 (d1, d3)
      resource-4 (d3)
    }
  }
  
}
```  

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
- Great for small number of resources (less then 20-30)

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

## How to 

## Stackoverflow questions about this:

- https://stackoverflow.com/questions/50737880/terraform-folder-structure-modules-vs-files
- https://stackoverflow.com/questions/43201497/terraform-state-management-for-multi-tenancy

/* Not in use for now...
  1. Relations (glue, datasources)
  1. Examples of directory structure

как разбивать код по разным папкам и зачем - для создания меньшего плана, по частоте изменений в коде, по тому кто его меняет (люди или роботы), по связям в коде (SG + ресурсы где они используются), по технологиям (openshift, k8s), по названию environment, по проектам
*/

## Example of directory structure of composition

```
.
├── README.md
├── ...

112213 directories, 122110 files
```


## Naming

### Naming in modules - resource arguments, variables, outputs

### resource arguments:

1. Do not repeat resource type in resource id (not partially, nor completely)

   - Good: `resource "aws_route_table" "public" {}`
   - Bad: `resource "aws_route_table" "public_route_table" {}`
   - Bad: `resource "aws_route_table" "public_aws_route_table" {}`

1. Resource id should be named `this` if there is no more descriptive and general name available, or if resource module creates single resource of this type (eg, there is single resource of type `aws_nat_gateway`, but multiple `aws_route_table`, so `aws_nat_gateway` can be named `this`, but `aws_route_table` should be more descriptive - like `private`, `public`, `database`).

1. Include `count` argument inside resource blocks as the first argument at the top and separate by newline after it.


   Good:
   ```
   resource "aws_route_table" "public" {
     count = "2"
     
     vpc_id = "vpc-12345678"
     # ... remaining arguments omited
   }
   ```
   Bad:
   ```
   resource "aws_route_table" "public" {
     vpc_id = "vpc-12345678"
     count = "2"`
     
     # ... remaining arguments omited
   }
   ```

1. Include `tags` argument, if supported by resource as the last real argument, following my `depends_on` and `lifecycle`, if necessary. All of these should be separated by single empty line.


   Good:
   ```
   resource "aws_nat_gateway" "this" {
     count = "1"
   
     allocation_id = "..."
     subnet_id     = "..."
   
     tags = "..."
   
     depends_on = ["aws_internet_gateway.this"]
     
     lifecycle {
       create_before_destroy = true
     }
   }
   ```

   Bad:
   ```
   resource "aws_nat_gateway" "this" {
     count = "1"
   
     tags = "..."
   
     depends_on = ["aws_internet_gateway.this"]
     
     lifecycle {
       create_before_destroy = true
     }
     
     allocation_id = "..."
     subnet_id     = "..."
   }
   ```

1. When using condition in `count` argument use boolean value, if it makes sense, otherwise use `length` or other interpolation.


   Good 1:
   ```
   count = "${var.create_public_subnets}"
   ```
   
   
   Good 2:
   ```
   count = "${length(var.public_subnets) > 0 ? 1 : 0}"
   ```
   
   
   Bad:
   ```
   count = "${var.dont_need_public_subnets}"
   ```

1. To make inverted conditions don't introduce another variable unless really necessary, use `1 - boolean value`.


   Good:
   ```
   count = "${1 - var.create_public_subnets}"
   ```

1. Try to avoid using `-` inside resource ids and make it to match `a-z0-9`.

1. Use `-` inside arguments values and in places where value will be available to a human (eg, inside DNS name of RDS instance). Use `_` (underscore) in all other cases (in resource names, data source name, variables, outputs, etc). Names should be lowercase and include only letters and numbers.

## Styling

WIP

## Contributions

You are welcome... 

## Authors

This repository is maintained by [Anton Babenko](https://github.com/antonbabenko) with the help of different contributors.

The authors and contributors to this content cannot guarantee the validity of the information found here. Please make sure that you understand that the information provided here is being provided freely, and that no kind of agreement or contract is created between you and any persons associated with this content or project. The authors and contributors do not assume and hereby disclaim any liability to any party for any loss, damage, or disruption caused by errors or omissions in the information contained in, associated with, or linked from this content, whether such errors or omissions result from negligence, accident, or any other cause.

If you're looking for help or commercial support for Terraform and AWS, send an email to anton@antonbabenko.com.

## License

This work is licensed under Apache 2 License. See LICENSE for full details.

Copyright © 2018 Anton Babenko.
