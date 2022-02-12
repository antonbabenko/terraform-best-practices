# Estilo de código

{% hint style="info" %}
* Os módulos de exemplos e do Terraform devem conter documentação explicando os recursos e como usá-los.
* Todos os links nos arquivos README.md devem ser absolutos para que o site do Terraform Registry os mostre corretamente.
* A documentação pode incluir diagramas criados com [mermaid](https://github.com/mermaid-js/mermaid) e plantas criadas com o [cloudcraft.co](https://cloudcraft.co).
* Utilize o [Terraform pre-commit hooks](https://github.com/antonbabenko/pre-commit-terraform) para garantir que o código seja válido, formatado corretamente e documentado automaticamente antes de ser enviado para o git e revisado por humanos.
{% endhint %}

## Documentação

### Documentação gerada automaticamente

O [pre-commit](https://pre-commit.com) é um framework para gerenciar e manter hooks pré-commit multi-idioma. Ele é escrito em Python e é uma ferramente poderosa para fazer algo automaticamente na máquina de um desenvolvedor antes que o código seja enviado para o repositório git. Normalmente, ele é usado para executar linters e formatar código (veja [supported hooks](https://pre-commit.com/hooks.html)).

Com as configurações do Terraform, o `pre-commit` pode ser usado para formatar e validar o código, bem como para atualizar a documentação.

Confirma o repositório [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md) para se familiarizar com ele e os repositórios existentes (por exemplo, [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc)) onde ele já é utilizado.

### terraform-docs

O [terraform-docs](https://github.com/segmentio/terraform-docs) é uma ferramente que faz a geração de documentação a partir de módulos Terraform em vários formatos de saída (output). Você pode executá-lo manualmente (sem ganchos — pre-commit hooks — de pré-commit) ou usar o  [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform) para atualizar a documentação automaticamente.

@todo: Document module versions, release, GH actions

## Recursos

1. [pre-commit framework homepage](https://pre-commit.com)
2. [Collection of git hooks for Terraform to be used with pre-commit framework](https://github.com/antonbabenko/pre-commit-terraform)
3. Blog post by [Dean Wilson](https://github.com/deanwilson): [pre-commit hooks and terraform - a safety net for your repositories](https://www.unixdaemon.net/tools/terraform-precommit-hooks/)
