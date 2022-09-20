---
description: >-
  Acest document este o încercare de a descrie cele mai bune practici pentru
  folosirea Terraform și de a oferi recomandări pentru cele mai frecvente
  probleme întâmpinate de utilizatorii Terraform.
---

# Bine ați venit

[Terraform](https://www.terraform.io/) este un proiect nou (ca și majoritatea tool-urilor de DevOps) și a fost creat în 2014.

Terraform este unul din cele mai puternice (poate chiar cel mai puternic) instrumente și unul din cele mai folosite pentru a defini infrastructura ca și cod. Le permite dezvoltatorilor să facă o mulțime de lucruri și nu îi împiedică să facă lucruri în moduri care vor fi greu de susținut sau de integrat în viitor.

Este posibil ca unele informații descrise în această carte să nu pară cele mai bune practici. Știu acest lucru și pentru a ajuta cititorii să separe cele mai bune practici stabilite de ceea ce este doar un alt mod de a face lucrurile într-un anumit fel, folosesc uneori indicii pentru a oferi context și pictograme pentru a specifica nivelul de maturitate pentru fiecare subsecțiune legată de cele mai bune practici.

Cartea a început în însoritul Madrid în 2018 și este disponibilă gratuit aici - [https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com/) .

Câțiva ani mai târziu, a fost actualizată cu mai multe bune practici disponibile cu Terraform 1.0. În cele din urmă, această carte ar trebui să conțină cele mai multe dintre cele mai bune practici și recomandări indiscutabile pentru utilizatorii Terraform.

## Traduceri

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

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/Fedpbc5NbKjynXI8xTeF/" %}
[Türkçe (Turkish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/Fedpbc5NbKjynXI8xTeF/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/" %}
[Українська (Ukrainian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/)
{% endcontent-ref %}

Contactați-mă dacă doriți să ajutați la traducerea acestei cărți în alte limbi.

## Contribuții

Îmi doresc întotdeauna să primesc feedback și să actualizez această carte pe măsură ce comunitatea se maturizează și noi idei sunt implementate și verificate în timp.

Dacă sunteți interesați de anumite subiecte vă rog[ ](https://github.com/antonbabenko/terraform-best-practices/issues)deschideți [un issue](https://github.com/antonbabenko/terraform-best-practices/issues) (o problemă), sau dați "Like" la o problemă existentă pe care doriți să o abordați cel mai mult. Dacă simțiți că aveți conținut și doriți să contribui, scrieți un text și trimiteți un pull request (nu vă faceți griji dacă scrieți un text bun în acest moment!).

## Autori

Această carte este menținută de [Anton Babenko](https://github.com/antonbabenko) cu ajutorul diferiților colaboratori și traducători.

## Sponsori

| [![](.gitbook/assets/cluster-dev-logo-site.png)](https://cluster.dev) | [Cluster.dev](http://cluster.dev) — singurul manager pentru infrastructurile cloud native.                                      |
| --------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| [![](.gitbook/assets/coder-logo-for-sponsor.png)](http://coder.com/)  | [Coder.com](http://coder.com/) — creați mașini de dezvoltare la distanță (remote) pentru echipa voastră, susținut de Terraform. |

## Licență

Această lucrare este licențiată sub Apache 2 License. Consultați LICENSE pentru detalii complete.

Autorii și colaboratorii la acest conținut nu pot garanta valabilitatea informațiilor găsite aici. Vă rugăm să vă asigurați că înțelegeți că informațiile furnizate aici sunt furnizate în mod liber și că nu este creat niciun fel de acord sau contract între dvs. și orice persoană asociată cu acest conținut sau proiect. Autorii și colaboratorii nu își asumă și nu își declină nicio responsabilitate față de orice parte pentru orice pierdere, daune sau întrerupere cauzată de erori sau omisiuni în informațiile conținute în, asociate cu sau legate de acest conținut, indiferent dacă astfel de erori sau omisiuni rezultă din neglijență, accident sau orice altă cauză.

Copyright © 2018-2022 Anton Babenko.
