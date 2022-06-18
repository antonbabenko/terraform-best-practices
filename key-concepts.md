# Grundlegende Konzepte

Die offizielle Terraform-Dokumentation beschreibt [alle Aspekte der Konfiguration im Detail](https://www.terraform.io/docs/configuration/index.html). Lesen Sie sie sorgfältig, um den Rest dieses Abschnitts zu verstehen.

In diesem Abschnitt werden die wichtigsten Konzepte beschrieben, die in diesem Buch verwendet werden.

## Ressource

`aws_vpc`, `aws_db_instance` und andere sind Beispiele für Ressourcen. Eine Ressource gehört zu einem Provider, akzeptiert Argumente, gibt Attribute aus und hat Lebenszyklen. Eine Ressource kann erstellt, abgerufen, aktualisiert und gelöscht werden.

## Ressourcenmodule

Ein Ressourcenmodul ist eine Sammlung zusammenhängender Ressourcen, die gemeinsam eine  Aktion durchführen (z. B. erstellt das [AWS VPC Terraform-Modul](https://github.com/terraform-aws-modules/terraform-aws-vpc/) VPC, Subnetze, NAT-Gateway usw.). Es hängt von der Konfiguration des Providers ab, die darin oder in übergeordneten Strukturen (z. B. im Infrastrukturmodul) definiert werden kann.

## Infrastrukturmodule

Ein Infrastrukturmodul ist eine Sammlung von Ressourcenmodulen, die nicht zwingend logisch miteinander verbunden sein müssen, aber in der aktuellen Situation/im aktuellen Projekt/im aktuellen Setup demselben Zweck dienen. Es definiert die Konfiguration für Provider, die an die nachgelagerten Ressourcenmodule und an Ressourcen weitergegeben wird. Normalerweise ist die Arbeit auf eine Einheit pro logischer Begrenzung beschränkt (z. B. AWS Region, Google Project).

Das Modul [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis/) verwendet beispielsweise Ressourcenmodule wie [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc/) und [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group/), um die für den Betrieb von [Atlantis](https://www.runatlantis.io/) auf [AWS Fargate](https://aws.amazon.com/fargate/) erforderliche Infrastruktur zu verwalten.

Ein weiteres Beispiel ist das [terraform-aws-cloudquery](https://github.com/cloudquery/terraform-aws-cloudquery) Modul, bei dem mehrere Module von [terraform-aws-modules](https://github.com/terraform-aws-modules/) zusammen verwendet werden, um die Infrastruktur zu verwalten und Docker-Ressourcen zu nutzen, um Docker-Images zu erstellen, zu pushen und zu verteilen. Alles in einem Modul.

## Komposition <a href="#komposition" id="komposition"></a>

Eine Komposition ist eine Sammlung von Infrastrukturmodulen, die sich über mehrere logisch getrennte Bereiche erstrecken kann (z. B. AWS-Regionen, mehrere AWS-Konten). Eine Komposition wird verwendet, um die komplette Infrastruktur zu beschreiben, die für das gesamte Unternehmen oder Projekt erforderlich ist.

Eine Komposition besteht aus Infrastrukturmodulen, die aus Ressourcenmodulen bestehen, die einzelne Ressourcen implementieren.

![Einfache Infrastruktur Komposition](.gitbook/assets/composition-1.png)

## Datenquellen

Eine Datenquelle führt einen Lese-Vorgang durch und ist abhängig von der Konfiguration des Providers; sie wird in einem Ressourcenmodul und einem Infrastrukturmodul verwendet.

Die Datenquelle `terraform_remote_state` dient als Bindeglied für übergeordnete Module und Kompositionen.

Die [externe Datenquelle](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data\_source) ermöglicht es einem externen Programm, als Datenquelle zu fungieren und beliebige Daten zur Verwendung in der Terraform-Konfiguration freizugeben. Hier ist ein Beispiel aus dem [terraform-aws-lambda Modul](https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/258e82b50adc451f51544a2b57fd1f6f8f4a61e4/package.tf#L5-L7), bei dem der Dateiname durch den Aufruf eines externen Python-Skripts berechnet wird.

Die [http-Datenquelle](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) führt eine HTTP-GET-Anfrage an die angegebene URL durch und exportiert Informationen über die Antwort, was oft nützlich ist, um Informationen von Endpunkten zu erhalten, für die kein eigener Terraform-Provider existiert.

## Remote-Status

Infrastrukturmodule und Kompositionen sollten ihren [Terraform-Status](https://www.terraform.io/docs/language/state/index.html) an einem entfernten Ort aufbewahren, wo er von anderen kontrolliert (z.B. mittels ACL, Versionierung und Logging) abgerufen werden kann.

## Provider, Provisioner, ...&#x20;

Provider, Provisioner und einige andere Begriffe sind in der offiziellen Dokumentation sehr gut beschrieben und es macht keinen Sinn, sie hier zu wiederholen. Meiner Meinung nach haben sie wenig mit dem Schreiben guter Terraform-Module zu tun.

## Warum so _kompliziert_?

Während einzelne Ressourcen wie Atome in der Infrastruktur sind, sind Ressourcenmodule Moleküle. Ein Modul ist die kleinste versionierte und gemeinsam nutzbare Einheit. Es hat eine genaue Liste von Argumenten und implementiert die grundlegende Logik für eine solche Einheit, um die erforderliche Funktion auszuführen. Beispielsweise erstellt das  [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group) Modul  `aws_security_group` und `aws_security_group_rule` Ressourcen basierend auf der Eingabe. Dieses Ressourcenmodul selbst kann zusammen mit anderen Modulen verwendet werden, um das Infrastrukturmodul zu erstellen.

Der übergreifende Zugriff auf die Daten einzelner Moleküle (Ressourcenmodule und Infrastrukturmodule) erfolgt über die Ausgaben und Datenquellen der Module.

Der Zugriff zwischen Kompositionen erfolgt häufig über Remote state Datenquellen. Für die [gemeinsame Nutzung von Daten zwischen Konfigurationen](https://www.terraform.io/docs/language/state/remote-state-data.html#alternative-ways-to-share-data-between-configurations) gibt es mehrere Möglichkeiten.

Wenn man die oben beschriebenen Konzepte in Pseudo-Beziehungen zueinander setzt, kann das so aussehen:

```
composition-1 {
  infrastructure-module-1 {
    data-source-1 => d1

    resource-module-1 {
      data-source-2 => d2
      resource-1 (d1, d2)
      resource-2 (d2)
    }

    resource-module-2 {
      data-source-3 => d3
      resource-3 (d1, d3)
      resource-4 (d3)
    }
  }

}
```
