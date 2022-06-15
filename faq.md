---
description: FTP (Frequent Terraform Problems), czyli najczęstsze problemy z Terraform
---

# FAQ

## Jakich narzędzi muszę używać?

* [**Terragrunt**](https://terragrunt.gruntwork.io) - narzędzie do orkiestracji
* [**tflint**](https://github.com/terraform-linters/tflint) - linter kodu
* [**tfenv**](https://github.com/tfutils/tfenv) - menadżer wersji
* [**Atlantis**](https://www.runatlantis.io) - narzędzie do automatyzacji pull-requestów
* [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) - Zbiór git hooków dla Terraforma do użycia z [pre-commit framework](https://pre-commit.com)
* [**Infracost**](https://infracost.io) - Oszacowywanie kosztów chmury w pull requestach. Działa z Terragrunt, Atlantis a także pre-commit-terrraform.

## Jakie są rozwiązania [piekła zależności](https://pl.wikipedia.org/wiki/Piek%C5%82o\_zale%C5%BCno%C5%9Bci) (dependency hell) z modułami?

Należy określić wersje modułów zasobów i infrastruktury. Dostawcy powinni być skonfigurowani poza modułami, ale tylko w kompozycji. Wersję dostawców i Terraform można również zablokować.

Nie ma głównego narzędzia do zarządzania zależnościami, ale jest kilka wskazówek, dzięki którym piekło zależności będzie mniej problematyczne. Na przykład [Dependabot](https://dependabot.com) może służyć do automatyzacji aktualizacji zależności. Dependabot tworzy pull requesty, aby Twoje zależności były bezpieczne i aktualne. Dependabot obsługuje konfiguracje Terraform.
