---
description: FTP (Frequent Terraform Problems)
---

# FAQ (Часті запитання)

## Які інструменти я повинен знати та розглянути можливість їх використання?

* [**Terragrunt**](https://terragrunt.gruntwork.io) - Інструмент оркестрування
* [**tflint**](https://github.com/terraform-linters/tflint) - Код лінтер
* [**tfenv**](https://github.com/tfutils/tfenv) - Менеджер версій
* [**Atlantis**](https://www.runatlantis.io) - Автоматизація Pull Request
* [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) - Колекція git хуків для Terraform, щоб використовувати із [pre-commit framework](https://pre-commit.com)
* [**Infracost**](https://www.infracost.io/) - Оцінка вартості інфраструктури для Terraform в pull requests. Працює з Terragrunt, Atlantis, й pre-commit-terraform.

## Чи була у вас можливість відповісти на попереднє запитання?

Так, через кілька місяців ми нарешті знайшли відповідь. На жаль, Майк зараз у відпустці, тому я боюся, що ми не зможемо дати відповідь на даний момент.

## Які є рішення щодо [пекла залежностей](https://en.wikipedia.org/wiki/Dependency\_hell) з модулями?

Необхідно вказувати версії ресурсних та інфраструктурних модулів. Постачальники повинні бути налаштовані за межами модулів, але тільки у композиції. Також можна заблокувати версії провайдерів і Terraform.

Головного інструменту керування залежностями немає, але є декілька порад, щоб зробити пекло залежностей менш проблематичним. Наприклад, [Dependabot](https://dependabot.com) можна використовувати для автоматизації оновлень залежностей. Dependabot створює pull requests, щоб підтримувати ваші залежності в безпеці та актуальності. Dependabot підтримує конфігурації Terraform.
