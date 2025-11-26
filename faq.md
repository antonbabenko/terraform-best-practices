---
description: FTP (Frequent Terraform Problems - Terraform-да жиі кездесетін мәселелер)
metaLinks:
  alternates:
    - https://app.gitbook.com/s/e1Mp2scOX6OnQbifCen3/faq
---

# ЖҚС (FAQ)

### Қандай құралдарды білуім керек және қолдануды қарастыруым керек?

* [**Terragrunt**](https://terragrunt.gruntwork.io/) - Оркестрация құралы
* [**tflint**](https://github.com/terraform-linters/tflint) - Код линтері
* [**tfenv**](https://github.com/tfutils/tfenv) - Нұсқа менеджері
* [**Atmos**](https://atmos.tools/) - YAML-ге негізделген Terraform-ға арналған заманауи композициялық фреймворк
* [**asdf-hashicorp**](https://github.com/asdf-community/asdf-hashicorp) - [asdf](https://github.com/asdf-vm/asdf) нұсқа менеджеріне арналған HashiCorp плагині
* [**Atlantis**](https://www.runatlantis.io/) - Pull Request-ті автоматтандыру
* [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) -  [pre-commit framework](https://pre-commit.com/) бірге қолданылатын Terraform-ға арналған git хуктарының жинағы
* [**Infracost**](https://www.infracost.io) - Pull request-тердегі Terraform үшін бұлттық шығындар сметасы. Terragrunt, Atlantis және pre-commit-terraform-мен де жұмыс істейді.

### Модульдердегі «[тәуелділік тозағының](https://en.wikipedia.org/wiki/Dependency_hell)» шешімдері қандай?

Ресурс және инфрақұрылым модульдерінің нұсқалары көрсетілуі тиіс. Провайдерлер модульдерден тыс, бірақ тек композицияда бапталуы керек. Провайдерлер мен Terraform нұсқаларын да бекітіп қоюға (lock) болады.

Тәуелділікті басқаратын әмбебап (master) құрал жоқ, бірақ тәуелділік сипаттамаларын проблемасыз етуге арналған бірнеше кеңестер бар. Мысалы, тәуелділік жаңартуларын автоматтандыру үшін [Dependabot](https://dependabot.com/) қолдануға болады. Dependabot тәуелділіктеріңізді қауіпсіз және жаңартылған күйде ұстау үшін pull request-тер жасайды. Dependabot Terraform конфигурацияларына қолдау көрсетеді.
