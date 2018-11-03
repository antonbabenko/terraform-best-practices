# Large-size infrastructure using Terraform

This directory contains code as an example of structuring Terraform configurations for a large-size infrastructure with several AWS accounts, off-the-shelf infrastructure modules.

## Features

1. `prod` and `stage` are separate environments which share nothing and they live in separate AWS accounts
1. Each environment uses different version of off-the-shelf infrastructure module (`alb`)
1. Each environment uses the same version of internal module `modules/network` since it is sourced from a local directory.
