# Terraform per infrastrutture di grandi dimensioni

Sorgente: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/large-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/large-terraform)

Questo esempio contiene codice per strutturare configurazioni Terraform per infrastrutture di grandi dimensioni che usano:&#x20;

* 2 account AWS&#x20;
* 2 regioni
* 2 ambienti separati (`prod` e `stage` che non hanno niente in condivisione). Ogni ambiente vive in un account AWS separato e si distribuisce tra 2 regioni
* Ogni ambiente usa una versione differente del moduleo di infrastruttura off-the-shelf infrastructure module (`alb`) con sorgente[Terraform Registry](https://registry.terraform.io/)
* Ogni ambiente usa la stessa versione del modulo interno  `modules/network` dato che la sorgente di questo è una directory locale.&#x20;

{% hint style="info" %}
In un progetto grande come quello descritto i benefici di usare Terragrunt diventano molto evidenti. Vedi [Code Structures examples with Terragrunt](../terragrunt.md).
{% endhint %}

{% hint style="success" %}
* Perfetto per progetti dove l'infrastruttura é separata logicamente (account AWS separati)
* Adatto dove non c'é necessità di modificare risorse condivise tra account AWS ( un ambiente = un account AWS = un file di stato)
* Adatto dove non c'é necessità di orchestrare cambiamenti tra ambienti.
* Adatto dove le risorse di infrastruttura sono intenzionalmente diverse per ambiente e non possono essere generalizzate. (esempio, alcune risorse sono assenti in un ambiente o in alcune regioni)
{% endhint %}

{% hint style="warning" %}
Quando il progetto crescerà, sarà più difficile tenere questi ambienti aggiornati uno con l'altro. Considera l'uso dei moduli infrastruttura (dallo scaffale o interni) per attività che si ripetono.
{% endhint %}
