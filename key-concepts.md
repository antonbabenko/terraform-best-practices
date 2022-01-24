# Concepts clés

La documentation officielle de Terraform décrit [tous les aspects de la configuration en détail](https://www.terraform.io/docs/configuration/index.html). Il faudrait la lire attentivement pour comprendre le reste de cette section&#x20;

Cette section décrit les concepts clés qui seront utilisés dans le livre.

## Ressource

Une ressource est un objet comme`aws_vpc`, `aws_db_instance`, etc. Une ressource appartient à un fournisseur, accepte des arguments, génère des attributs et possède des cycles de vie. Une ressource peut être créée, récupérée, mise à jour et supprimée.

## Module de ressources

Un module de ressources est un ensemble de ressources connectées qui exécutent mutuellement l'action commune (par exemple, le module AWS VPC Terraform crée un VPC, des sous-réseaux, une passerelle NAT, etc.). Il dépend de la configuration du fournisseur, qui peut être définie dans celui-ci, ou dans des structures de niveau supérieur (par exemple, dans le module d'infrastructure).

## Module d'infrastructure&#x20;

Un module d'infrastructure est un ensemble de modules de ressources, qui peuvent logiquement ne pas être connectés, mais dans la situation/projet/configuration actuels, ils ont le même objectif. Il définit la configuration des fournisseurs, qui est transmise aux modules de ressources en aval et aux ressources. Il est normalement limité au travail dans une entité par un séparateur logique (par exemple, AWS Region, Google Project).

Par exemple, le module [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis/) utilise des modules de ressources comme [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc/) et [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group/) pour gérer l'infrastructure requise afin d'opérationneliser [Atlantis](https://www.runatlantis.io) sur [AWS Fargate](https://aws.amazon.com/fargate/).

Un autre exemple est le module  [terraform-aws-cloudquery](https://github.com/cloudquery/terraform-aws-cloudquery) qui emploie plusieurs modules de [terraform-aws-modules](https://github.com/terraform-aws-modules/) ensemble afin de gérer l'infrastructure et utilisent les ressources Docker pour créer, pousser et déployer des images Docker. Tout en un ensemble.&#x20;

## Composition

La composition est une collection de modules d'infrastructure, qui peuvent s'étendre sur plusieurs zones logiquement séparées (par exemple, des régions AWS, plusieurs comptes AWS). La composition est utilisée pour décrire l'infrastructure complète requise pour l'ensemble de l'organisation ou du projet.

Une composition est constituée de modules d'infrastructure, qui comprennent des modules de ressources implémentant des ressources individuelles.

![Simple infrastructure composition](.gitbook/assets/composition-1.png)

## Source de données

La source de données effectue une opération en lecture seule et dépend de la configuration du fournisseur. Elle est utilisée dans un module de ressources et un module d'infrastructure.

La source de données `terraform_remote_state`agit comme une colle (lien) pour les modules et les compositions de niveau supérieur.

La source de données [externe ](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data\_source)permet à un programme externe d'agir en tant que source de données, exposant des données arbitraires à utiliser ailleurs dans la configuration Terraform. En voici un exemple à partir du module [terraform-aws-lambda](https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/258e82b50adc451f51544a2b57fd1f6f8f4a61e4/package.tf#L5-L7) où le nom de fichier est obtenu en appelant un script Python externe.

&#x20;La source de données [http ](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http)envoie une requête HTTP GET à l'URL donnée et exporte des informations liées à la réponse. Ces dernières sont  souvent utiles pour obtenir des informations à partir de points de terminaison où un fournisseur Terraform natif n'existe pas.

## État distant

Les modules et les compositions d'infrastructure doivent conserver leur [état Terraform](https://www.terraform.io/docs/language/state/index.html) dans un emplacement distant où il peut être récupéré par d'autres de manière contrôlable (par exemple, l'accès spécifique à l'ACL, la gestion des versions, la journalisation).

## Fournisseur, commission etc

Les fournisseurs, les commission (provisioner) et quelques autres termes sont très bien décrits dans la documentation officielle et il est inutile de le répéter ici. À mon avis, ils ont peu à voir avec l'écriture de bons modules Terraform.

## _Pourquoi est ce si difficile_?

Alors que les ressources individuelles sont comme des atomes dans l'infrastructure, les modules de ressources sont des molécules. Un module est la plus petite unité versionnable et partageable. Il a une liste exacte d'arguments, implémente une logique de base pour qu'une telle unité remplisse la fonction requise. Par exemple, le module [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group) crée des ressources `aws_security_group` et`aws_security_group_rule` en fonction de l'entrée. Ce module de ressources en lui-même peut être utilisé avec d'autres modules pour créer le module d'infrastructure.

L'accès aux données à travers les molécules (modules de ressources et modules d'infrastructure) est effectué à l'aide des sorties et des sources de données des modules.

L'accès entre les compositions est souvent effectué à l'aide de sources de données à distance. Il existe [plusieurs façons de partager des données entre les configurations](https://www.terraform.io/docs/language/state/remote-state-data.html#alternative-ways-to-share-data-between-configurations).

&#x20;Lorsque vous mettez les concepts décrits ci-dessus dans des pseudo-relations, cela peut ressembler à ceci :

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
