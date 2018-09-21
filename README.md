---
description: >-
  This document is an attempt to systematically describe best practices using
  Terraform and provide recommendations for the most frequent problems Terraform
  users experience.
---

# Introduction

[Terraform](https://www.terraform.io/) is a fairy new project \(as most of DevOps tools actually\) which was started in 2014.

Terraform is powerful \(if not the most powerful out there now\) and one of the most used tool which allows to manage infrastructure as code. It allows developers to do a lot of things and does not restrict them from doing things in ways which will be hard to support or integrate with.

Some information described in this book may not seem like the best practices. I know this, and to help reader to separate what are established best practices and what is just another opinionated way of doing things, I use hints to provide some context and icons to specify the level of maturity on each subsection related to best practices.

## Terms of content

* Key Concepts
  * Resource
  * Resource module
  * Infrastructure module
  * Composition
  * Data sources
  * Remote state
  * Provider, provisioner, etc
* How to structure code?
  * Relations \(glue, datasources\)
  * Examples of directory structure
* How to collaborate on Terraform code
* Naming
* Formatting
* Tools
* Troubleshooting
  * General
  * By command:
    * terraform init
    * terraform plan
    * terraform apply
    * terraform destroy
* References
* How to contribute?

## Contributions

I want to get feedback and update this document as community mature and new ideas are implemented and verified.

## Authors

This is maintained by [Anton Babenko](https://github.com/antonbabenko) with the help of different contributors.

## Need help?

If you're looking for help or commercial support for Terraform and AWS, send an email to [anton@antonbabenko.com](mailto:anton@antonbabenko.com).

## License

This work is licensed under Apache 2 License. See LICENSE for full details.

The authors and contributors to this content cannot guarantee the validity of the information found here. Please make sure that you understand that the information provided here is being provided freely, and that no kind of agreement or contract is created between you and any persons associated with this content or project. The authors and contributors do not assume and hereby disclaim any liability to any party for any loss, damage, or disruption caused by errors or omissions in the information contained in, associated with, or linked from this content, whether such errors or omissions result from negligence, accident, or any other cause.

Copyright © 2018 Anton Babenko.

