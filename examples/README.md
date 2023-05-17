# Primjeri organizacije koda

## Terraform struktura koda

{% hint style="info" %}
Ovi primjeri koriste AWS Terrafrom provjader ali vecina principa pokazanih u ovim primjerima moze biti primjenjena i na druge cloud projvadere kao i na druge vrste provajdera (DNS, DB itd.)
{% endhint %}

| Tip                                                             | Opis                                                                                                                                       | Status        |
| --------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ | ------------- |
| [mala](terraform/small-size-infrastructure.md)                  | Nekoliko resursa, bez vanjskih zavisnosti. Jedan AWS racun. Jedna regija. Jedno okruzenje.                                                 | Zavrseno      |
| [srednja](terraform/medium-size-infrastructure.md)              | Nekoliko AWS racuna i okruzenja, skolski primjer infrastrukturnih modula koristeci Terrafrom                                               | Zavrseno      |
| [velika](terraform/large-size-infrastructure-with-terraform.md) | Vise AWS racuna, mnogo regiona, hitna potreba da se smanji kopiranje i ponavljanje koda, velika upotreba konpozicija. Koristi se Terrafrom | Rad u toku    |
| vrlo velika                                                     | Nekoliko razlicitih cloud provajdera(AWS, GCP, Azure). Deplojment na vise cloud platformi. Koristi se Terrafrom.                           | Nije zapoceto |

## Terragrunt struktura koda

| Tip     | Opis                                                                                                                                       | Status        |
| ------- | ------------------------------------------------------------------------------------------------------------------------------------------ | ------------- |
| mala    | Nekoliko AWS racuna i okruzenja, skolski primjer infrastrukturnih modula koristeci Terrafrom                                               | Nije zapoceto |
| srednja | Vise AWS racuna, mnogo regiona, hitna potreba da se smanji kopiranje i ponavljanje koda, velika upotreba konpozicija. Koristi se Terrafrom | Nije zapoceto |
| velika  | Nekoliko razlicitih cloud provajdera(AWS, GCP, Azure). Deplojment na vise cloud platformi. Koristi se Terragrunt.                          | Nije zapoceto |
