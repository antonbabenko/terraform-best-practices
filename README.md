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

Este livro começou na ensolarada Madri em 2018 e está disponível gratuitamente aqui - [https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com)

Alguns anos depois, ele foi atualizado com mais práticas atuais recomendadas disponíveis com o Terraform 1.0. Eventualmente, este livro deve conter a maioria das melhores práticas e recomendações incontestáveis para usuários do Terraform.

## Patrocinadores

Please [contact me](https://github.com/antonbabenko/terraform-aws-devops#social-links) if you want to become a sponsor.

| [![](.gitbook/assets/ctf-logo.png)](https://compliance.tf/?utm_source=tf_best_practices&utm_medium=sponsorship) | [Compliance.tf](https://compliance.tf/?utm_source=tf_best_practices&utm_medium=sponsorship) — Terraform Compliance Simplified. Make your Terraform modules compliance-ready. |
| --------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [![](.gitbook/assets/)]()                                                                                       | []() —                                                                                                                                                                       |

## Traduções

{% content-ref url="https://app.gitbook.com/s/u3iITRIHQx97ro2PkfdC/" %}
[العربية (Arabic)](https://app.gitbook.com/s/u3iITRIHQx97ro2PkfdC/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/PJbgKPAX0ohEMLpETpg7/" %}
[Bosanski (Bosnian)](https://app.gitbook.com/s/PJbgKPAX0ohEMLpETpg7/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/e1Mp2scOX6OnQbifCen3/" %}
[English](https://app.gitbook.com/s/e1Mp2scOX6OnQbifCen3/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/6shyPtr2KrqW4ANbFXYg/" %}
[Français (French)](https://app.gitbook.com/s/6shyPtr2KrqW4ANbFXYg/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/DyguS0uZfMW7X7m9BWx1/" %}
[ქართული (Georgian)](https://app.gitbook.com/s/DyguS0uZfMW7X7m9BWx1/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/PKopCWJZbhpQ9FT0W8tL/" %}
[Deutsch (German)](https://app.gitbook.com/s/PKopCWJZbhpQ9FT0W8tL/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/5c1kFpqxaDZC2g9e6rtT/" %}
[ελληνικά (Greek)](https://app.gitbook.com/s/5c1kFpqxaDZC2g9e6rtT/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/4bq6CyY8vYiEHkjN63rT/" %}
[עברית (Hebrew)](https://app.gitbook.com/s/4bq6CyY8vYiEHkjN63rT/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/Mgong4S6IjtibE055zUM/" %}
[हिंदी (Hindi)](https://app.gitbook.com/s/Mgong4S6IjtibE055zUM/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/ZLCz7lNWbSJxDGuNOI44/" %}
[Bahasa Indonesia (Indonesian)](https://app.gitbook.com/s/ZLCz7lNWbSJxDGuNOI44/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/8VlMHbHDbW6qRWdgN5oU/" %}
[Italiano (Italian)](https://app.gitbook.com/s/8VlMHbHDbW6qRWdgN5oU/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/3vykLOWgdQLPLgHtxqQH/" %}
[日本語 (Japanese)](https://app.gitbook.com/s/3vykLOWgdQLPLgHtxqQH/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/BoZVs6O2OJFQLNV1utmm/" %}
[ಕನ್ನಡ (Kannada)](https://app.gitbook.com/s/BoZVs6O2OJFQLNV1utmm/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/bJnDvAqIyVgo7LDHgxYJ/" %}
[한국어 (Korean)](https://app.gitbook.com/s/bJnDvAqIyVgo7LDHgxYJ/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/9yChMGbFo2G47Wiow1yY/" %}
[Polski (Polish)](https://app.gitbook.com/s/9yChMGbFo2G47Wiow1yY/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/sFM1GW5TPCGsskQ03mTm/" %}
[Română (Romanian)](https://app.gitbook.com/s/sFM1GW5TPCGsskQ03mTm/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/5VD4NK4mHOY8SWjC9N5e/" %}
[简体中文 (Simplified Chinese)](https://app.gitbook.com/s/5VD4NK4mHOY8SWjC9N5e/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/fTxekzr50pIuGmrPkXUD/" %}
[Español (Spanish)](https://app.gitbook.com/s/fTxekzr50pIuGmrPkXUD/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/Fedpbc5NbKjynXI8xTeF/" %}
[Türkçe (Turkish)](https://app.gitbook.com/s/Fedpbc5NbKjynXI8xTeF/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/tXRvMPILxeJaJTM2CsSq/" %}
[Українська (Ukrainian)](https://app.gitbook.com/s/tXRvMPILxeJaJTM2CsSq/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/dcjhau04KQIKHUJA90iN/" %}
[اردو (Urdu)](https://app.gitbook.com/s/dcjhau04KQIKHUJA90iN/)
{% endcontent-ref %}

Entre em contato se você quer ajudar a traduzir este livro para outros idiomas.

## Contribuições

Continuarei atualizando este livro conforme a comunidade amadurece e novas ideias são implementadas e verificadas. Por favor, deixe seu comentário ou crítica construtiva para que o livro esteja sempre em boa qualidade.

Se você tem interesse em determinados tópicos, [abra um problema no Github](https://github.com/antonbabenko/terraform-best-practices/issues), ou curta um já aberto que você julga ser importante e deva ter prioridade.

## Autores

Este livro é mantido por [Anton Babenko](https://github.com/antonbabenko) com a ajuda de diversos colaboradores e tradutores.

## Licença

Este trabalho está licenciado sob a Licença Apache 2. Veja LICENSE para maiores detalhes.

Os autores e colaboradores deste conteúdo não podem garantir a validade das informações aqui encontradas. Certifique-se de que entende que as informações aqui contidas estão sendo fornecidas livremente, e que, nenhum acordo ou contrato é criado entre você e quaisquer pessoas associadas a este conteúdo ou projeto. Os autores e colaboradores não assumem e, por meio deste, se isentam de qualquer responsabilidade perante qualquer parte, por qualquer perda, dano ou interrupção causada por erros, ou omissões nas informações contidas, associadas ou vinculadas a este conteúdo, sejam tais erros ou omissões resultantes de negligência, acidente ou qualquer outra causa.

Direito autoral © 2018-2023 Anton Babenko.
