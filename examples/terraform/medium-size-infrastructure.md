# Infrastructure de taille moyenne avec Terraform

Source: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform)

Cet exemple contient du code comme exemple de structuration des configurations Terraform pour une infrastructure de taille moyenne qui utilise :

* 2 comptes AWS&#x20;
* 2 environnements séparés (`prod` et `stage` qui ne partagent rien). Chaque environnement réside dans un compte AWS distinct
* Chaque environnement utilise une version différente du module d'infrastructure standard (alb) provenant de [Terraform Registry](https://registry.terraform.io)
* Chaque environnement utilise la même version d'un module interne `modules/network` puisqu'il provient d'un répertoire local.

{% hint style="success" %}
* Parfait pour les projets où l'infrastructure est logiquement séparée (comptes AWS séparés)
* Bon lorsqu'il n'est pas nécessaire de modifier les ressources partagées entre les comptes AWS (un environnement = un compte AWS = un fichier d'état)
* Bon quand il n'y a pas besoin d'orchestration des changements entre les environnements
* Bon lorsque les ressources d'infrastructure sont différentes par environnement à dessein et ne peuvent pas être généralisées (par exemple, certaines ressources sont absentes dans un environnement ou dans certaines régions)
{% endhint %}

{% hint style="warning" %}
Au fur et à mesure que le projet grandit, il sera plus difficile de maintenir ces environnements à jour les uns avec les autres. Il faudrait envisagez d'utiliser des modules d'infrastructure (prêts à l'emploi ou internes) pour les tâches répétables.
{% endhint %}

##
