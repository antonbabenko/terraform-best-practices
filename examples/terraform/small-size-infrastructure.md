# Infraestrutura pequena com o Terraform

Fonte: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

Este exemplo contém código como um exemplo de estruturação de configurações do Terraform para uma infraestrutura de pequeno porte, onde nenhuma dependência externa é utilizada.

{% hint style="success" %}
* Perfeito para começar e refatorar à medida que avança
* Perfeito para pequenos módulos de recursos
* Bom para módulos de infraestrutura pequenos e lineares (ex, [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis))
* Bom para um número pequeno de recursos (menos de 20-30)
{% endhint %}

{% hint style="warning" %}
Um arquivo de estado único para todos os recursos pode tornar o processo de trabalho com o Terraform lento, se o número de recursos estiver crescendo (considere utilizar o argumento [`-target`](https://learn.hashicorp.com/tutorials/terraform/resource-targeting?in=terraform/cli) para limitar o número de recursos)
{% endhint %}
