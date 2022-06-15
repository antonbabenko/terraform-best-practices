---
description: FTP (Frequent Terraform Problems)
---

# FAQ

## Quais são as ferramentas que eu deveria estar ciente e considerar utilizar?

* [**Terragrunt**](https://terragrunt.gruntwork.io) - Ferramenta de orquestração
* [**tflint**](https://github.com/terraform-linters/tflint) - Ferramenta de checagem de código
* [**tfenv**](https://github.com/tfutils/tfenv) - Sistema de controle de versão
* [**Atlantis**](https://www.runatlantis.io) - Automação de Pull Requests
* [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) - Coleção de git hooks para Terraform para ser usado com o [framework pre-commit](https://pre-commit.com)
* [**Infracost**](https://infracost.io) - Estimativas de custo de nuvem para Terraform em solicitações de Pull Requests. Funciona com Terragrunt, Atlantis e pré-commits também.

## Você já teve a oportunidade de responder a pergunta anterior?

Sim, depois de alguns meses, finalmente encontramos a resposta. Infelizmente, Mike está de férias agora, então temo que não possamos fornecer a responsta neste momento.

## Quais são as soluções do [Inferno de Dependências](https://pt.wikipedia.org/wiki/Inferno\_de\_depend%C3%AAncias) com módulos?

As versões dos módulos de recursos e infraestrutura devem ser especificadas. Os provedores devem ser configurados fora dos módulos, mas apenas na composição. A versão dos provedores e do Terraform podem também ser travadas.

Não existe uma ferramenta de gerenciamento de dependência mestre, mas existem algumas dicas para tornar a dependência menos problemática. Por exemplo, o [Dependabot](https://dependabot.com) pode ser usado para automatizar as atualizações de dependências seguras e atualizadas. O Dependabot é compatível com as configurações do Terraform.
