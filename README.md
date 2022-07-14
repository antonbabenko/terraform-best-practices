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

## Übersetzungen

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/e1Mp2scOX6OnQbifCen3/" %}
[English](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/e1Mp2scOX6OnQbifCen3/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/" %}
[Español (Spanish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/" %}
[Bahasa Indonesia (Indonesian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/" %}
[Français (French)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/8VlMHbHDbW6qRWdgN5oU/" %}
[Italiano (Italian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/8VlMHbHDbW6qRWdgN5oU/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/" %}
[Português (Brazilian Portuguese)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/" %}
[Polski (Polish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/" %}
[Українська (Ukrainian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/)
{% endcontent-ref %}

Kontaktieren Sie mich, wenn Sie bei der Übersetzung dieses Buches in andere Sprachen helfen wollen.

## Beiträge

Ich möchte immer Rückmeldungen erhalten und dieses Buch aktualisieren, wenn die Gemeinschaft reift und neue Ideen umgesetzt und überprüft werden.

Wenn Sie an bestimmten Themen interessiert sind, [eröffnen Sie bitte ein Issue](https://github.com/antonbabenko/terraform-best-practices/issues) oder bewerten Sie ein Issue mit einem Daumen-hoch, von dem Sie möchten, dass es am meisten behandelt werden soll. Wenn Sie das Gefühl haben, dass Sie Inhalte haben und einen Beitrag leisten wollen, schreiben Sie einen Entwurf und reichen Sie einen Pull Request ein (machen Sie sich zu diesem Zeitpunkt keine Sorgen über einen guten Textstil!)

## Autoren

Dieses Buch wird von [Anton Babenko](https://github.com/antonbabenko) mit Hilfe verschiedener Mitwirkender und Übersetzer gepflegt.

## Sponsoren

| [<img src=".gitbook/assets/cluster-dev-logo-site.png" alt="" data-size="original">](https://cluster.dev/) | [Cluster.dev](http://cluster.dev/) — the only manager for cloud-native infrastructures.                  |
| --------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| [![](.gitbook/assets/coder-logo-for-sponsor.png)](http://coder.com/)                                      | [Coder.com](http://coder.com/) — create remote development machines for your team, powered by Terraform. |

## Lizenzen

Dieses Projekt steht unter der Apache-2-Lizenz. Siehe LICENSE für weitere Details.

Die Autoren und Mitwirkenden an diesem Inhalt können die Gültigkeit der hier gefundenen Informationen nicht garantieren. Bitte vergewissern Sie sich, dass Sie verstehen, dass die hier zur Verfügung gestellten Informationen frei zur Verfügung gestellt werden und dass keine Art von Vereinbarung oder Vertrag zwischen Ihnen und Personen, die mit diesem Inhalt oder Projekt in Verbindung stehen, entsteht. Die Autoren und Mitwirkenden übernehmen keine Haftung für Verluste, Schäden oder Störungen, die durch Fehler oder Auslassungen in den Informationen verursacht werden, die in diesem Inhalt enthalten sind, mit ihm in Verbindung stehen oder mit ihm verlinkt sind, unabhängig davon, ob solche Fehler oder Auslassungen auf Fahrlässigkeit, Unfälle oder andere Ursachen zurückzuführen sind.

Copyright © 2018-2022 Anton Babenko.
