---
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/e1Mp2scOX6OnQbifCen3/examples/terraform/small-size-infrastructure
---

# Terraform көмегімен шағын өлшемді инфрақұрылым

Дереккөз: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

Бұл мысал сыртқы тәуелділіктер қолданылмаған, шағын өлшемді инфрақұрылымға арналған Terraform конфигурацияларын құрылымдау мысалы ретінде кодты қамтиды.

{% hint style="success" %}
* Жұмысты бастауға және жүре келе рефакторинг жасауға өте ыңғайлы
* Шағын ресурс модульдері үшін өте қолайлы
* Шағын және сызықтық инфрақұрылым модульдері үшін жақсы (мысалы, [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis))
* Ресурстар саны аз болғанда (20-30-дан аз) жақсы
{% endhint %}

{% hint style="warning" %}
Егер ресурстар саны өссе, барлық ресурстар үшін бір күй (state) файлының болуы Terraform-мен жұмыс істеу процесін баяулатуы мүмкін (ресурстар санын шектеу үшін `-target` аргументін қолдануды қарастырыңыз)
{% endhint %}
