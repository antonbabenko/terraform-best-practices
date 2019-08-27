# Topics to describe

## To describe:
* monorepo vs several repos (mbt, http get, size) for terraform code
  - Should app and infra live together? When yes and when no? https://apparently.me.uk/terraform-environment-application-pattern/overview.html
* scale-up or scale-down for code structures
* how to handle secrets in Terraform - https://tosbourn.com/hiding-secrets-terraform/
* shared terraform state for environments 
  - add better and real examples for workspaces - https://www.terraform.io/docs/state/workspaces.html#when-to-use-multiple-workspaces
* integration with Ansible (via dynamic inventory) vs AWS launch configuration's user_data
* include and describe terragrunt scripts
* infrastructure versioning, gitops
* pipelines (+- Spinnaker)
* CI-CD in general
* changelog of this repo, gitbook
* working with multiple instances of the same providers in close proximity (same infrastructure module). Eg, AWS VPC peering, Route53 zone/records.
* Review how https://github.com/travis-ci/terraform-config is organized (main Makefiles in root, modules, workflow)
  - add links to modules collections like https://github.com/wellcometrust/terraform-modules and Telia-oss
* Couple sentences as a review of Terraform related projects - Atlantis, terragrunt
* https://youtu.be/ShKNCBDQpd4?t=16m34s - about resource and infrastructure modules
* https://stackoverflow.com/questions/52134830/using-terraform-modules-for-multiple-regional-api-gateway - and similar questions. Multiple providers aliases should be part of composition (often) rather than individual infra modules.
* Show example of using `http` and `external` data sources to add missing features from external APIs
* Cross-regions VPC peering - show example code (https://github.com/grem11n/terraform-aws-vpc-peering/pull/6/files - should not have providers in module), external orrationc
* How to handle global AWS organization services in terms of services being applied/shared between other environments, accounts (e.g. cloudtrail, config, some global roles, route53 zones, etc.)
* Don't use terraform workspaces
* Using TF to provision local dev environments (vs vagrant+virtualbox)
* Safe way to manage critical infra components (EIP, VPC, RDS, for eg) with prevent_destroy = true + IAM policy (Deny)
* infrastructure testing options
* describe ways to integrate modules (eg, as I did in terraform-aws-atlantis - BYO resources, create new, standalone)
* describe modules in details with examples - infrastructure modules and resource modules

Stackoverflow questions about this:https://stackoverflow.com/questions/50737880/terraform-folder-structure-modules-vs-fileshttps://stackoverflow.com/questions/43201497/terraform-state-management-for-multi-tenancy

terraform-quiz