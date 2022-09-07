---
description: >-
  Acest document este o încercare de a descrie cele mai bune practici pentru
  folosirea Terraform și de a oferi recomandări pentru cele mai frecvente
  probleme întâmpinate de utilizatorii Terraform.
---

# Bine ați venit

[Terraform](https://www.terraform.io/) este un proiect nou (ca și concept-ul de DevOps) și a fost creat în 2014.

Terraform este unul din cele mai puternice (poate chiar cel mai puternic) instrumente și unul din cele mai folosite pentru a defini infrastructura ca și cod. Le permite dezvoltatorilor să facă o mulțime de lucruri și nu îi împiedică să facă lucruri în moduri care vor fi greu de susținut sau de integrat în viitor.

Este posibil ca unele informații descrise în această carte să nu pară cele mai bune practici. Știu acest lucru și pentru a ajuta cititorii să separe cele mai bune practici stabilite de ceea ce este doar un alt mod de a face lucrurile într-un anumit fel, folosesc uneori indicii pentru a oferi context și pictograme pentru a specifica nivelul de maturitate pentru fiecare subsecțiune legată de cele mai bune practici.

Cartea a început în însoritul Madrid în 2018 și este disponibilă gratuit aici - [https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com/) .

Câțiva ani mai târziu, a fost actualizată cu mai multe bune practici disponibile cu Terraform 1.0. În cele din urmă, această carte ar trebui să conțină cele mai multe dintre cele mai bune practici și recomandări indiscutabile pentru utilizatorii Terraform.

## Translations

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/" %}
[Español (Spanish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/e1Mp2scOX6OnQbifCen3/" %}
[English](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/e1Mp2scOX6OnQbifCen3/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/" %}
[Bahasa Indonesia (Indonesian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/" %}
[Français (French)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/)
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

Contact me if you want to help translate this book into other languages.

## Contributions

I always want to get feedback and update this book as the community mature and new ideas are implemented and verified over time.

If you are interested in certain topics please [open an issue](https://github.com/antonbabenko/terraform-best-practices/issues), or thumb up an issue you want to be covered most. If you feel that **you have content** and you want to contribute, write a draft and submit a pull request (don't worry about writing good text at this point!)

## Authors

This book is maintained by [Anton Babenko](https://github.com/antonbabenko) with the help of different contributors and translators.

## Sponsors

| [<img src=".gitbook/assets/cluster-dev-logo-site.png" alt="" data-size="original">](https://cluster.dev/) | [Cluster.dev](http://cluster.dev/) — the only manager for cloud-native infrastructures. |
| --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |

## License

This work is licensed under Apache 2 License. See LICENSE for full details.

The authors and contributors to this content cannot guarantee the validity of the information found here. Please make sure that you understand that the information provided here is being provided freely, and that no kind of agreement or contract is created between you and any persons associated with this content or project. The authors and contributors do not assume and hereby disclaim any liability to any party for any loss, damage, or disruption caused by errors or omissions in the information contained in, associated with, or linked from this content, whether such errors or omissions result from negligence, accident, or any other cause.

Copyright © 2018-2022 Anton Babenko.
