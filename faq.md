---
description: FTP (Frequent Terraform Problems) - Häufige Probleme mit Terraform
---

# FAQ - Häufig gestellte Fragen

## Welche Werkzeuge sollte ich kennen und nutzen?

* [**Terragrunt**](https://terragrunt.gruntwork.io/) - Orchestrierungswerkzeug
* [**tflint**](https://github.com/terraform-linters/tflint) - Code linter
* [**tfenv**](https://github.com/tfutils/tfenv) - Terraform Versionsverwaltung
* [**Atlantis**](https://www.runatlantis.io/) - Pull Request Automatisierung
* [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) - Sammlung von Git-Hooks für Terraform, die mit dem [Pre-Commit-Framework](https://pre-commit.com/) verwendet werden können
* [**Infracost**](https://www.infracost.io) - Cloud-Kostenschätzungen für Terraform in Pull Requests. Funktioniert auch mit Terragrunt, Atlantis und pre-commit-terraform.

## Hatten Sie schon Gelegenheit, die vorherige Frage zu beantworten?

Ja, nach ein paar Monaten haben wir endlich die Antwort gefunden. Leider ist Mike zur Zeit im Urlaub, so dass wir die Antwort leider nicht geben können.

## Was sind Lösungen für die [dependency hell](https://en.wikipedia.org/wiki/Dependency\_hell) bei Modulen?

Die Versionen der Ressourcen- und Infrastrukturmodule sollten angegeben werden. Provider sollten außerhalb von Modulen konfiguriert werden, aber nur in der Komposition. Die Versionen von Providern und Terraform können auch fixiert werden.

Es gibt kein Master-Tool für die Verwaltung von Abhängigkeiten, aber es gibt einige Tipps, um die Abhängigkeitshölle weniger problematisch zu machen. Zum Beispiel kann [Dependabot](https://docs.github.com/en/code-security/dependabot) verwendet werden, um die Aktualisierung von Abhängigkeiten zu automatisieren. Dependabot erstellt Pull Requests, um Ihre Abhängigkeiten sicher und aktuell zu halten. Dependabot unterstützt Terraform-Konfigurationen.
