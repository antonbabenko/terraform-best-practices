# Beispiele für Code-Strukturen

## Terraform-Code Strukturen

{% hint style="info" %}
Diese Beispiele zeigen den AWS-Anbieter, aber die meisten der in den Beispielen gezeigten Prinzipien können auch auf andere öffentliche Cloud-Anbieter und andere Arten von Anbietern (DNS, Datenbanken, Monitoring usw.) angewendet werden.
{% endhint %}

| Typ                                                           | Beschreibung                                                                                                                                                                      | Einsatzbereitschaft |
| ------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------- |
| [klein](terraform/small-size-infrastructure.md)               | Wenige Ressourcen, keine externen Abhängigkeiten. Ein AWS-Konto. Eine Region. Eine Umgebung.                                                                                      | Ja                  |
| [mittel](terraform/medium-size-infrastructure.md)             | Mehrere AWS-Konten und Umgebungen, handelsübliche Infrastrukturmodule mit Terraform.                                                                                              | Ja                  |
| [groß](terraform/large-size-infrastructure-with-terraform.md) | Viele AWS-Konten, viele Regionen. Dringender Bedarf, Copy-Paste zu reduzieren, benutzerdefinierte Infrastrukturmodule, starke Nutzung von Compositions. Verwendung von Terraform. | In Arbeit           |
| sehr groß                                                     | Mehrere Anbieter (AWS, GCP, Azure). Multi-Cloud-Einsatz. Verwendung von Terraform.                                                                                                | Nein                |

## Terragrunt-Code Strukturen

| Typ       | Beschreibung                                                                                                                                                                                                                                                                                                                                   | Einsatzbereitschaft |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------- |
| mittel    | Mehrere AWS-Konten und Umgebungen, handelsübliche Infrastrukturmodule, Kompositionsmuster mit Terragrunt.                                                                                                                                                                                                                                      | Nein                |
| groß      | <p>Many AWS accounts, many regions, urgent need to reduce copy-paste, custom infrastructure modules, heavy usage of compositions. Using Terragrunt.<br>Viele AWS-Konten, viele Regionen. Dringender Bedarf, Copy-Paste zu reduzieren, benutzerdefinierte Infrastrukturmodule, starke Nutzung von Kompositionen. Verwendung von Terragrunt.</p> | Nein                |
| sehr groß | Mehrere Anbieter (AWS, GCP, Azure). Multi-Cloud-Einsätze. Verwendung von Terragrunt.                                                                                                                                                                                                                                                           | Nein                |
