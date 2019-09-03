# Small-size infrastructure with Terraform

Source: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

This example contains code as an example of structuring Terraform configurations for a small-size infrastructure, where no external dependencies are used.

{% hint style="success" %}
* Perfect to get started and refactor as you go 
* Perfect for small resource modules
* Good for small and linear infrastructure modules \(eg, [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis)\)
* Good for small number of resources \(fewer than 20-30\)
{% endhint %}

{% hint style="warning" %}
Single state file for all resources can make process of working with Terraform slow, if number of resources is growing \(consider using `-target` argument to limit number of resources\)
{% endhint %}



