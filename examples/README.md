# Exemplos de estrutura de códigos

## Estruturas de código do Terraform

{% hint style="info" %}
Esses exemplos estão mostrando o provedor da AWS, mas a maioria dos princípios mostrados nos exemplos pode ser aplicada a outros provedores de núvem pública, bem como a outros tipos de provedores (DNS, DB, Monitoring, etc).
{% endhint %}

| Tipo                                                            | Descrição                                                                                                                                                                          | Disponibilidade       |
| --------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------- |
| [pequeno](terraform/small-size-infrastructure.md)               | Poucos recursos, sem dependências externas. Conta única da AWS. Região única. Ambiente único.                                                                                      | Sim                   |
| [médio](terraform/medium-size-infrastructure.md)                | Diversas contas e ambientes na AWS, módulos de infraestrutura prontos para o uso utilizando o Terraform.                                                                           | Sim                   |
| [grande](terraform/large-size-infrastructure-with-terraform.md) | Muitas contas na AWS, muitas regiões, necessidade urgente de reduzir copiar e colar, módulos de infraestrutura personalizados, uso intenso de composições. Utilizando o Terraform. | Trabalho em progresso |
| muito grande (nível Enterprise)                                 | Diversos provedores (AWS, GCP, Azure). Implementações em diversas nuvens. Utilizando o Terraform.                                                                                  | Não                   |

## Estruturas de código do Terragrunt

| Tipo                            | Descrição                                                                                                                                                                           | Disponibilidade |
| ------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
| médio                           | Diversas contas e ambientes na AWS, módulos de infraestrutura prontos para o uso utilizando o Terragrunt.                                                                           | Não             |
| grande                          | Muitas contas na AWS, muitas regiões, necessidade urgente de reduzir copiar e colar, módulos de infraestrutura personalizados, uso intenso de composições. Utilizando o Terragrunt. | Não             |
| muito grande (nível Enterprise) | Diversos provedores (AWS, GCP, Azure). Implementações em diversas nuvens. Utilizando o Terragrunt.                                                                                  | Não             |
