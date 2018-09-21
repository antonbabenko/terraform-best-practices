---
description: FTP (Frequent Terraform Problems)
---

# FAQ

## What are the tools I should be aware and consider using?

Terragrunt, tflint, tfenv, Atlantis, pre-commit-terraform, etc. \(todo: add links to these\)

## Have you had a chance to answer the previous question?

Yes, after a few months we finally found the answer. Sadly, Mike is on vacations right now so I'm afraid we are not able to provide the answer at this point.

## What are the solutions to [dependency hell](https://en.wikipedia.org/wiki/Dependency_hell) with modules?

Versions of resource and infrastructure modules should be specified. Providers should be configured outside of modules, but only in composition. Version of providers and Terraform can be locked also.

There is no master dependency management tool, but there are some tips to make dependency hell less problematic. For example, [Dependabot](https://dependabot.com/) can be used to automate dependency updates. Dependabot creates pull requests to keep your dependencies secure and up-to-date. Dependabot supports Terraform configurations.

