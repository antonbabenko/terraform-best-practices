---
description: >-
  Ten dokument jest próbą opisania najlepszych praktyk dotyczących korzystania z
  Terraform i przedstawia zalecenia związane z najczęstszymi problemami, z
  jakimi spotykają się użytkownicy_czki Terraform.
---

# Cześć!

[Terraform](https://www.terraform.io) to dość nowy projekt (jak większość narzędzi DevOps), który zaistniał w 2014 roku.

Terraform jest potężnym (jeśli nie najpotężniejszym) i jednym z najczęściej używanych narzędzi, który umożliwia zarządzanie infrastrukturą jako kodem. Pozwala programistom\_ką rozwiązywać wiele różnych problemów infrastrukturalnych tak, aby dało się to dalej łatwo wspierać, integrować i rozwijać.

Niektóre informacje opisane w tej książce mogą wydawać się nieoptymalnymi praktykami. Jestem tego świadom. Czasem zachodzi potrzeba pomocy czytelnikom\_czkom w oddzieleniu tego, co jest powszechnie znanymi najlepszymi praktykami, a co jest po prostu kolejnym subiektywnym sposobem robienia rzeczy. Używam wtedy wskazówek, aby zapewnić kontekst oraz ikony, które określają poziom trudności w każdej podsekcji dotyczącej najlepszych praktyk.

Historia tej książki rozpoczęła się w słonecznym Madrycie w 2018 roku i jest dostępna za darmo pod tym linkiem - [https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com).

Kilka lat później został on zaktualizowany o najnowsze zalecane praktyki dostępne w Terraform 1.0. Ostatecznie — ta książka powinna zawierać większość praktyk i zaleceń dla użytkowników Terraform, które można uznać za bezdyskusyjnie najlepsze.

## Tłumaczenia

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/" %}
[Español (Spanish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/" %}
[Bahasa Indonesia (Indonesian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/" %}
[Français (French)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/)
{% endcontent-ref %}

Skontaktuj się ze [mną](mailto:anton@antonbabenko.com), jeśli chcesz pomóc przetłumaczyć tę książkę na inne języki.

## Wsparcie i współpraca

Zawsze chętnie usłyszę wasze opinie i zaktualizuje tę książkę. Społeczność ciągle dojrzewa, a nowe pomysły są weryfikowane i wdrażane.

Jeśli jesteś zainteresowany konkretnymi tematami, [otwórz nowy wątek (issue)](https://github.com/antonbabenko/terraform-best-practices/issues) lub daj kciuk w górę przy istniejącym, który chcesz poruszyć najbardziej. **Jeśli chcesz wnieść swój wkład do książki,** wprowadź zmianę i utwórz pull request (nie martw się czy to co napisałeś\_aś jest idealne od samego początku!)\


## Autorzy\_ki

Ta książka jest pod opieką [Anton Babenko](https://github.com/antonbabenko) oraz wielu innych współautorów\_ek i __ tłumaczy_\__ek.

## Sponsorowanie

| [![](.gitbook/assets/cluster-dev-logo-site.png)](https://cluster.dev) | [Cluster.dev](http://cluster.dev) — jedyne takie narzędzie do infrastruktury cloud-native. |
| --------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |

## Licencja

Ta praca jest objęta licencją Apache 2. Zobacz _LICENSE_, aby uzyskać szczegółowe informacje.

Autorzy\_rki __ i __ współtwórcy\_czynie treści nie mogą zagwarantować aktualności oraz poprawności informacji tutaj znalezionych. Upewnij się, że rozumiesz, iż informacje podane tutaj są dostarczane dobrowolnie i że między Tobą a jakimikolwiek osobami związanymi z tą treścią lub projektem nie powstaje żadna umowa ani kontrakt. Autorzy\_rki __ i __ współtwórcy\_czynie nie przyjmują i niniejszym zrzekają się jakiejkolwiek odpowiedzialności wobec jakiejkolwiek strony za jakiekolwiek straty, szkody, lub zakłócenia spowodowane błędami, lub pominięciami w informacjach zawartych w tych treściach, powiązanych z nimi lub z nimi połączonych, niezależnie od tego, czy takie błędy lub pominięcia wynikają z zaniedbania, wypadku lub jakiejkolwiek innej przyczyny.

Prawa autorskie © 2018-2022 Anton Babenko.
