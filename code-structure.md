# Aufbau des Codes

Fragen, die sich auf die Terraform-Code-Struktur beziehen, sind mit Abstand die häufigsten in der Community. Jeder hat sich irgendwann einmal Gedanken über die beste Codestruktur für das Projekt gemacht.

## Wie sollte ich meine Terraform-Konfigurationen strukturieren?

Dies ist eine der Fragen, für die es viele Lösungen gibt, und es ist sehr schwer, allgemeingültige Ratschläge zu erteilen, also sollten wir zunächst einmal verstehen, womit wir es zu tun haben.

* Wie komplex ist Ihr Projekt?
  * Anzahl der zugehörigen Ressourcen
  * Anzahl der Terraform-Provider (siehe Hinweis unten über "logische Provider")
* Wie oft ändert sich Ihre Infrastruktur?
  * **Von** einmal pro Monat/Woche/Tag
  * **Bis** kontinuierlich (jedes Mal, wenn es einen neuen Commit gibt)
* Initiatoren von Codeänderungen? Lassen Sie den CI-Server das Repository aktualisieren, wenn ein neues Artefakt erstellt wird?
  * Nur Entwickler können Änderungen am Infrastruktur-Repository vornehmen.
  * Jeder kann eine Änderung vorschlagen, indem er einen PR öffnet (einschließlich automatisierter Aufgaben, die auf dem CI-Server laufen)
* Welche Einsatzplattform oder welchen Einsatzdienst verwenden Sie?
  * AWS CodeDeploy, Kubernetes oder OpenShift erfordern einen etwas anderen Ansatz
* Wie sind die Umgebungen gruppiert?
  * Nach Umgebung, Region, Projekt

