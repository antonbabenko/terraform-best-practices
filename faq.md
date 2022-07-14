---
description: FTP (Frequent Terraform Problems)
---

# FAQ

## Quali sono gli strumenti che dovrei conoscere e considerare l'utilizzo?

* [**Terragrunt**](https://terragrunt.gruntwork.io/) - strumento di orchestrazione
* [**tflint**](https://github.com/terraform-linters/tflint) - Code linter
* [**tfenv**](https://github.com/tfutils/tfenv) - Version manager
* [**Atlantis**](https://www.runatlantis.io/) - Automatizzazione delle pull request&#x20;
* [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) - Collezione di git hooks per Terraform da usare con [pre-commit framework](https://pre-commit.com/)

## Hai avuto la possibilità di rispondere alla domanda fatta precedentemente?

Si, dopo alcuni mesi abbiamo trovato la risposta. Purtroppo, Mike è in ferie al momento, quindi  non sono in grado di darti una risposta.&#x20;

## Quali sono le soluzioni al [dependency hell](https://en.wikipedia.org/wiki/Dependency\_hell) con i moduli?

Le versioni delle risorse e dei moduli infrastruttura dovrebbero essere specificati. I providers dovrebbero essere configurati fuori dai moduli, ma solo in composizione. È possibile fare il lock sulle versioni dei providers.

Non c'è una dipendenza master per il tool di management, ma ci sono alcuni suggerimenti per rendere il dependency hell meno problematico. Per esempio, [Dependabot](https://dependabot.com/) può essere usato per automatizzare gli aggiornamenti delle dipendenze. Dependabot crea delle pull requests per mantenere le dipendenze sicure e aggiornate. Dependabot supporta le configurazioni Terraform.
