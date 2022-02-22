# Stylizacja kodu

{% hint style="info" %}
* Przykłady i moduły Terraform powinny zawierać dokumentację wyjaśniającą funkcje i sposoby ich używania.
* Wszystkie linki w plikach `README.md` powinny być bezwzględne, aby witryna Terraform Registry wyświetlała je poprawnie.
* Dokumentacja może zawierać schematy stworzone za pomocą [mermaid](https://github.com/mermaid-js/mermaid) i plany stworzone za pomocą [cloudcraft.co](https://cloudcraft.co).
* Korzystaj z [pre-commit hooks dla Terraform](https://github.com/antonbabenko/pre-commit-terraform), aby upewnić się, że kod jest prawidłowy, odpowiednio sformatowany i automatycznie udokumentowany przed przekazaniem go do git'a i sprawdzeniem przez innych.
{% endhint %}

## Dokumentacja

### Dokumentacja generowana automatycznie

[pre-commit](https://pre-commit.com) to framework do zarządzania i utrzymywania różnorodnych narzędzi do sprawdzania kodu przed jego wysłaniem do zdalnego repozytorium. Jest napisanym w Pythonie potężnym narzędziem do automatyzacji żmudnych czynności na maszynie programisty, zanim kod zostanie przekazany do repozytorium git. Zwykle jest używany do uruchamiania linterów i formatowania kodu (zobacz [supported hooks](https://pre-commit.com/hooks.html)).

Dzięki konfiguracjom Terraform `pre-commit` może służyć do formatowania i sprawdzania poprawności kodu, a także do aktualizowania dokumentacji.

Sprawdź [repozytorium pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md). Zapoznaj się z nim oraz istniejącym repozytoriami (np. [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc)), w których jest ono już używane.

### terraform-docs

[terraform-docs](https://github.com/segmentio/terraform-docs) to narzędzie, które generuje dokumentację z modułów Terraform w różnych formatach wyjściowych. Możesz uruchomić go ręcznie (bez pre-commit hooków) lub użyć [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform), aby automatycznie zaktualizować dokumentację.

## Źródła

1. [Strona narzędzia pre-commit](https://pre-commit.com)
2. [Zbiór git hooków dla Terraform](https://github.com/antonbabenko/pre-commit-terraform)
3. Post napisany przez [Dean Wilson](https://github.com/deanwilson): [pre-commit hooks and terraform - a safety net for your repositories](https://www.unixdaemon.net/tools/terraform-precommit-hooks/)
