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



How to structure code?

* Relations \(glue, datasources\)
* Examples of directory structure

## Code structure

Putting all code in one file \(often `main.tf`\) is a good idea when you are getting started or writing an example code. In most of other cases you will be better having several files split logically. 

Recommended approach is to have:

* `main.tf` - call modules, locals and data-sources to create all resources
* `variables.tf` - contains declarations of variables used in `main.tf`
* `outputs.tf` - contains outputs from the resources created in `main.tf`

`terraform.tfvars` should not be used anywhere except [composition](key-concepts.md#composition). See example structure below.

### How to think about structure?

For the simplicity let's split structures by the complexity - from small to very-large infrastructures. This separation is not strict, so please check other structures also.

Another way of splitting structures provided in this repository is by whether Terraform or Terragrunt is used \([read more about Terragrunt](https://github.com/gruntwork-io/terragrunt#use-cases)\).

> Notes:  
> 1. Supported by Atlantis - means if Atlantis recognizes the structure natively  
> 1. Terragrunt-ready - means if Terragrunt is used

