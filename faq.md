---
description: FTP (Frequent Terraform Problems)
---

# FAQ

## What are the tools I should be aware of and consider using?

* [**Terragrunt**](https://terragrunt.gruntwork.io/) - Orchestration tool
* [**tflint**](https://github.com/terraform-linters/tflint) - Code linter
* [**tfenv**](https://github.com/tfutils/tfenv) - Version manager
* [**tenv**](https://github.com/tofuutils/tenv) - Version manager, written in Go
* [**asdf-hashicorp**](https://github.com/asdf-community/asdf-hashicorp) - HashiCorp plugin for the [asdf](https://github.com/asdf-vm/asdf) version manager
* [**Atlantis**](https://www.runatlantis.io/) - Pull Request automation
* [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) - Collection of git hooks for Terraform to be used with [pre-commit framework](https://pre-commit.com/)
* [**Infracost**](https://www.infracost.io) - Cloud cost estimates for Terraform in pull requests. Works with Terragrunt, Atlantis and pre-commit-terraform too.

## What are the solutions to [dependency hell](https://en.wikipedia.org/wiki/Dependency\_hell) with modules?

Versions of resource and infrastructure modules should be specified. Providers should be configured outside of modules, but only in composition. Version of providers and Terraform can be locked also.

There is no master dependency management tool, but there are some tips to make dependency specifications less problematic. For example, [Dependabot](https://dependabot.com/) can be used to automate dependency updates. Dependabot creates pull requests to keep your dependencies secure and up-to-date. Dependabot supports Terraform configurations.
