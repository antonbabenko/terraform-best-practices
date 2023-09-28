---
description: >-
  Ovaj dokument ima za cilj da se sistematski opišu najbolje prakse prilikom
  korištenja Terrafrom alata kao i da se daju preporuke za najčešće probleme sa
  kojima se susreću korisnici Terraforma.
---

# Dobro došli

[Terraform](https://www.terraform.io) je relativno nov alat (kao i većina ostalih DevOps alata) koji je započet 2014. godine.

Terrraform je moćan (ako ne i najmoćniji) i jedan od najkorištenijih alata koji vam dozvoljavaju upravljanje infrastrukturom kao kodom. Dozvoljava programerima da rade mnoge stvari i ne ograničava ih da te stvari rade na način koji bi bio težak za podršku ili integraciju.

Neke informacije opisane u ovoj knjizi možda ne izgledaju kao najbolje prakse. Ja to znam, i da bi pomogao čitaocima da razdvoje šta su ustaljene najbolje prakse, a šta je samo još jedno misljenje o tome kako treba raditi stvari, ponekad koristim pomoćne dijelove koda kako bi dao širi kontekst. Također ponekad koristim savjete kako bi dao dodatni kontekst i ikone da bi specificirao o kojem nivou zrelosti se radi za svaku podsekciju vezanu za najbolje prakse

Ova knjiga je započeta u sunčanom Madridu, 2018. godine i dostupna je besplatno za preuzimanje preko sljedećeg linka [https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com).

Nekoliko godina kasnije je ažurirana sa aktuelnim najboljim praksama dostupnim sa Terrafrmom 1.0. U konačnici ova knjiga bi trebala sadržavati većinu neospornih najboljih praksi za korisnike Terrafroma.

## Sponzori

Please [contact me](https://github.com/antonbabenko/terraform-aws-devops#social-links) if you want to become a sponsor.

| [![](.gitbook/assets/cast-logo.png)](https://cast.ai/antonbabenko)                                                             | [CAST AI](https://cast.ai/antonbabenko) — Cut your Kubernetes costs by 60%+ on average. First cluster optimization FREE!                                                            |
| ------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [![](.gitbook/assets/speakeasy-logo.png)](https://speakeasyapi.dev?utm_source=tf_best_practices&utm_medium=github+sponsorship) | [Speakeasy](https://speakeasyapi.dev?utm_source=tf_best_practices&utm_medium=github+sponsorship) — Terraform Providers, SDKs and docs for your API. Make your API enterprise-ready! |

## Prevodi

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/u3iITRIHQx97ro2PkfdC/" %}
[العربية (Arabic)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/u3iITRIHQx97ro2PkfdC/)
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

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/" %}
[Polski (Polish)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/)
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

Kontaktirajte me ukoliko želite prevesti ovu knjigu i na druge jezike.

## Kontribucije

Uvijek želim da dobijem povratnu informaciju kako bi mogao da ovu knjigu držim ažuriranom. Kako zajednica napreduje, i dolaze nove ideje i prijedlozi za ažuriranje, ažuriranja su impletirane i verifikovane sa vremena na vrijeme.&#x20;

Ako ste zainteresovani za neku posebnu temu koja već nije obrađena unutar ove knjige, molim vas da ga je predložite [ovdje,](https://github.com/antonbabenko/terraform-best-practices/issues) ili glasajte za neku od vec predloženih tema koje bi željeli da vidite u ovoj knjizi. Ako mislite da **imate sadržaj** koji bi se trebao naći u ovoj knjizi i želite da doprinesete, napišite prijedlog i napravite zahtijev za izmjenom (nemojte se opterećivati o stilu pisanja teksta u ovom trenutku!).

## Autori

Ova knjiga je održavana od strane [Antona Babenka](https://github.com/antonbabenko) uz pomoć različitih kontributora i prevoditelja.&#x20;

## Licenca

Rad na ovoj knjizi je licenciran pod Apache 2 licencom. Pogledajte LICENCU za vise informacija.&#x20;

Autori i oni koji su doprinijeli pisanju sadržaja ove knjige ne mogu garantovati za ispravnost informacija koje ćete ovdje pronaći. Molim vas vodite računa da razumijete, da informacije koje su ponuđene u ovo knjizi su proizvod slobodne volje, i nikakva vrsta dogovora ili ugovora nije napravljena između vas i osoba koje su povezane sa sadržajem knjige ili samim projektom. Autori i oni koji su doprinijeli pisanju knjige nisu odgovorni za bilo kakve eventulne posljedice koje mogu proisteći iz korištenja sadržaja ove knjige.

Autorska prava © 2018-2023 Anton Babenko.
