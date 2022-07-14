# Stili di codice

{% hint style="info" %}
* Esempi di moduli Terraform dovrebbero contenere la documentazione che spiega le features e come usarle.
* Tutti i links nel README.md dovrebbero essere con path assoluti per fare in modo che il sito web Terraform Registry li mostri correttamente.&#x20;
* La documentation può includere diagrammi  creati con [mermaid](https://github.com/mermaid-js/mermaid) e blueprints creati con [cloudcraft.co](https://cloudcraft.co).
* Usa i [Terraform pre-commit hooks](https://github.com/antonbabenko/pre-commit-terraform) per essere sicuri che il codice è valido, correttamente formattato e automaticamente documentation prima che venga pushato in git e controllato da altri sviluppatori.
{% endhint %}

## Documentazione

### Generare automaticamente la documentazione

[pre-commit](https://pre-commit.com/) è un framework per amministrare e mantenere hooks per linguaggi multipli. È scritto in Python ed è un tool potente per fare qualcosa automaticamente sulla macchina dello sviluppatore prima che il codice venga committato sul repository git. Normalmente, è usato per far girare linters e formattare il codice (vedi [supported hooks](https://pre-commit.com/hooks.html)).

Con le configurazioni Terraform `pre-commit` può essere usato per formattare e validare il codice, come per aggiornare la documentatione.

Dai un'occhiato al  [repository](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md) [pre-commit-terraform ](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md) per prendere confidenza e anche ai  repositories (eg, [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc)) dov'è già usato.

### terraform-docs

[terraform-docs](https://github.com/segmentio/terraform-docs) è un tool che genera la documentaione dei moduli Terraform in vari formati di output.  Puoi farlo girare manualmente (senza pre-commit hooks), oppure usare [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform) per fare in modo che la documentazione si aggiorni automaticamente.

@todo: Document module versions, release, GH actions

## Risorse

1. [pre-commit framework homepage](https://pre-commit.com/)
2. [Collection of git hooks for Terraform to be used with pre-commit framework](https://github.com/antonbabenko/pre-commit-terraform)
3. Blog post by [Dean Wilson](https://github.com/deanwilson): [pre-commit hooks and terraform - a safety net for your repositories](https://www.unixdaemon.net/tools/terraform-precommit-hooks/)
