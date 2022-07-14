# Concetti chiave

La documentazione ufficiale di Terraform descrive [tutti gli aspetti di configurazione nei dettagli. ](https://www.terraform.io/docs/configuration/index.html)Leggila attentamente per capire il resto della sezione.&#x20;

Questa sezione descrive i concetti chiave che sono usati nel libro.

## Risorsa (resource)

Una risorsa è `aws_vpc`, `aws_db_instance`, ecc. Una risorsa appartiene a un provider, accetta argomenti, fornisce output, attributi e ha un ciclo di vita.  Una risorsa può essere creata, recuperata, aggiornata e cancellata.

## Modulo Risorsa&#x20;

Un modulo di risorsa è una collezione di risorse che insieme eseguono un'azione comune (per esempio  [AWS VPC Terraform module](https://github.com/terraform-aws-modules/terraform-aws-vpc/) crea VPC, subnets, NAT gateway, ecc).  Dipende dalla configurazione del provider, che può essere definito dentro il modulo oppure a un livello più alto della struttura (per esempio, in un modulo di infrastruttura).

## Modulo di Infrastrutura&#x20;

Un modulo di infrastruttura è una collezione di moduli risorsa, che possono non essere logicamente connessi, ma nella situazione/progetto/setup servono lo stesso scopo. Definisce la configurazione per i providers, che è passata ai moduli risorsa e alle risorse nei moduli sottostanti.  Normalmente è limitata al lavoro di una entità per separatore logico  (per esempio, AWS Region, Google Project).

Per esempio, il modulo [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis/) usa moduli risorse come [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc/) e [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group/) per amministrare l'infrastruttura richiesta per far girare  [Atlantis](https://www.runatlantis.io) su [AWS Fargate](https://aws.amazon.com/fargate/).

Un altro esempio è [terraform-aws-cloudquery](https://github.com/cloudquery/terraform-aws-cloudquery) un modulo, dove moduli multipli di [terraform-aws-modules](https://github.com/terraform-aws-modules/) sono usati insieme per amministrare l'infrastruttura, cosí come le risorse Docker usano i comandi  build, push, e deploy per le immagini Docker.&#x20;

## Composizione

La Composizione è una collezione di moduli infrastruttura, che possono espandersi tra diverse aree separate (per esempio, AWS Regions, diversi accounts AWS ).&#x20;

La Composizione è usata per descrivere un'infrastruttura completa richiesta per l'intera organizzazione o progetto.&#x20;

Una composizione consiste di moduli infrastruttura, che consistono di moduli risorsa, che implementano risorse individuali.&#x20;

![Simple infrastructure composition](.gitbook/assets/composition-1.png)

## Data source

Data source esegue una operazione di sola lettura ed è dipendente dalla configurazione del provider, viene usato in un modulo risorsa e in un modulo infrastruttura.

Il Data source `terraform_remote_state` agisce come colla per moduli di alto livello e composizioni.

Il data source [external](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data\_source) permette a un programma di agire come un data source, esponendo dati arbitrari ad essere usati in qualche altra parte delle configurazione Terraform. Un esempio dal modulo [terraform-aws-lambda ](https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/258e82b50adc451f51544a2b57fd1f6f8f4a61e4/package.tf#L5-L7)dove il nome del file è calcolato chiamando un script python esterno.

Il data source [http](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http)  fa delle chiamate HTTP GET a un dato URL e esporta le informazioni sulle risposte, questo metodo è spesso usato per prendere le informazioni da endpoint dove un provider Terraform nativo non esiste.&#x20;

## Stato Remoto

Moduli di infrastruttura e composizioni dovrebbero persistere in uno [stato remoto ](https://www.terraform.io/docs/language/state/index.html)in una posizione remota dove possono essere recuperate da altri in maniera controllata (per esempio, specificando ACL, versionamento e con attivitá di log).

## Provider, provisioner, ecc.

Providers, provisioners, e pochi altri termini sono ben descritti nella documentazione ufficiale e sarebbe inutile ripeterli qui. Secondo me hanno poco a che fare con lo scrivere dei buoni moduli Terraform.&#x20;

## Perchè è così difficile?

Mentre le risorse individuali sono come gli atomi nell'infrastruttura, i moduli di risorse sono come molecole. Un modulo è la più piccola unitá che si possa versionare e condividere. Ha una lista esatta di argomenti, implementa logiche di base per fare in modo che l'unitá esegua le funzionalitá richieste. Per esempio il modulo [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group)  crea  le risorse `aws_security_group` e `aws_security_group_rule` basandosi sul suo input.  Questo modulo di risorse da solo puó essere usato insieme ad altri moduli per create moduli di infrastruttura.

L'accesso ai dati tra le molecole (moduli risorsa e moduli infrastruttura) viene eseguito usando output dei moduli e il data sources.

L'accesso ai dati tra le composizioni viene spesso effettuato usando il data source di tipo remote state. Ci sono [molti modi di condividere dati tra le configurazioni. ](https://www.terraform.io/docs/language/state/remote-state-data.html#alternative-ways-to-share-data-between-configurations)

Quando mettiamo in pratica i concetti descritti sopra una pseudo-relazione potrebbe apparire in questo modo:

```
composition-1 {
  infrastructure-module-1 {
    data-source-1 => d1

    resource-module-1 {
      data-source-2 => d2
      resource-1 (d1, d2)
      resource-2 (d2)
    }

    resource-module-2 {
      data-source-3 => d3
      resource-3 (d1, d3)
      resource-4 (d3)
    }
  }

}
```
