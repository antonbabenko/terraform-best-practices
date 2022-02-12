---
description: >-
  Este documento é uma tentativa de descrever sistematicamente as melhores
  práticas usando o Terraform, e, fornecer recomendações para os problemas mais
  frequentes de seus usuários.
---

# Seja Bem-Vindo(a)

O [Terraform](https://www.terraform.io) é um projeto relativamente novo (como a maioria das ferramentas de DevOps, na verdade) que foi iniciado em 2014.

O Terraform é poderoso (se não o mais poderoso que existe atualmente) e uma das ferramentas mais utilizadas que permitem o gerenciamento de infraestrutura como código (IaC). Ele permite que os desenvolvedores realizem uma grande variedade de coisas e não os restringe de fazê-las de forma com que sejam difíceis de integrar ou suportar à longo prazo.

Algumas informações descritas neste livro podem não parecer as melhores práticas. Sei disso, e, para ajudar os leitores a separar as melhores práticas estabelecidas e do que apenas mais uma maneira opinativa, às vezes, dou dicas para fornecer algum contexto e ícones para especificar o nível de maturidade em cada subseção relacionada às melhores práticas.

Este livro começou na ensolarada Madri em 2018 e está disponível gratuitamente aqui - [https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com) .

Alguns anos depois, ele foi atualizado com mais práticas atuais recomendadas disponíveis com o Terraform 1.0. Eventualmente, este livro deve conter a maioria das melhores práticas e recomendações incontestáveis para usuários do Terraform.

## Traduções

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/" %}
[Español (Spanish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/" %}
[Bahasa Indonesia (Indonesian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/" %}
[Français (French)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/)
{% endcontent-ref %}

Entre em contato se você quer ajudar a traduzir este livro para outros idiomas.

## Contribuições

Continuarei atualizando este livro conforme a comunidade amadurece e novas ideias são implementadas e verificadas. Por favor, deixe seu comentário ou crítica construtiva para que o livro esteja sempre em boa qualidade.

Se você tem interesse em determinados tópicos, [abra um problema no Github](https://github.com/antonbabenko/terraform-best-practices/issues), ou curta um já aberto que você julga ser importante e deva ter prioridade.

## Autores

Este livro é mantido por [Anton Babenko](https://github.com/antonbabenko) com a ajuda de diversos colaboradores e tradutores.

## Patrocinadores

| [![](.gitbook/assets/cluster-dev-logo-site.png)](https://cluster.dev) | [Cluster.dev](http://cluster.dev) — o único gerenciador de infraestruturas nativas da núvem. |
| --------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |

## Licença

Este trabalho está licenciado sob a Licença Apache 2. Veja LICENSE para maiores detalhes.

Os autores e colaboradores deste conteúdo não podem garantir a validade das informações aqui encontradas. Certifique-se de que entende que as informações aqui contidas estão sendo fornecidas livremente, e que, nenhum acordo ou contrato é criado entre você e quaisquer pessoas associadas a este conteúdo ou projeto. Os autores e colaboradores não assumem e, por meio deste, se isentam de qualquer responsabilidade perante qualquer parte, por qualquer perda, dano ou interrupção causada por erros, ou omissões nas informações contidas, associadas ou vinculadas a este conteúdo, sejam tais erros ou omissões resultantes de negligência, acidente ou qualquer outra causa.

Direito autoral © 2018-2022 Anton Babenko.
