# Esempi di strutturazione del codice

## Struttura del codice Terraform&#x20;

{% hint style="info" %}
Questi esempi sono realizzati con il provider AWS ma la maggior parte dei principi mostrati possono essere applicati anche ad altri provider cloud e non (DNS, DB, Monitoring, ecc)
{% endhint %}

| Tipo                                                            | Descrizione                                                                                                                                                         | Disponibilità          |
| --------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------- |
| [piccolo](terraform/small-size-infrastructure.md)               | Poche risorse, nessuna dipendenza esterna.  Un solo AWS account. Una sola Regione. Un solo ambiente.                                                                | Si                     |
| [media](terraform/medium-size-infrastructure.md)                | Più account AWS e ambienti, moduli standard di infrastruttura Terraform.                                                                                            | Si                     |
| [grande](terraform/large-size-infrastructure-with-terraform.md) | Molti accounts AWS, molte regioni, importanza di ridurre il copia-incolla, moduli di infrastruttura personalizzati , pesante uso di composizioni. Uso di Terraform. | Non ancora disponibile |
| molto-grande                                                    | Più providers (AWS, GCP, Azure). Deploy Multi-cloud. Uso di Terraform.                                                                                              | No                     |

## Terragrunt code structures

| Tipo       | Descrizione                                                                                                                                                          | Disponibilità |
| ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- |
| medio      | Diversi account AWS e ambienti, moduli di infrastruttura standard, pattern di composizione usando Terragrunt.                                                        | No            |
| large      | Molti accounts AWS, molte regioni, importanza di ridurre il copia-incolla, moduli di infrastruttura personalizzati , pesante uso di composizioni. Uso di Terragrunt. | No            |
| very-large | Più providers (AWS, GCP, Azure). Deploy Multi-cloud. Uso di  Terragrunt.                                                                                             | No            |
