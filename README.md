---
description: >-
  Questo documento è un tentativo di descrivere le best practices nell'uso di
  Terraform e fornire suggerimenti per i problemi che accadono più
  frequentemente nell'uso di Terraform.
---

# Benvenuti

[Terraform](https://www.terraform.io/) é un nuovo progetto (come la maggior parte degli strumenti di DevOps) inizato nel 2014.

Terraform é un potente (se non il piú potente disponibile al momento) e uno dei tool più usati, che permette l'approccio infrastruttura come codice. Abilita agli sviluppatori di fare molte cose, e non li limita a fare cose in un modo che è difficile da supportare o integrare con altri strumenti.

Alcune informazioni descritte in questo libro potrebbero non sembrare delle best practices. Voglio distinguere cosa sono delle best practices certe e stabilite e cosa invece sono opinioni. Alcune volte userò note per specificare meglio il contesto e icone per il livello di maturitá di ogni sottosezione.

Il libro é iniziato nel 2018 in una soleggiata Madrid ed é disponibile gratuitamente qui - [https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com/) .

Qualche anno dopo é sto aggiornato con alcune delle piú recenti best practices in Terraform 1.0. Infine, questo libro dovrebbe contenere alcune delle più indiscutibili best practices e raccomandazioni per utenti di Terraform.

Nota del traduttore: sono stato molto combattuto (e ho chiesto consiglio ad altre persone che come me lavorano nell'informatica) se tradurre best practices oppure no. Alla fine ho deciso che le "pratiche migliori" , o "stato dell'arte", "pratiche buone" non rendeva bene il termine e quindi l'ho lasciato in inglese.

## Traduzioni

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/e1Mp2scOX6OnQbifCen3/" %}
[English](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/e1Mp2scOX6OnQbifCen3/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/" %}
[Español (Spanish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/" %}
[Bahasa Indonesia (Indonesian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/PJbgKPAX0ohEMLpETpg7/" %}
[Bosanski (Bosnian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/PJbgKPAX0ohEMLpETpg7/)
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

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/BoZVs6O2OJFQLNV1utmm/" %}
[ಕನ್ನಡ (Kannada)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/BoZVs6O2OJFQLNV1utmm/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/Mgong4S6IjtibE055zUM/" %}
[हिंदी (Hindi)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/Mgong4S6IjtibE055zUM/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/" %}
[Português (Brazilian Portuguese)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/" %}
[Polski (Polish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/sFM1GW5TPCGsskQ03mTm/" %}
[Română (Romanian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/sFM1GW5TPCGsskQ03mTm/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/Fedpbc5NbKjynXI8xTeF/" %}
[Türkçe (Turkish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/Fedpbc5NbKjynXI8xTeF/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/" %}
[Українська (Ukrainian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/)
{% endcontent-ref %}

Contattami se vuoi tradurre il libro in altre lingue.

## Contributi

Sono sempre alla ricerca di feedback e desidero aggiornare questo libro con il maturare della comunity. Nuove idee e implementazioni verranno valutate e verificate.

Se sei interessato in alcuni argomenti per favore [fai una richiesta (open an issue](https://github.com/antonbabenko/terraform-best-practices/issues)), oppure mettipi un mi piace su una giá aperta a cui sei interessato. Se credi di porter fornire contenuti e vuoi contribuire, scrivi una bozza e manda una pull request (non preoccuparti di scrivere del buon contenuto in questa fase!)

## Autori

Questo libro é mantenuto da [Anton Babenko](https://github.com/antonbabenko) con l'aiuto di diversi traduttori e collaboratori.

## Sponsors

| [<img src=".gitbook/assets/cluster-dev-logo-site.png" alt="" data-size="original">](https://cluster.dev/) | [Cluster.dev](http://cluster.dev/) — the only manager for cloud-native infrastructures.                  |
| --------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| [![](.gitbook/assets/coder-logo-for-sponsor.png)](http://coder.com/)                                      | [Coder.com](http://coder.com/) — create remote development machines for your team, powered by Terraform. |

## Licenza

Questo contenuto é sotto la licenza Apache 2. Controlla LICENSE per maggiori dettagli.

Gli autori e i collaboratori di questo contenuto non possono garantire la validitá delle informazioni. Per favore assicurati di capire che le informazioni fornite qui sono date in maniera gratuita, non c'é nessuno accordo o contratto tra te e ogni persona associata al contenuto e al progetto. Gli autori e i collaboratori non si assumano e con la presente declinano qualsivoglia responsabilitá a ogni parte per qualsiasi perdita, danneggiamento o discontinuitá causata da errori o omissioni nelle informazioni contenute, associate o collegate a questo contenuto, sia che siano errori o omissioni causate da negligenza, o qualsiasi altra causa.

Copyright © 2018-2022 Anton Babenko.
