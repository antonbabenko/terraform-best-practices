# Medium-size infrastructure with Terraform

Source: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform)

This example contains code as an example of structuring Terraform configurations for a medium-size infrastructure which uses:

* 2 AWS accounts
* 2 separate environments (`prod` and `stage` which share nothing). Each environment lives in a separate AWS account
* Each environment uses a different version of the off-the-shelf infrastructure module (`alb`) sourced from [Terraform Registry](https://registry.terraform.io/)
* Each environment uses the same version of an internal module `modules/network` since it is sourced from a local directory.

{% hint style="success" %}
* Perfect for projects where infrastructure is logically separated (separate AWS accounts)
* Good when there is no is need to modify resources shared between AWS accounts (one environment = one AWS account = one state file)
* Good when there is no need in the orchestration of changes between the environments
* Good when infrastructure resources are different per environment on purpose and can't be generalized (eg, some resources are absent in one environment or in some regions)
{% endhint %}

{% hint style="warning" %}
As the project grows, it will be harder to keep these environments up-to-date with each other. Consider using infrastructure modules (off-the-shelf or internal) for repeatable tasks.
{% endhint %}

##
