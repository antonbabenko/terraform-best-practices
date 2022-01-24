# Structure du code

Les questions liées à la structure du code Terraform sont de loin les plus fréquentes dans la communauté. Tout le monde a également pensé à la meilleure structure de code pour le projet à un moment donné.

## Comment devrais-je structurer mes configurations Terraform?

C'est l'une des questions pour lesquelles de nombreuses solutions existent, mais il est très difficile de donner des conseils universels, alors commençons par comprendre à quoi nous avons affaire.

* Quelle est la complexité de votre projet?
  * Nombre de ressources associées
  * Nombre de fournisseurs Terraform (voir la remarque ci-dessous sur les "fournisseurs logiques")
* À quelle fréquence votre infrastructure change-t-elle ?
  * À partir d'une fois par mois/semaine/jour
  * À  continuellement (à chaque fois qu'il y a un nouveau commit)
* Quelles sont les initiateurs de changement de code? Laissez-vous le serveur CI mettre à jour le référentiel lorsqu'un nouvel artefact est créé ?
  * Seuls les développeurs peuvent pousser vers le référentiel d'infrastructure?
  * Tout le monde peut proposer un changement à n'importe quoi en ouvrant un PR (y compris les tâches automatisées exécutées sur le serveur CI)
* Quelle plate-forme de déploiement ou service de déploiement utilisez-vous ?
  * AWS CodeDeploy, Kubernetes ou OpenShift nécessitent une approche légèrement différente
* Comment les environnements sont-ils regroupés ?
  * Par environnement, région, projet

{% hint style="info" %}
Les fournisseurs logiques fonctionnent entièrement dans la logique de Terraform et très souvent n'interagissent avec aucun autre service, nous pouvons donc considérer leur complexité comme O(1). Les fournisseurs logiques les plus courants incluent [random](https://registry.terraform.io/providers/hashicorp/random/latest/docs), [local](https://registry.terraform.io/providers/hashicorp/local/latest/docs), [terraform](https://www.terraform.io/docs/providers/terraform/index.html), [null](https://registry.terraform.io/providers/hashicorp/null/latest/docs), [time](https://registry.terraform.io/providers/hashicorp/time/latest).
{% endhint %}

## Initiation à la structuration des configurations Terraform

Mettre tout le code dans main.tf est une bonne idée lorsque vous débutez ou que vous écrivez un exemple de code. Dans tous les autres cas, il sera préférable d'avoir plusieurs fichiers répartis logiquement comme ceci :

* `main.tf` - appelle les modules, les variables locals et les sources de données pour créer toutes les ressources
* `variables.tf` - contient les variables qui seront utilisées dans `main.tf`
* `outputs.tf` - contient les sorties des ressources créées dans `main.tf`
* `versions.tf` - contient les exigences de version pour Terraform et les fournisseurs

`terraform.tfvars` ne doit être utilisé nulle part sauf [composition](key-concepts.md#composition).

## Comment structurer les configurations  Terraform?

{% hint style="info" %}
Veuillez vous assurer que vous comprenez les concepts clés - [resource module](key-concepts.md#resource-module), [infrastructure module](key-concepts.md#infrastructure-module), et [composition](key-concepts.md#composition), tels qu'ils sont utilisés dans les exemples suivants.
{% endhint %}

### Recommandations courantes pour structurer le code

* Il est plus facile et plus rapide de travailler avec un plus petit nombre de ressources
  * `terraform plan` et`terraform apply` effectuent tous deux des appels d'API cloud pour vérifier l'état des ressources
  * Si vous avez toute votre infrastructure dans une seule composition, cela peut prendre un certain temps
* Le surface d'exposition est plus petit avec moins de ressources
  * Isoler les ressources non liées les unes des autres en les plaçant dans des compositions séparées réduit le risque en cas de problème
* Démarrez votre projet en utilisant l'état distant car :
  * Votre ordinateur portable n'est pas une source fiable pour votre infrastructure
  * Gérer un fichier `tfstate` file dans un git est cauchemar
  * Plus tard, lorsque les couches d'infrastructure commenceront à se développer dans plusieurs directions (nombre de dépendances ou de ressources), il sera plus facile de garder les choses sous contrôle
* Adoptez une structure et une convention de [dénomination ](naming.md)cohérentes :
  * Comme tout code procédural, le code Terraform doit être écrit pour permettre d'abord aux gens de le lire. Sa cohérence aidera lorsque des changements se produiront dans une période de six mois
  * Il est possible de déplacer des ressources dans le fichier d'état Terraform, mais cela peut être plus difficile à faire si vous avez une structure et un nom incohérents
* Gardez les modules de ressources aussi clairs que possible
* Ne codez pas en dur les valeurs qui peuvent être transmises en tant que variables ou découvertes à l'aide de sources de données
* Utilisez les sources de données et `terraform_remote_state` spécifiquement comme colle (liaison) entre les modules d'infrastructure au sein de la composition.

Dans ce livre, des exemples de projets sont regroupés par complexité - des petites aux très grandes infrastructures. Cette séparation n'est pas stricte, vérifiez donc également les autres structures.

### Orchestration des modules d'infrastructure et compositions

Avoir une petite infrastructure signifie qu'il y a un petit nombre de dépendances et peu de ressources. Au fur et à mesure que le projet se développe, la nécessité d'enchaîner l'exécution des configurations Terraform, de connecter différents modules d'infrastructure et de transmettre des valeurs au sein d'une composition devient évidente.

On dénombre au moins 5 groupes distincts de solutions d'orchestration utilisées par les développeurs :

1. Terraform uniquement. Très simple, les développeurs ne doivent connaître que Terraform pour faire le travail.
2. Terragrunt. Un pur outil d'orchestration qui peut être utilisé pour orchestrer l'ensemble de l'infrastructure ainsi que pour gérer les dépendances. Terragrunt fonctionne nativement avec des modules d'infrastructure et des compositions, ce qui réduit la duplication de code.
3. Scripts maison (personnel). Ils sont souvent utilisés comme point de départ vers l'orchestration et avant de découvrir Terragrunt.
4. Ansible ou les outils d'automatisation généraux similaires. Généralement utilisé lorsque Terraform est adopté après Ansible, ou lorsque l'UI Ansible est activement utilisée.
5. [Crossplane](https://crossplane.io) et autres solutions inspirées de Kubernetes. Parfois, il est logique d'utiliser l'écosystème Kubernetes et d'employer une fonction de boucle de réconciliation pour atteindre l'état souhaité de vos configurations Terraform. Voir la vidéo [Crossplane vs Terraform](https://www.youtube.com/watch?v=ELhVbSdcqSY) pour plus d'information.

Avec cela en tête, ce livre passe en revue les deux premières structures de projet ci-dessus, [Terraform](examples/terraform/) uniquement ou [Terragrunt](examples/terragrunt.md).

Voir des exemples de structure de code pour [Terraform](examples/terraform/) et [Terragrunt](examples/terragrunt.md) dans le prochain chapitre.
