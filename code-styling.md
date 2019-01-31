# Notes about code styling and documentation

{% hint style="success" %}
* Examples and Terraform modules should contain documentation explaining features and how to use them.
* Links on the Terraform Registry web-site are relevant and will not work, so use absolute paths in README.md.
* Documentation may include diagrams created with [mermaid](https://github.com/knsv/mermaid) and blueprints created with [cloudcraft.co](https://cloudcraft.co).
* Use [Terraform pre-commit hooks](https://github.com/antonbabenko/pre-commit-terraform) to make sure that the code is valid, properly formatted and automatically documented before it is pushed to git and reviewed by human.
{% endhint %}

## Documentation

### Automatically generated documentation

[pre-commit](https://pre-commit.com/) is a framework for managing and maintaining multi-language pre-commit hooks. It is written in Python and is a powerful tool to do something automatically on developer's machine before code is committed to git repository. Normally, it is used run linters and format code (see [supported hooks](https://pre-commit.com/hooks.html)).

With Terraform configurations pre-commit can be used to format and validate code, as well as to update documentation.

Check out [pre-commit-terraform repository](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md) to familiarize yourself with it, and existing repositories (eg, [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc)) where this is used already.

### terraform-docs

[terraform-docs](https://github.com/segmentio/terraform-docs) is a tool which does generation of documentation from Terraform modules in various output formats. You can run it manually (without pre-commit hooks), or using [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform) to get documentation updated automatically.

## Resources

1. [pre-commit framework homepage](https://pre-commit.com/)
1. [Collection of git hooks for Terraform to be used with pre-commit framework](https://github.com/antonbabenko/pre-commit-terraform)
1. Blog post by [Dean Wilson](https://github.com/deanwilson): [pre-commit hooks and terraform - a safety net for your repositories](https://www.unixdaemon.net/tools/terraform-precommit-hooks/)
