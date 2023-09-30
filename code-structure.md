# Code structure

Questions related to Terraform code structure are by far the most frequent in the community. Everyone thought about the best code structure for the project at some point also.

## How should I structure my Terraform configurations?

This is one of the questions where lots of solutions exist and it is very hard to give universal advice, so let's start with understanding what are we dealing with.

* What is the complexity of your project?
  * Number of related resources
  * Number of Terraform providers (see note below about "logical providers")
* How often does your infrastructure change?
  * **From** once a month/week/day
  * **To** continuously (every time when there is a new commit)
* Code change initiators? _Do you let the CI server update the repository when a new artifact is built?_
  * Only developers can push to the infrastructure repository
  * Everyone can propose a change to anything by opening a PR (including automated tasks running on the CI server)
* Which deployment platform or deployment service do you use?
  * AWS CodeDeploy, Kubernetes, or OpenShift require a slightly different approach
* How environments are grouped?
  * By environment, region, project

{% hint style="info" %}
_Logical providers_ work entirely within Terraform's logic and very often don't interact with any other services, so we can think about their complexity as O(1). The most common logical providers include [random](https://registry.terraform.io/providers/hashicorp/random/latest/docs), [local](https://registry.terraform.io/providers/hashicorp/local/latest/docs), [terraform](https://www.terraform.io/docs/providers/terraform/index.html), [null](https://registry.terraform.io/providers/hashicorp/null/latest/docs), [time](https://registry.terraform.io/providers/hashicorp/time/latest).
{% endhint %}

## Getting started with the structuring of Terraform configurations

Putting all code in `main.tf` is a good idea when you are getting started or writing an example code. In all other cases you will be better having several files split logically like this:

* `main.tf` - call modules, locals, and data sources to create all resources
* `variables.tf` - contains declarations of variables used in `main.tf`
* `outputs.tf` - contains outputs from the resources created in `main.tf`
* `versions.tf` - contains version requirements for Terraform and providers

`terraform.tfvars` should not be used anywhere except [composition](key-concepts.md#composition).

## How to think about Terraform configuration structure?

{% hint style="info" %}
Please make sure that you understand key concepts - [resource module](key-concepts.md#resource-module), [infrastructure module](key-concepts.md#infrastructure-module), and [composition](key-concepts.md#composition), as they are used in the following examples.
{% endhint %}

### Common recommendations for structuring code

* It is easier and faster to work with a smaller number of resources
  * `terraform plan` and `terraform apply` both make cloud API calls to verify the status of resources
  * If you have your entire infrastructure in a single composition this can take some time
* A blast radius (in case of security breach) is smaller with fewer resources
  * Insulating unrelated resources from each other by placing them in separate compositions reduces the risk if something goes wrong
* Start your project using remote state because:
  * Your laptop is no place for your infrastructure source of truth
  * Managing a `tfstate` file in git is a nightmare
  * Later when infrastructure layers start to grow in multiple directions (number of dependencies or resources) it will be easier to keep things under control
* Practice a consistent structure and [naming](naming.md) convention:
  * Like procedural code, Terraform code should be written for people to read first, consistency will help when changes happen six months from now
  * It is possible to move resources in Terraform state file but it may be harder to do if you have inconsistent structure and naming
* Keep resource modules as plain as possible
* Don't hardcode values that can be passed as variables or discovered using data sources
* Use data sources and `terraform_remote_state` specifically as a glue between infrastructure modules within the composition

In this book, example projects are grouped by _complexity_ - from small to very-large infrastructures. This separation is not strict, so check other structures also.

### Orchestration of infrastructure modules and compositions

Having a small infrastructure means that there is a small number of dependencies and few resources. As the project grows the need to chain the execution of Terraform configurations, connecting different infrastructure modules, and passing values within a composition becomes obvious.

There are at least 5 distinct groups of orchestration solutions that developers use:

1. Terraform only. Very straightforward, developers have to know only Terraform to get the job done.
2. Terragrunt. Pure orchestration tool which can be used to orchestrate the entire infrastructure as well as handle dependencies. Terragrunt operates with infrastructure modules and compositions natively, so it reduces duplication of code.
3. In-house scripts. Often this happens as a starting point towards orchestration and before discovering Terragrunt.
4. Ansible or similar general purpose automation tool. Usually used when Terraform is adopted after Ansible, or when Ansible UI is actively used.
5. [Crossplane](https://crossplane.io) and other Kubernetes-inspired solutions. Sometimes it makes sense to utilize the Kubernetes ecosystem and employ a reconciliation loop feature to achieve the desired state of your Terraform configurations. View video [Crossplane vs Terraform](https://www.youtube.com/watch?v=ELhVbSdcqSY) for more information.

With that in mind, this book reviews the first two of these project structures, Terraform only and Terragrunt.

See examples of code structures for [Terraform](examples/terraform/) or [Terragrunt](examples/terragrunt.md) in the next chapter.
