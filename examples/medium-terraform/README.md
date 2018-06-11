# Medium-size infrastructure using Terraform

This directory contains code as an example of structuring Terraform configurations for a medium-size infrastructure with several AWS accounts, off-the-shelf infrastructure modules, composition pattern.

## Features

1. `prod` and `stage` are separate environments which share nothing and they live in separate AWS accounts
1. Each environment has different version of infrastructure module (`alb`)
