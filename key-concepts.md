# Key concepts

The official Terraform documentation describes [all aspects of configuration in details](https://www.terraform.io/docs/configuration/index.html). Read it carefully to understand the rest of this section.

This section describes key concepts which are used inside the book.

## Resource

Resource is `aws_vpc`, `aws_db_instance`, etc. A resource belongs to a provider, accepts arguments, outputs attributes, and has a lifecycle. A resource can be created, retrieved, updated, and deleted.

## Resource module

Resource module is a collection of connected resources which together perform the common action (for e.g., [AWS VPC Terraform module](https://github.com/terraform-aws-modules/terraform-aws-vpc/) creates VPC, subnets, NAT gateway, etc). It depends on provider configuration, which can be defined in it, or in higher-level structures (e.g., in infrastructure module).

## Infrastructure module

An infrastructure module is a collection of resource modules, which can be logically not connected, but in the current situation/project/setup serves the same purpose. It defines the configuration for providers, which is passed to the downstream resource modules and to resources. It is normally limited to work in one entity per logical separator (e.g., AWS Region, Google Project).

For example, [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis/) module uses resource modules like [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc/) and [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group/) to manage the infrastructure required for running [Atlantis](https://www.runatlantis.io) on [AWS Fargate](https://aws.amazon.com/fargate/).

Another example is [terraform-aws-cloudquery](https://github.com/cloudquery/terraform-aws-cloudquery) module where multiple modules by [terraform-aws-modules](https://github.com/terraform-aws-modules/) are being used together to manage the infrastructure as well as using Docker resources to build, push, and deploy Docker images. All in one set.

## Composition

Composition is a collection of infrastructure modules, which can span across several logically separated areas (e.g.., AWS Regions, several AWS accounts). Composition is used to describe the complete infrastructure required for the whole organization or project.

A composition consists of infrastructure modules, which consist of resources modules, which implement individual resources.

![Simple infrastructure composition](.gitbook/assets/composition-1.png)

## Data source

Data source performs a read-only operation and is dependant on provider configuration, it is used in a resource module and an infrastructure module.

Data source `terraform_remote_state` acts as a glue for higher-level modules and compositions.

The [external](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data\_source) data source allows an external program to act as a data source, exposing arbitrary data for use elsewhere in the Terraform configuration. Here is an example from the [terraform-aws-lambda module](https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/258e82b50adc451f51544a2b57fd1f6f8f4a61e4/package.tf#L5-L7) where the filename is computed by calling an external Python script.

The [http](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) data source makes an HTTP GET request to the given URL and exports information about the response which is often useful to get information from endpoints where a native Terraform provider does not exist.

## Remote state

Infrastructure modules and compositions should persist their [Terraform state](https://www.terraform.io/docs/language/state/index.html) in a remote location where it can be retrieved by others in a controllable way (e.g., specify ACL, versioning, logging).

## Provider, provisioner, etc

Providers, provisioners, and a few other terms are described very well in the official documentation and there is no point to repeat it here. To my opinion, they have little to do with writing good Terraform modules.

## Why so _difficult_?

While individual resources are like atoms in the infrastructure, resource modules are molecules (consisting of atoms). A module is the smallest versioned and shareable unit. It has an exact list of arguments, implement basic logic for such a unit to do the required function. e.g., [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group) module creates `aws_security_group` and `aws_security_group_rule` resources based on input. This resource module by itself can be used together with other modules to create the infrastructure module.

Access to data across molecules (resource modules and infrastructure modules) is performed using the modules' outputs and data sources.

Access between compositions is often performed using remote state data sources. There are [multiple ways to share data between configurations](https://www.terraform.io/docs/language/state/remote-state-data.html#alternative-ways-to-share-data-between-configurations).

When putting concepts described above in pseudo-relations it may look like this:

```
composition-1 {
  infrastructure-module-1 {
    data-source-1 => d1

    resource-module-1 {
      data-source-2 => d2
      resource-1 (d1, d2)
      resource-2 (d2)
    }

    resource-module-2 {
      data-source-3 => d3
      resource-3 (d1, d3)
      resource-4 (d3)
    }
  }
}
```
