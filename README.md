---
description: >-
  Dieses Dokument ist ein Versuch, die besten Praktiken bei der Verwendung von
  Terraform systematisch zu beschreiben und Empfehlungen für die häufigsten
  Probleme zu geben.
---

# Willkommen

[Terraform](https://www.terraform.io/) ist ein relativ neues Projekt (wie die meisten DevOps-Tools), das 2014 gestartet wurde.

Terraform ist leistungsfähig (wenn nicht sogar das leistungsfähigste, das es derzeit gibt) und eines der am häufigsten verwendeten Tools, das die Verwaltung der Infrastruktur als Code ermöglicht. Es erlaubt Entwicklern eine Menge Dinge zu tun und schränkt sie nicht ein, Dinge zu tun, die schwer zu unterstützen oder zu integrieren sind.

Einige der in diesem Buch beschriebenen Informationen mögen nicht als die besten Praktiken erscheinen. Ich weiß das, und um den Lesern zu helfen, zu unterscheiden, was bewährte Praktiken sind und was nur eine andere Art ist, Dinge zu tun, verwende ich manchmal Hinweise, um etwas Kontext zu liefern, und Symbole, um den Reifegrad jedes Unterabschnitts in Bezug auf bewährte Praktiken anzugeben.

Das Buch ist 2018 im sonnigen Madrid entstanden und ist hier kostenlos erhältlich - [https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com/) .

Ein paar Jahre später wurde es mit mehr aktuellen Best Practices aktualisiert, die mit Terraform 1.0 verfügbar waren. Letztendlich sollte dieses Buch die meisten der unbestrittenen besten Praktiken und Empfehlungen für Terraform-Nutzer enthalten.

## Sponsoren

Please [contact me](https://github.com/antonbabenko/terraform-aws-devops#social-links) if you want to become a sponsor.

| [![](.gitbook/assets/cast-logo.png)](https://cast.ai/antonbabenko)                                                             | [CAST AI](https://cast.ai/antonbabenko) — Cut your Kubernetes costs by 60%+ on average. First cluster optimization FREE!                                                            |
| ------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [![](.gitbook/assets/speakeasy-logo.png)](https://speakeasyapi.dev?utm_source=tf_best_practices&utm_medium=github+sponsorship) | [Speakeasy](https://speakeasyapi.dev?utm_source=tf_best_practices&utm_medium=github+sponsorship) — Terraform Providers, SDKs and docs for your API. Make your API enterprise-ready! |

## Übersetzungen

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

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/bJnDvAqIyVgo7LDHgxYJ/" %}
[한국어 (Korean)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/bJnDvAqIyVgo7LDHgxYJ/)
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

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/dcjhau04KQIKHUJA90iN/" %}
[اردو (Urdu)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/dcjhau04KQIKHUJA90iN/)
{% endcontent-ref %}

Kontaktieren Sie mich, wenn Sie bei der Übersetzung dieses Buches in andere Sprachen helfen wollen.

## Beiträge

Ich möchte immer Rückmeldungen erhalten und dieses Buch aktualisieren, wenn die Gemeinschaft reift und neue Ideen umgesetzt und überprüft werden.

Wenn Sie an bestimmten Themen interessiert sind, [eröffnen Sie bitte ein Issue](https://github.com/antonbabenko/terraform-best-practices/issues) oder bewerten Sie ein Issue mit einem Daumen-hoch, von dem Sie möchten, dass es am meisten behandelt werden soll. Wenn Sie das Gefühl haben, dass Sie Inhalte haben und einen Beitrag leisten wollen, schreiben Sie einen Entwurf und reichen Sie einen Pull Request ein (machen Sie sich zu diesem Zeitpunkt keine Sorgen über einen guten Textstil!)

## Autoren

Dieses Buch wird von [Anton Babenko](https://github.com/antonbabenko) mit Hilfe verschiedener Mitwirkender und Übersetzer gepflegt.

## Lizenzen

Dieses Projekt steht unter der Apache-2-Lizenz. Siehe LICENSE für weitere Details.

Die Autoren und Mitwirkenden an diesem Inhalt können die Gültigkeit der hier gefundenen Informationen nicht garantieren. Bitte vergewissern Sie sich, dass Sie verstehen, dass die hier zur Verfügung gestellten Informationen frei zur Verfügung gestellt werden und dass keine Art von Vereinbarung oder Vertrag zwischen Ihnen und Personen, die mit diesem Inhalt oder Projekt in Verbindung stehen, entsteht. Die Autoren und Mitwirkenden übernehmen keine Haftung für Verluste, Schäden oder Störungen, die durch Fehler oder Auslassungen in den Informationen verursacht werden, die in diesem Inhalt enthalten sind, mit ihm in Verbindung stehen oder mit ihm verlinkt sind, unabhängig davon, ob solche Fehler oder Auslassungen auf Fahrlässigkeit, Unfälle oder andere Ursachen zurückzuführen sind.

Copyright © 2018-2023 Anton Babenko.
