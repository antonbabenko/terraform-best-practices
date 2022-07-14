# Terraform per infrastrutture di media dimensione

Sorgente: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform)

Questo esempio contiene codice per strurtturare le configurazioni Terraform per infrastture di dimensioni medie che usano:

2 account AWS

* 2 ambienti separati (`prod` e `stage` che non hanno niente in condivisione). Ogni ambiente vive in un account AWS separato
* Ogni ambiente usa una versione differente del moduleo di infrastruttura dallo scaffale infrastructure module (`alb`) con sorgente [Terraform Registry](https://registry.terraform.io/)
* Ogni ambiente usa la stessa versione del modulo interno  `modules/network` dato che la sorgente di questo è una directory locale.&#x20;

{% hint style="success" %}
* Perfetto per progetti dove l'infrastruttura é separata logicamente (account AWS separati)
* Adatto dove non c'é necessità di modificare risorse condivise tra account AWS ( un ambiente = un account AWS = un file di stato)
* Adatto dove non c'é necessità di orchestrare cambiamenti tra ambienti.
* Adatto dove le risorse di infrastruttura sono intenzionalmente diverse per ambiente e non possono essere generalizzate. (esempio, alcune risorse sono assenti in un ambiente o in alcune regioni)
{% endhint %}

{% hint style="warning" %}
Con la crescita del progetto, diventerà difficile tenere questi ambienti aggiornati l'uno con l'altro. Va considerato l'uso di moduli di infrastruttura (dallo scaffale o interni) per task ripetibili.
{% endhint %}

##
