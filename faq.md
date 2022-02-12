---
description: FTP (Frequent Terraform Problems)
---

# FAQ

## Quais são as ferramentas que eu deveria estar ciente e considerar utilizar?

* [**Terragrunt**](https://terragrunt.gruntwork.io) - Orchestration tool
* [**tflint**](https://github.com/terraform-linters/tflint) - Code linter
* [**tfenv**](https://github.com/tfutils/tfenv) - Version manager
* [**Atlantis**](https://www.runatlantis.io) - Pull Request automation
* [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) - Collection of git hooks for Terraform to be used with [pre-commit framework](https://pre-commit.com)

## Você já teve a oportunidade de responder a pergunta anterior?

Sim, depois de alguns meses, finalmente encontramos a resposta. Infelizmente, Mike está de férias agora, então temo que não possamos fornecer a responsta neste momento.

## Quais são as soluções do [Inferno de Dependências](https://pt.wikipedia.org/wiki/Inferno\_de\_depend%C3%AAncias) com módulos?

As versões dos módulos de recursos e infraestrutura devem ser especificadas. Os provedores devem ser configurados fora dos módulos, mas apenas na composição. A versão dos provedores e do Terraform podem também ser travadas.

Não existe uma ferramenta de gerenciamento de dependência mestre, mas existem algumas dicas para tornar a dependência menos problemática. Por exemplo, o [Dependabot](https://dependabot.com) pode ser usado para automatizar as atualizações de dependências seguras e atualizadas. O Dependabot é compatível com as configurações do Terraform.
