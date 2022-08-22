---
description: >-
  Ce document a pour but de décrire systématiquement les bonnes pratiques dans
  l’utilisation de Terraform et de fournir des recommandations par rapport aux
  problèmatiques fréquemment rencontrées.
---

# Bienvenue

[Terraform](https://www.terraform.io), un projet relativement nouveau (comme la plus part des outils Devops actuellement), a été lancé en 2014.

Terraform est un outil puissant (si ce n'est le plus puissant actuellement disponible) et le plus utilisé pour le gestion de l'infrastructure comme code. Il permet aux developpeurs de créer plusieurs codes dont le support et l'intégration seront faciles

Certaines informations décrit dans ce livre pourraient ne pas ressembler aux bonnes pratiques. J'en suis conscient, et pour aider les lecteurs à séparer ce qui établit comme bonnes pratiques et ce que je considère être d'autres méthodes équivalentes, j'utiliserai par moment des indications pour fournir un certain contexte et des icônes pour spécifier le niveau de maturité de chaque sous-section reliée aux bonnes pratiques

Ce livre a été commencé dans une ville de Madrid ensoleillée en 2018 et est disponible gratuitement ici [https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com)

Quelques années plus tard il a été mis à jour grâce à plusieurs récentes bonnes pratiques disponibles avec Terraform 1.0. Éventuellement ce livre devrait contenir la plupart des bonnes pratiques et recommandations indiscutables pour les utilisateurs de Terraform.

## Translations

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/e1Mp2scOX6OnQbifCen3/" %}
[English](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/e1Mp2scOX6OnQbifCen3/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/" %}
[Español (Spanish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/" %}
[Bahasa Indonesia (Indonesian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/PKopCWJZbhpQ9FT0W8tL/" %}
[Deutsch (German)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/PKopCWJZbhpQ9FT0W8tL/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/4bq6CyY8vYiEHkjN63rT/" %}
[עברית (Hebrew)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/4bq6CyY8vYiEHkjN63rT/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/8VlMHbHDbW6qRWdgN5oU/" %}
[Italiano (Italian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/8VlMHbHDbW6qRWdgN5oU/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/" %}
[Português (Brazilian Portuguese)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/" %}
[Polski (Polish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/" %}
[Українська (Ukrainian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/)
{% endcontent-ref %}

Contactez-moi si vous voulez aider à traduire ce livre dans d'autres langues.

## Contributions

Je souhaite toujours obtenir des commentaires et mettre à jour ce livre au fur et à mesure que la communauté mûrit et que de nouvelles idées sont mises en œuvre et vérifiées au fil du temps. Si vous êtes intéressé par certains sujets, veuillez ouvrir un problème ou en indiquer un que vous souhaitez être traiter plus en détail. Si vous sentez que vous avez du contenu et que vous souhaitez y contribuer, rédigez un brouillon et soumettez un pull request (ne vous souciez pas d'écrire un bon texte à ce stade !)

## Authors

Ce livre est maintenu par Anton Babenko avec l'aide de différents contributeurs et traducteurs. Nicanor Foping l'a traduit en français.

## Sponsors

| [![](.gitbook/assets/cluster-dev-logo-site.png)](https://cluster.dev) | [Cluster.dev](http://cluster.dev) — the only manager for cloud-native infrastructures.                   |
| --------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| [![](.gitbook/assets/coder-logo-for-sponsor.png)](http://coder.com/)  | [Coder.com](http://coder.com/) — create remote development machines for your team, powered by Terraform. |

## License

Ce travail est sous licence Apache 2. Voir LICENCE pour plus de détails.

Les auteurs et contributeurs de ce contenu ne peuvent garantir la validité des informations trouvées ici. Veuillez vous assurer que vous comprenez que les informations fournies ici sont fournies librement et qu'aucun type d'accord ou de contrat n'est créé entre vous et toute personne associée à ce contenu ou projet. Les auteurs et les contributeurs n'assument pas et déclinent par la présente toute responsabilité envers toute partie pour toute perte, dommage ou perturbation causé par des erreurs ou des omissions dans les informations contenues dans, associées ou liées à ce contenu, que ces erreurs ou omissions résultent de négligence, accident ou toute autre cause.

Copyright © 2018-2022 Anton Babenko.
