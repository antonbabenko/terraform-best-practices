# Struttura del codice

Le domande collegate alla strutturazione del codice Terraform sono le piú frequenti nella community. Tutti hanno pensato alla migliore maniera per strutturare il codice a un certo punto del progetto.&#x20;

## Come dovrei strutturare le mie configurazioni Terraform?

Questa è una delle domande dove sono presenti molte soluzioni, è molto difficile dare un consiglio universale, andiamo a capire meglio con cosa abbiamo a che fare.

* Qual'è la complessitá del tuo progetto?
  * Numero di risorse collegate&#x20;
  * Numero di provider Terraform (guarda la nota sotto sui "provider logici" )
* Con che frequenza cambia la tua infrastruttura Terraform?
  * **Da** una volta a  mese/settimana/giorno
  * **A** continuamente (ogni volta quando c'e' un nuovo commit)
* Un cambiamento del codice può scatenare un aggiornamento? É permesso al CI server di aggiornare i repository quando viene fatto il build di un nuovo artefatto_?_
  * Solo gli sviluppatori possono fare il push al repository di infrastruttura
  * Tutti possono proporre un cambiamento a qualsiasi parte del progetto aprendo una PR ( includendo i task automatici che girano sul server CI)
* Quale piattaforma o servizio usi per il deployment?&#x20;
  * AWS CodeDeploy, Kubernetes, o OpenShift richiedono degli approcci leggermente differenti
* Come sono raggruppati il ambienti?
  * Per ambiente, regione, progetto&#x20;

{% hint style="info" %}
_I provider logici lavorano interamente con la logica Terraform e spesso non interagiscono con altri servizi, pensiamo alla loro complessità come O(1). I provider logici più comuni sono_ [random](https://registry.terraform.io/providers/hashicorp/random/latest/docs), [local](https://registry.terraform.io/providers/hashicorp/local/latest/docs), [terraform](https://www.terraform.io/docs/providers/terraform/index.html), [null](https://registry.terraform.io/providers/hashicorp/null/latest/docs), [time](https://registry.terraform.io/providers/hashicorp/time/latest).
{% endhint %}

## Cominciamo a strutturare le configurazioni Terraform.&#x20;

Mettere tutto il codice dentro il file `main.tf` é una buona idea quando si sta cominciando o si sta scrivendo un codice di esempio. In tutti gli altri casi é meglio avere più file divisi logicamente in questo modo:

* `main.tf` - chiamate ad altri moduli, locals, e data sources per creare altre risorse
* `variables.tf` - contiene dichiarazioni di variabili usate dentro `main.tf`
* `outputs.tf` - contiene outputs di risorse create dentro `main.tf`
* `versions.tf` - contiene le versioni richieste per Terraform per per i providers

`terraform.tfvars` non dovrebbe essere mai usato eccetto nelle [composizioni](key-concepts.md#composition).

## Come organizzare la struttura delle configurazioni Terraform?

{% hint style="info" %}
Per favore assicurati di aver capito i concetti chiave - [modulo risorsa](key-concepts.md#resource-module), [modulo infrastruttura](key-concepts.md#infrastructure-module), e [composizione](key-concepts.md#composition), dato che verranno usati negli esempi seguenti.
{% endhint %}

### Raccomandazioni per la struttura del codice.

* È piu facile e veloce lavorare con un numero di risorse piccolo.&#x20;
  * `terraform plan` e `terraform apply` eseguono delle chiamate API cloud per verificare lo stato delle risorse.
  * Se si ha l'intera infrastruttura in una composizione singola fare queste chiamate API puó richiedere molto tempo.
* I danni a causati di un evento catastrofico sono minori con meno risorse.
  * Isolare risorse non collegate mettendole in composizioni separate riduce il rischio in caso qualcosa vada male.
* Inizia il  progetto usando lo stato remoto perchè :
  * Il laptop non è il posto per tenere la "fonte della verità" riguardo  all'infrastruttura.&#x20;
  * Amministrare il file `tfstate` in git é un incubo
  * Quando l'infrastruttura crescerà in direzioni multiple (aumentando il numero di risorse e dipendenze) sarà piú facile tenere tutto sotto controllo.&#x20;
* Fai pratica usando una struttura del codice consistente e una  [convezione sui nomi](naming.md):
  * Come il codice procedurale, il codice Terraform dovrebbe essere scritto per essere letto dalle persone in prima istanza, la consistenza aiuterà quando ci sarà da fare cambiamenti dopo sei mesi.&#x20;
  * È possibile spostare le risorse tra i file di stato di Terraform ma non sarà semplice se avrai una struttura di codice e un naming non consistente.&#x20;
* Tieni le risorse nei moduli nella maniera più pulita possibile.
* Non fare hardcode di valori che possono essere passati come variabili o scoperti usando data sources
* Usa data sources e `terraform_remote_state` come una colla tra moduli di infrastruttura con diverse composizioni.&#x20;

In questo libro, gli esempi dei progetti sono raggruppati per complessità - dall'infrastruttura più piccola a quella più grande. Anche se la separazione non é restrittiva. &#x20;

### Orchestrazione di moduli infrastruttura e composizioni.&#x20;

Avere un'infrastruttura piccola significa un numero di dipendenze minori e poche risorse. Quando il progetto cresce, anche la necessità di collegare l'esecuzione di configurazioni Terraform, connettere moduli di infrastruttura diversi, e passare valori con composizioni diventa ovvia.&#x20;

Ci sono almeno 5 gruppi distinti di soluzioni di orchestrazione che uno sviluppatore usa:

1. Solo Terraform.  Approccio diretto, gli sviluppatori devono conoscere solo Terraform per compiere il lavoro.&#x20;
2. Terragrunt. Un tool di orchestrazione puro, che può essere usato per orchestrare l'intera infrastruttura e gestire le dipendenze. Terragrunt opera con moduli di infrastruttura e composizioni native, in questo modo riduce la duplicazione del codice.&#x20;
3. Scripts personalizzati. Spesso accade come punto di partenza verso l'orchestrazione e prima di scoprire Terragrunt.
4. Ansible o tool simili di automazione. Solitamente quando Terraform viene adottato dopo Ansible, o quando è usata la UI di Ansible.&#x20;
5. [Crossplane](https://crossplane.io/) e altre solutioni ispiriate a Kubernetes. Alcune volte ha senso utilizzare l'ecosistema Kubernets e impiegare un  "reconciliation loop feature" per raggiungere lo stato desiderato  della nostra configurazione Terraform. Guarda il video [Crossplane vs Terraform](https://www.youtube.com/watch?v=ELhVbSdcqSY) per avere più informazioni.&#x20;

Tenendo presente tutto questo, il libro rivede i primi due approcci Terraform da solo oppure con Terragrunt.

Guarda gli esempi e la strutturazione del codice per [Terraform](examples/terraform/) o [Terragrunt](examples/terragrunt.md) nel prossimo capitolo.
