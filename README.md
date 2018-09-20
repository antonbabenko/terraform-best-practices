# Introduction

This document is an attempt to systematically describe best practices when using Terraform \(and Terraform modules specifically\).

```text
Author: Anton Babenko
Date: 17.9.2018
```

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

## How to

## Stackoverflow questions about this:

* [https://stackoverflow.com/questions/50737880/terraform-folder-structure-modules-vs-files](https://stackoverflow.com/questions/50737880/terraform-folder-structure-modules-vs-files)
* [https://stackoverflow.com/questions/43201497/terraform-state-management-for-multi-tenancy](https://stackoverflow.com/questions/43201497/terraform-state-management-for-multi-tenancy)

/\* Not in use for now... 1. Relations \(glue, datasources\) 1. Examples of directory structure

как разбивать код по разным папкам и зачем - для создания меньшего плана, по частоте изменений в коде, по тому кто его меняет \(люди или роботы\), по связям в коде \(SG + ресурсы где они используются\), по технологиям \(openshift, k8s\), по названию environment, по проектам \*/

## Example of directory structure of composition

```text
.
├── README.md
├── ...

112213 directories, 122110 files
```

## Contributions

You are welcome...

## Authors

This repository is maintained by [Anton Babenko](https://github.com/antonbabenko) with the help of different contributors.

The authors and contributors to this content cannot guarantee the validity of the information found here. Please make sure that you understand that the information provided here is being provided freely, and that no kind of agreement or contract is created between you and any persons associated with this content or project. The authors and contributors do not assume and hereby disclaim any liability to any party for any loss, damage, or disruption caused by errors or omissions in the information contained in, associated with, or linked from this content, whether such errors or omissions result from negligence, accident, or any other cause.

If you're looking for help or commercial support for Terraform and AWS, send an email to anton@antonbabenko.com.

## License

This work is licensed under Apache 2 License. See LICENSE for full details.

Copyright © 2018 Anton Babenko.

