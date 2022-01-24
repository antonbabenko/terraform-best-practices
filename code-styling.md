# Style de code

{% hint style="info" %}
* Les exemples et les modules Terraform doivent contenir une documentation expliquant les fonctionnalités et comment les utiliser.
* Tous les liens dans les fichiers README.md doivent être absolus pour que le site Web Terraform Registry les affiche correctement.
* La documentation peut inclure des diagrammes créés avec [mermaid](https://github.com/mermaid-js/mermaid) et des plans créés avec [cloudcraft.co](https://cloudcraft.co).
* Utilisez [Terraform pre-commit hooks](https://github.com/antonbabenko/pre-commit-terraform) pour vous assurer que le code est valide, correctement formaté et automatiquement documenté avant qu'il ne soit transmis à git et examiné par des humains
{% endhint %}

## Documentation

### Documentation génèrée automatiquement

[pre-commit](https://pre-commit.com) est un cadre de gestion et de maintenance des hooks de pré-commit multilingues. Écrit en Python, il est un outil puissant pour faire quelque chose automatiquement sur la machine d'un développeur avant que le code ne soit validé dans un référentiel git. Normalement, il est utilisé pour exécuter des linters et formater du code (voir [supported hooks](https://pre-commit.com/hooks.html)).

Avec les configurations Terraform `pre-commit` peut être utilisé pour formater et valider le code, ainsi que pour mettre à jour la documentation.

Vérifiez le [pre-commit-terraform repository](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md) pour vous familiariser avec lui, et les référentiels existants (par exemple, [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc)) où cela est déjà utilisé.

### terraform-docs

[terraform-docs](https://github.com/segmentio/terraform-docs) est un outil qui génère la documentation des modules Terraform dans différents formats de sortie. Vous pouvez l'exécuter manuellement (sans crochets de pré-commit), ou utiliser [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform) pour obtenir la documentation mise à jour automatiquement.

@ToDo: Document module versions, release, GH actions

## Resources

1. [pre-commit framework homepage](https://pre-commit.com)
2. [Collection of git hooks for Terraform to be used with pre-commit framework](https://github.com/antonbabenko/pre-commit-terraform)
3. Blog posté par [Dean Wilson](https://github.com/deanwilson): [pre-commit hooks and terraform - a safety net for your repositories](https://www.unixdaemon.net/tools/terraform-precommit-hooks/)
