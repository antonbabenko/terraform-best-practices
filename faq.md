---
description: FTP (Frequent Terraform Problems)
---

# FAQ

## Quels sont les outils que je devrais connaître et envisager d'utiliser?

* [**Terragrunt**](https://terragrunt.gruntwork.io) - Outil d'orchestration
* [**tflint**](https://github.com/terraform-linters/tflint) - Code linter
* [**tfenv**](https://github.com/tfutils/tfenv) - Gestionnaire de versions
* [**Atlantis**](https://www.runatlantis.io) - Automation des demandes d'extraction (Pull Request)
* [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) - Collection de git hooks pour Terraform à utiliser avec [pre-commit framework](https://pre-commit.com)
* [**Infracost**](https://www.infracost.io/) - Estimation des coûts du cloud pour Terraform dans les demandes de pull. Fonctionne aussi avec Terragrunt, Atlantis et pre-commit-terraform

## Quelles sont les solutions à l'enfer des dépendances avec les modules ?

Les versions des modules de ressources et d'infrastructure doivent être spécifiées. Les fournisseurs doivent être configurés en dehors des modules, mais uniquement en composition. La version des fournisseurs et de Terraform peut également être verrouillée.

Il n'y a pas d'outil maître de gestion des dépendances, mais il existe quelques astuces pour rendre l'enfer des dépendances moins problématique. Par exemple, [Dependabot](https://dependabot.com) peut être utilisé pour automatiser les mises à jour des dépendances. Dependabot crée des demandes d'extraction pour garder vos dépendances sécurisées et à jour. Dependabot prend en charge les configurations Terraform.
