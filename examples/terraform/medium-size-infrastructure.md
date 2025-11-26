---
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/e1Mp2scOX6OnQbifCen3/examples/terraform/medium-size-infrastructure
---

# Terraform көмегімен орташа өлшемді инфрақұрылым

Дереккөз: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform)

Бұл мысал келесілерді пайдаланатын орташа өлшемді инфрақұрылымға арналған Terraform конфигурацияларын құрылымдау мысалы ретінде кодты қамтиды:

* 2 AWS тіркелгісі
* 2 бөлек орта (бір-бірімен ешнәрсе бөліспейтін `prod` және `stage` ). Әр орта бөлек AWS тіркелгісінде орналасқан.
* Әр орта [Terraform Registry](https://registry.terraform.io/)-ден алынған дайын off-the-shelf инфрақұрылым модулінің  (`alb`) әртүрлі нұсқасын қолданады.
* Each environment uses the same version of an internal module `modules/network` since it is sourced from a local directory.

{% hint style="success" %}
- Инфрақұрылым логикалық түрде бөлінген (бөлек AWS тіркелгілері) жобалар үшін өте қолайлы
- AWS тіркелгілері арасында ортақ ресурстарды өзгерту қажеттілігі болмаған кезде жақсы (бір орта = бір AWS тіркелгісі = бір күй файлы)
- Орталар арасындағы өзгерістерді оркестрациялау қажет болмаған кезде жақсы
- Инфрақұрылым ресурстары әр ортада әдейі әртүрлі болғанда және оларды жалпылау мүмкін болмағанда жақсы (мысалы, кейбір ресурстар бір ортада немесе кейбір аймақтарда жоқ)
{% endhint %}

{% hint style="warning" %}
Жоба өскен сайын, бұл орталарды бір-бірімен жаңартылған күйде ұстау қиынырақ болады. Қайталанатын тапсырмалар үшін инфрақұрылым модульдерін (дайын немесе ішкі) пайдалануды қарастырыңыз.
{% endhint %}

