---
description: FTP (Frequent Terraform Problems)
---

# Частыя пытанні

## Якімі інструментамі мне варта ведаць і разгледзець магчымасць выкарыстання?

* [**Terragrunt**](https://terragrunt.gruntwork.io/) - Інструмент аркестрацыі
* [**tflint**](https://github.com/terraform-linters/tflint) - Кодавы лінтэр
* [**tfenv**](https://github.com/tfutils/tfenv) - Мэнэджэр версій
* [**Atmos**](https://atmos.tools/) - Сучасны кампазіцыйны фрэймворк для Terraform з падтрымкай YAML
* [**asdf-hashicorp**](https://github.com/asdf-community/asdf-hashicorp) - Плагін HashiCorp для менеджара версій [asdf](https://github.com/asdf-vm/asdf)
* [**Atlantis**](https://www.runatlantis.io/) - Аўтаматызацыя Pull Request
* [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) - Зборнік git hooks для Terraform для выкарыстання з [pre-commit framework](https://pre-commit.com/)
* [**Infracost**](https://www.infracost.io) - Ацэнка cloud cost estimates для Terraform у pull requests. Таксама працуе з Terragrunt, Atlantis і pre-commit-terraform.

## Якія ёсць рашэнні для праблемы з [адам залежнасцяў](https://en.wikipedia.org/wiki/Dependency_hell) з модулямі?

Версіі модуляў рэсурсаў і інфраструктуры павінны быць зададзены. Провайдары павінны канфігуравацца па-за модулямі, але толькі ў кампазіцыі. Версію правайдараў і Terraform таксама можна заблакіраваць.

Не існуе адзінага інструмента для кіравання залежнасцямі, але ёсць некалькі парад, як зрабіць спецыфікацыі залежнасцей менш праблемнымі. Напрыклад, [Dependabot](https://dependabot.com/) можна выкарыстоўваць для аўтаматызацыі абнаўленняў залежнасцей. Dependabot стварае pull requests , каб падтрымліваць вашыя залежнасці бяспечнымі і актуальнымі. Dependabot падтрымлівае канфігурацыі Terraform.

