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

Historia tej książki rozpoczęła się w słonecznym Madrycie w 2018 roku i jest dostępna za darmo pod tym linkiem - [https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com)

Kilka lat później został on zaktualizowany o najnowsze zalecane praktyki dostępne w Terraform 1.0. Ostatecznie — ta książka powinna zawierać większość praktyk i zaleceń dla użytkowników Terraform, które można uznać za bezdyskusyjnie najlepsze.

## Sponsorowanie

Please [contact me](https://github.com/antonbabenko/terraform-aws-devops#social-links) if you want to become a sponsor.

| [![](.gitbook/assets/cast-logo.png)](https://cast.ai/antonbabenko)                                                             | [CAST AI](https://cast.ai/antonbabenko) — Cut your Kubernetes costs by 60%+ on average. First cluster optimization FREE!                                                                        |
| ------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [![](.gitbook/assets/speakeasy-logo.png)](https://speakeasyapi.dev?utm_source=tf_best_practices&utm_medium=github+sponsorship) | [Speakeasy](https://speakeasyapi.dev?utm_source=tf_best_practices&utm_medium=github+sponsorship) — Speakeasy — Terraform Providers, SDKs and docs for your API. Make your API enterprise-ready! |

## Tłumaczenia

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/u3iITRIHQx97ro2PkfdC/" %}
[العربية (Arabic)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/u3iITRIHQx97ro2PkfdC/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/PJbgKPAX0ohEMLpETpg7/" %}
[Bosanski (Bosnian)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/PJbgKPAX0ohEMLpETpg7/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/" %}
[Português (Brazilian Portuguese)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/e1Mp2scOX6OnQbifCen3/" %}
[English](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/e1Mp2scOX6OnQbifCen3/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/" %}
[Français (French)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/DyguS0uZfMW7X7m9BWx1/" %}
[ქართული (Georgian)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/DyguS0uZfMW7X7m9BWx1/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/PKopCWJZbhpQ9FT0W8tL/" %}
[Deutsch (German)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/PKopCWJZbhpQ9FT0W8tL/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/5c1kFpqxaDZC2g9e6rtT/" %}
[ελληνικά (Greek)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/5c1kFpqxaDZC2g9e6rtT/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/4bq6CyY8vYiEHkjN63rT/" %}
[עברית (Hebrew)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/4bq6CyY8vYiEHkjN63rT/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/Mgong4S6IjtibE055zUM/" %}
[हिंदी (Hindi)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/Mgong4S6IjtibE055zUM/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/" %}
[Bahasa Indonesia (Indonesian)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/8VlMHbHDbW6qRWdgN5oU/" %}
[Italiano (Italian)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/8VlMHbHDbW6qRWdgN5oU/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/BoZVs6O2OJFQLNV1utmm/" %}
[ಕನ್ನಡ (Kannada)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/BoZVs6O2OJFQLNV1utmm/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/sFM1GW5TPCGsskQ03mTm/" %}
[Română (Romanian)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/sFM1GW5TPCGsskQ03mTm/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/5VD4NK4mHOY8SWjC9N5e/" %}
[简体中文 (Simplified Chinese)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/5VD4NK4mHOY8SWjC9N5e/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/" %}
[Español (Spanish)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/Fedpbc5NbKjynXI8xTeF/" %}
[Türkçe (Turkish)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/Fedpbc5NbKjynXI8xTeF/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/" %}
[Українська (Ukrainian)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/)
{% endcontent-ref %}

Skontaktuj się ze [mną](mailto:anton@antonbabenko.com), jeśli chcesz pomóc przetłumaczyć tę książkę na inne języki.

## Wsparcie i współpraca

Zawsze chętnie usłyszę wasze opinie i zaktualizuje tę książkę. Społeczność ciągle dojrzewa, a nowe pomysły są weryfikowane i wdrażane.

Jeśli jesteś zainteresowany konkretnymi tematami, [otwórz nowy wątek (issue)](https://github.com/antonbabenko/terraform-best-practices/issues) lub daj kciuk w górę przy istniejącym, który chcesz poruszyć najbardziej. **Jeśli chcesz wnieść swój wkład do książki,** wprowadź zmianę i utwórz pull request (nie martw się czy to co napisałeś\_aś jest idealne od samego początku!)\\

## Autorzy\_ki

Ta książka jest pod opieką [Anton Babenko](https://github.com/antonbabenko) oraz wielu innych współautorów\_ek i \_\_ tłumaczy\_\_\_ek.

## Licencja

Ta praca jest objęta licencją Apache 2. Zobacz _LICENSE_, aby uzyskać szczegółowe informacje.

Autorzy\_rki \_\_ i \_\_ współtwórcy\_czynie treści nie mogą zagwarantować aktualności oraz poprawności informacji tutaj znalezionych. Upewnij się, że rozumiesz, iż informacje podane tutaj są dostarczane dobrowolnie i że między Tobą a jakimikolwiek osobami związanymi z tą treścią lub projektem nie powstaje żadna umowa ani kontrakt. Autorzy\_rki \_\_ i \_\_ współtwórcy\_czynie nie przyjmują i niniejszym zrzekają się jakiejkolwiek odpowiedzialności wobec jakiejkolwiek strony za jakiekolwiek straty, szkody, lub zakłócenia spowodowane błędami, lub pominięciami w informacjach zawartych w tych treściach, powiązanych z nimi lub z nimi połączonych, niezależnie od tego, czy takie błędy lub pominięcia wynikają z zaniedbania, wypadku lub jakiejkolwiek innej przyczyny.

Prawa autorskie © 2018-2023 Anton Babenko.
