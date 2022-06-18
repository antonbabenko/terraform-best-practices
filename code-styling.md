# Code-Styling

{% hint style="info" %}
* Beispiele und Terraform-Module sollten eine Dokumentation enthalten, in der die Funktionen und deren Verwendung erklärt werden.
* Alle Links in README.md-Dateien sollten absolut sein, damit die Terraform Registry Website sie korrekt anzeigt.
* Die Dokumentation kann mit [mermaid](https://github.com/mermaid-js/mermaid) erstellte Diagramme und mit [cloudcraft.co](https://cloudcraft.co/) erstellte Blueprints enthalten.
* Verwenden Sie [Terraform Pre-Commit Hooks](https://github.com/antonbabenko/pre-commit-terraform), um sicherzustellen, dass der Code gültig, richtig formatiert und automatisch dokumentiert ist, bevor er nach Git gepusht und von Menschen überprüft wird.
{% endhint %}

## Dokumentation

### Automatisch erstellte Dokumentation

[pre-commit](https://pre-commit.com/) ist ein Framework für die Verwaltung und Pflege von Pre-Commit-Hooks für mehrere Programmiersprachen. Es ist in Python geschrieben und ist ein leistungsfähiges Werkzeug, um auf dem Rechner eines Entwicklers automatisch etwas zu tun, bevor der Code in ein Git-Repository übertragen wird. Normalerweise wird es verwendet, um Linter auszuführen und Code zu formatieren (siehe [unterstützte Hooks](https://pre-commit.com/hooks.html)).

Mit Terraform-Konfigurationen kann `pre-commit` verwendet werden, um Code zu formatieren und zu validieren, sowie um die Dokumentation zu aktualisieren.

Schauen Sie sich das [pre-commit-terraform Repository](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md) an, um sich damit vertraut zu machen, sowie bestehende Repositories (z.B. [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc)), in denen dies bereits verwendet wird.

### terraform-docs

[terraform-docs](https://github.com/segmentio/terraform-docs) ist ein Werkzeug, das die Dokumentation von Terraform-Modulen in verschiedenen Ausgabeformaten erzeugt. Sie können es manuell ausführen (ohne pre-commit hooks), oder [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform) verwenden, um die Dokumentation automatisch zu aktualisieren.

@todo: Document module versions, release, GH actions

## Ressourcen

1. [pre-commit framework homepage](https://pre-commit.com/)
2. [Collection of git hooks for Terraform to be used with pre-commit framework](https://github.com/antonbabenko/pre-commit-terraform)
3. Blog post von [Dean Wilson](https://github.com/deanwilson): [pre-commit hooks and terraform - a safety net for your repositories](https://www.unixdaemon.net/tools/terraform-precommit-hooks/)
