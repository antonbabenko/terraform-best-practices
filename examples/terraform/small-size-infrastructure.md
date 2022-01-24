# Infrastructure de petite taille avec Terraform

Source: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

Cet exemple contient du code comme exemple de structuration des configurations Terraform pour une infrastructure de petite taille, où aucune dépendance externe n'est utilisée.

{% hint style="success" %}
* Parfait pour commencer et refactoriser au fur et à mesure
* Parfait pour les petits modules de ressources
* Bon pour les petits modules d'infrastructure linéaires (par exemple, [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis))
* Bon pour un petit nombre de ressources (moins de 20-30)
{% endhint %}

{% hint style="warning" %}
Un fichier d'état unique pour toutes les ressources peut ralentir le processus de travail avec Terraform si le nombre de ressources augmente (envisagez d'utiliser un argument -target pour limiter le nombre de ressources)
{% endhint %}
