# Infraestrutura média com o Terraform

Fonte: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform)

Este exemplo contém código como um exemplo de estruturação de configurações do Terraform para uma infraestrutura de médio porte, que utiliza:

* 2 contas na AWS
* 2 ambientes separados (`prod` e `stage` que não compartilham nada entre eles). Cada ambiente está em uma conta separada na AWS.
* Cada ambiente utiliza uma versão diferente do módulo de infraestrutura pronto para uso (`alb`) originado do [Terraform Registry](https://registry.terraform.io)
* Cada ambiente utiliza a mesma versão de `módulos/rede` de um módulo interno, pois é originado de um diretório local.

{% hint style="success" %}
* Perfeito para projetos em que a infraestrutura é separada logicamente (contas AWS separadas)
* Bom para quando não há necessidade de modificar recursos compartilhados entre contas da AWS (um ambiente = uma conta da AWS = um arquivo de estado)
* Bom para quando não há necessidade na orquestração de mudanças entre os ambientes
* Bom para quando os recursos de infraestrutura são diferentes por ambiente de propósito e não podem ser generalizados (por exemplo, alguns recursos estão ausentes em um ambiente ou em algumas regiões)
{% endhint %}

{% hint style="warning" %}
À medida que o projeto cresce, será mais difícil manter esses ambientes atualizados entre sí. Considere o uso de módulos de infraestrutura (já prontos ou internos) para tarefas repetíveis.
{% endhint %}

##
