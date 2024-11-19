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

## Sponsors

Please [contact me](https://github.com/antonbabenko/terraform-aws-devops#social-links) if you want to become a sponsor.

| [![](.gitbook/assets/ctf-logo.png)](https://compliance.tf/?utm_source=tf_best_practices&utm_medium=sponsorship) | [Compliance.tf](https://compliance.tf/?utm_source=tf_best_practices&utm_medium=sponsorship) — Terraform Compliance Simplified. Make your Terraform modules compliance-ready. |
| --------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [![](.gitbook/assets/)]()                                                                                       | []() —                                                                                                                                                                       |

## Translations

{% content-ref url="https://app.gitbook.com/s/u3iITRIHQx97ro2PkfdC/" %}
[العربية (Arabic)](https://app.gitbook.com/s/u3iITRIHQx97ro2PkfdC/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/PJbgKPAX0ohEMLpETpg7/" %}
[Bosanski (Bosnian)](https://app.gitbook.com/s/PJbgKPAX0ohEMLpETpg7/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/B48qUSNPO2XmkIySLzfr/" %}
[Português (Brazilian Portuguese)](https://app.gitbook.com/s/B48qUSNPO2XmkIySLzfr/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/e1Mp2scOX6OnQbifCen3/" %}
[English](https://app.gitbook.com/s/e1Mp2scOX6OnQbifCen3/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/DyguS0uZfMW7X7m9BWx1/" %}
[ქართული (Georgian)](https://app.gitbook.com/s/DyguS0uZfMW7X7m9BWx1/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/PKopCWJZbhpQ9FT0W8tL/" %}
[Deutsch (German)](https://app.gitbook.com/s/PKopCWJZbhpQ9FT0W8tL/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/5c1kFpqxaDZC2g9e6rtT/" %}
[ελληνικά (Greek)](https://app.gitbook.com/s/5c1kFpqxaDZC2g9e6rtT/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/4bq6CyY8vYiEHkjN63rT/" %}
[עברית (Hebrew)](https://app.gitbook.com/s/4bq6CyY8vYiEHkjN63rT/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/Mgong4S6IjtibE055zUM/" %}
[हिंदी (Hindi)](https://app.gitbook.com/s/Mgong4S6IjtibE055zUM/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/ZLCz7lNWbSJxDGuNOI44/" %}
[Bahasa Indonesia (Indonesian)](https://app.gitbook.com/s/ZLCz7lNWbSJxDGuNOI44/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/8VlMHbHDbW6qRWdgN5oU/" %}
[Italiano (Italian)](https://app.gitbook.com/s/8VlMHbHDbW6qRWdgN5oU/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/3vykLOWgdQLPLgHtxqQH/" %}
[日本語 (Japanese)](https://app.gitbook.com/s/3vykLOWgdQLPLgHtxqQH/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/BoZVs6O2OJFQLNV1utmm/" %}
[ಕನ್ನಡ (Kannada)](https://app.gitbook.com/s/BoZVs6O2OJFQLNV1utmm/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/bJnDvAqIyVgo7LDHgxYJ/" %}
[한국어 (Korean)](https://app.gitbook.com/s/bJnDvAqIyVgo7LDHgxYJ/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/9yChMGbFo2G47Wiow1yY/" %}
[Polski (Polish)](https://app.gitbook.com/s/9yChMGbFo2G47Wiow1yY/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/sFM1GW5TPCGsskQ03mTm/" %}
[Română (Romanian)](https://app.gitbook.com/s/sFM1GW5TPCGsskQ03mTm/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/5VD4NK4mHOY8SWjC9N5e/" %}
[简体中文 (Simplified Chinese)](https://app.gitbook.com/s/5VD4NK4mHOY8SWjC9N5e/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/fTxekzr50pIuGmrPkXUD/" %}
[Español (Spanish)](https://app.gitbook.com/s/fTxekzr50pIuGmrPkXUD/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/Fedpbc5NbKjynXI8xTeF/" %}
[Türkçe (Turkish)](https://app.gitbook.com/s/Fedpbc5NbKjynXI8xTeF/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/tXRvMPILxeJaJTM2CsSq/" %}
[Українська (Ukrainian)](https://app.gitbook.com/s/tXRvMPILxeJaJTM2CsSq/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/dcjhau04KQIKHUJA90iN/" %}
[اردو (Urdu)](https://app.gitbook.com/s/dcjhau04KQIKHUJA90iN/)
{% endcontent-ref %}

Contactez-moi si vous voulez aider à traduire ce livre dans d'autres langues.

## Contributions

Je souhaite toujours obtenir des commentaires et mettre à jour ce livre au fur et à mesure que la communauté mûrit et que de nouvelles idées sont mises en œuvre et vérifiées au fil du temps. Si vous êtes intéressé par certains sujets, veuillez ouvrir un problème ou en indiquer un que vous souhaitez être traiter plus en détail. Si vous sentez que vous avez du contenu et que vous souhaitez y contribuer, rédigez un brouillon et soumettez un pull request (ne vous souciez pas d'écrire un bon texte à ce stade !)

## Authors

Ce livre est maintenu par Anton Babenko avec l'aide de différents contributeurs et traducteurs. Nicanor Foping l'a traduit en français.

## License

Ce travail est sous licence Apache 2. Voir LICENCE pour plus de détails.

Les auteurs et contributeurs de ce contenu ne peuvent garantir la validité des informations trouvées ici. Veuillez vous assurer que vous comprenez que les informations fournies ici sont fournies librement et qu'aucun type d'accord ou de contrat n'est créé entre vous et toute personne associée à ce contenu ou projet. Les auteurs et les contributeurs n'assument pas et déclinent par la présente toute responsabilité envers toute partie pour toute perte, dommage ou perturbation causé par des erreurs ou des omissions dans les informations contenues dans, associées ou liées à ce contenu, que ces erreurs ou omissions résultent de négligence, accident ou toute autre cause.

Copyright © 2018-2023 Anton Babenko.
