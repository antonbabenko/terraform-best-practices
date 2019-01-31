# Code structure

Questions related to Terraform code structure are by far the most frequent in the community. Everybody probably thought about best code structure at some point also.

## How should I structure my Terraform configurations?

This is one of the questions where lots of solutions exist and it is very hard to get general advice, so let's start with understanding what are we dealing with.

* What is the complexity of your project?
  * Number of related resources
  * Number of Terraform providers
* How often does your infrastructure change?
  * **From** once a month/week/day
  * **To** continuously \(every time when there is a new commit\)
* Code change initiators? _Do you let CI server to update the repository when new artifact is built?_
  * Only developers can push to infrastructure repository
  * Everyone can propose change to anything by opening a PR \(including automated tasks running on CI server\)
* Which deployment platform or deployment service do you use?
  * AWS CodeDeploy, Kubernetes or OpenShift require slightly different approach
* How environments are grouped?
  * By environment, region, project

{% hint style="info" %}
_Logical providers_ work entirely within Terraform's logic, and doesn't interact with any other services, so we can think about their complexity as O\(1\). Most common logical providers include [random](https://www.terraform.io/docs/providers/random/index.html), [template](https://www.terraform.io/docs/providers/template/index.html), [terraform](https://www.terraform.io/docs/providers/terraform/index.html), [null](https://www.terraform.io/docs/providers/null/index.html).
{% endhint %}

## Getting started with structuring of Terraform configurations

Putting all code in `main.tf` is a good idea when you are getting started or writing an example code. In all other cases you will be better having several files split logically like this:

* `main.tf` - call modules, locals and data-sources to create all resources
* `variables.tf` - contains declarations of variables used in `main.tf`
* `outputs.tf` - contains outputs from the resources created in `main.tf`

`terraform.tfvars` should not be used anywhere except [composition](key-concepts.md#composition).

## How to think about Terraform configurations structure?

{% hint style="info" %}
Please make sure that you understand key concepts - [resource module](key-concepts.md#resource-module), [infrastructure module](key-concepts.md#infrastructure-module) and [composition](key-concepts.md#composition), as they will be used in the following examples.
{% endhint %}

### Common recommendations for structuring code

* It is easier and faster to work with smaller number of resources
  * `terraform plan` and `terraform apply` both make cloud API calls to verify the status of resources
  * If you have your entire infrastructure in a single composition this can take many minutes
* Blast radius is smaller with fewer resources
  * Insulating unrelated resources from each other by placing them in separate compositions reduces the risk if something goes wrong
* Start your project using remote state
  * Your laptop is no place for your infrastructure source of truth
  * Managing a tfstate file in git is a nightmare
  * Later when infrastructure layers starts to grow in any direction \(number of dependencies or resources\)
* Try to practise a consistent structure and [naming](naming.md) convention
  * Like procedural code, Terraform code should be written for people to read first, consistency will help when changes happen six months from now
  * It is possible to move resources in Terraform state file but it may be harder to do if you have inconsistent structure and naming
* Keep resource modules as plain as possible
* Don't hardcode values which can be passed as variables or discovered using data sources
* Use data sources and `terraform_remote_state` specifically as a glue between infrastructure modules within composition
* \(add links to other blog posts\)

We will group example projects by the _complexity_ - from small to very-large infrastructures. This separation is not strict, so check other structures also.

### Orchestration of infrastructure modules and compositions

Having small infrastructure means that there are a small number of dependencies and few resources. As the project grows the need to chain the execution of Terraform configurations, connecting different infrastructure modules, and passing values within a composition becomes visible.

There are at least 4 distinct groups of orchestration solutions which developers use:

1. Terraform only. Very straightforward, developers have to know only Terraform to get job done. 
2. Terragrunt. Pure orchestration tool which can be used to orchestrate the entire infrastructure as well as handle dependencies. Terragrunt operates with infrastructure modules and compositions natively, so it reduces duplication of code.
3. In-house scripts. Often this happens as a starting point towards orchestration and before discovering Terragrunt.
4. Ansible or similar general purpose automation tool. Usually used when Terraform is adopted after Ansible, or when Ansible UI is actively used.

With that in mind we will reviewing the first two of these project structures, Terraform only and Terragrunt.

See examples of code structures for [Terraform](examples/terraform.md) or [Terragrunt](examples/terragrunt.md) in the next chapter.