{% hint style="info" %}
Logische Provider arbeiten vollständig innerhalb der Terraform-Logik und interagieren sehr oft nicht mit anderen Diensten, so dass wir ihre Komplexität als O(1) betrachten können. Zu den häufigsten logischen Providern gehören [random](https://registry.terraform.io/providers/hashicorp/random/latest/docs), [local](https://registry.terraform.io/providers/hashicorp/local/latest/docs), [terraform](https://www.terraform.io/docs/providers/terraform/index.html), [null](https://registry.terraform.io/providers/hashicorp/null/latest/docs) und [time](https://registry.terraform.io/providers/hashicorp/time/latest).
{% endhint %}

## Erste Schritte bei der Strukturierung von Terraform-Konfigurationen

Es ist eine gute Idee, den gesamten Code in die Datei `main.tf` zu packen, wenn Sie gerade erst anfangen oder einen Beispielcode schreiben. In allen anderen Fällen ist es besser, mehrere Dateien zu haben, die logisch aufgeteilt sind, wie hier:

* `main.tf` - ruft Module, lokale Variablen und Datenquellen auf, um alle Ressourcen zu erstellen
* `variables.tf` - enthält die Deklarationen der in `main.tf` verwendeten Variablen
* `outputs.tf` - enthält die Ausgaben der in `main.tf` erstellten Ressourcen
* `versions.tf` - enthält die Versionsanforderungen für Terraform und Provider

`terraform.tfvars` sollte nur in der [Komposition](key-concepts.md#komposition) verwendet werden.

## Wie sollte man über die Struktur von Terraform-Konfigurationen nachdenken?

{% hint style="info" %}
Vergewissern Sie sich, dass Sie die grundlegenden Konzepte - [Ressourcenmodul](key-concepts.md#ressourcenmodule), [Infrastrukturmodul](key-concepts.md#infrastrukturmodule) und [Komposition](key-concepts.md#komposition) - verstehen, da sie in den folgenden Beispielen verwendet werden.
{% endhint %}

### Allgemeine Empfehlungen für die Strukturierung von Code

* Es ist einfacher und schneller, mit einer kleineren Anzahl von Ressourcen zu arbeiten
  * `terraform plan` und `terraform apply` machen beide Cloud-API-Aufrufe, um den Status der Ressourcen zu überprüfen
  * Wenn Sie Ihre gesamte Infrastruktur in einer einzigen Komposition haben, kann dies einige Zeit dauern
* Der Blast-Radius ("Explosionsradius") ist kleiner mit weniger Ressourcen
  * Die Isolierung nicht zusammenhängender Ressourcen voneinander, indem sie in getrennten Kompositionen untergebracht werden, verringert das Risiko, wenn etwas schief geht.
* Beginnen Sie Ihr Projekt mit einem Remote-Status, denn:
  * Ihr Laptop ist kein Ort für Ihre Infrastruktur als "Quelle der Wahrheit"
  * Die Verwaltung einer `tfstate`-Datei in Git ist ein Alptraum
  * Später, wenn die Infrastrukturebenen in verschiedene Richtungen wachsen (Anzahl der Abhängigkeiten oder Ressourcen), wird es einfacher sein, die Dinge unter Kontrolle zu halten
* Achten Sie auf eine einheitliche Struktur und [Namenskonvention](naming.md):
  * Wie prozeduraler Code sollte auch Terraform-Code so geschrieben werden, dass ihn Entwickler gut lesen können; Konsistenz ist hilfreich, wenn sechs Monaten später Änderungen vorgenommen werden müssen
  * Es ist möglich, Ressourcen innerhalb der Terraform-Statusdatei zu verschieben, aber es kann schwieriger sein, wenn Sie eine inkonsistente Struktur und Namenskonvention haben
* Halten Sie die Ressourcenmodule so einfach wie möglich
* Geben Sie keine Werte fest ein, die als Variablen übergeben oder über Datenquellen ermittelt werden können
* Verwenden Sie Datenquellen und `terraform_remote_state` speziell als Verbindung zwischen Infrastrukturmodulen innerhalb der Komposition

In diesem Buch sind die Beispielprojekte nach _Komplexität_ gruppiert - von kleinen bis zu sehr großen Infrastrukturen. Diese Trennung ist nicht strikt, probieren Sie daher auch Strukturen.

### Orchestrierung von Infrastrukturmodulen und Kompositionen

Eine kleine Infrastruktur bedeutet, dass es nur eine geringe Anzahl von Abhängigkeiten und wenige Ressourcen gibt. Wenn das Projekt wächst, wird die Notwendigkeit deutlich, die Ausführung von Terraform-Konfigurationen zu verketten, verschiedene Infrastrukturmodule zu verbinden und Werte innerhalb einer Komposition zu übergeben.

Es gibt mindestens 5 verschiedene Gruppen von Orchestrierungslösungen, die Entwickler verwenden:

1. Nur Terraform. Sehr einfach, Entwickler müssen nur Terraform kennen, um die Arbeit zu erledigen.
2. Terragrunt. Ein reines Orchestrierungstool, mit dem die gesamte Infrastruktur orchestriert und Abhängigkeiten gehandhabt werden können. Terragrunt arbeitet nativ mit Infrastrukturmodulen und Kompositionen und reduziert so die Duplizierung von Code.
3. Interne Skripte. Dies geschieht oft als Ausgangspunkt für die Orchestrierung und bevor Terragrunt entdeckt wird.
4. Ansible oder ein ähnliches Allzweck-Automatisierungswerkzeug. Wird normalerweise verwendet, wenn Terraform nach Ansible eingeführt wird oder wenn die Ansible UI aktiv genutzt wird.
5. [Crossplane](https://crossplane.io/) und andere Kubernetes-inspirierte Lösungen. Manchmal ist es sinnvoll, das Kubernetes-Ökosystem zu nutzen und eine Reconciliation-Schleife einzusetzen, um den gewünschten Zustand Ihrer Terraform-Konfigurationen zu erreichen. Sehen Sie sich das Video [Crossplane vs. Terraform](https://www.youtube.com/watch?v=ELhVbSdcqSY) für weitere Informationen an.

Vor diesem Hintergrund werden in diesem Buch die ersten beiden dieser Projektstrukturen, Terraform only und Terragrunt, vorgestellt.

Beispiele für Codestrukturen für [Terraform](examples/terraform/) oder [Terragrunt](examples/terragrunt.md) finden Sie im nächsten Kapitel.
