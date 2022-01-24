# Exemples de structure de code

## Structures de code Terraform

{% hint style="info" %}
Ces exemples montrent un fournisseur AWS, mais la majorité des principes présentés dans les exemples peuvent être appliqués à d'autres fournisseurs de cloud public ainsi qu'à d'autres types de fournisseurs (DNS, DB, Monitoring, etc.)
{% endhint %}

| Type                                                           | Description                                                                                                                                                             | Préparation           |
| -------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------- |
| [petit](terraform/small-size-infrastructure.md)                | Peu de ressources, pas de dépendances externes. Compte AWS unique. Région unique. Environnement unique                                                                  | Oui                   |
| [moyen](terraform/medium-size-infrastructure.md)               | Plusieurs comptes et environnements AWS, modules d'infrastructure prêts à l'emploi utilisant Terraform.                                                                 | Oui                   |
| [grand](terraform/large-size-infrastructure-with-terraform.md) | Plusieurs régions, besoin urgent de réduire le copier-coller, modules d'infrastructure personnalisés, utilisation intensive des compositions. Utilisation de Terraform. | TeC(Travail en Cours) |
| Très grand                                                     | Plusieurs fournisseurs (AWS, GCP, Azure). Déploiements multi-cloud. Utilisation de Terraform.                                                                           | Non                   |

## Structures de code Terragrunt&#x20;

| Type       | Description                                                                                                                                                              | Préparation |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------- |
| moyen      | Plusieurs comptes et environnements AWS, modules d'infrastructure prêts à l'emploi utilisant  Terragrunt.                                                                | No          |
| grand      | Plusieurs régions, besoin urgent de réduire le copier-coller, modules d'infrastructure personnalisés, utilisation intensive des compositions. Utilisation de Terragrunt. | No          |
| très grand | Plusieurs fournisseurs (AWS, GCP, Azure). Déploiements multi-cloud. Utilisation de Terragrunt.                                                                           | Non         |
