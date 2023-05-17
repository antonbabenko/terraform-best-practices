# Ključni koncepti

Zvanična Terrafrom dokumentacija detaljno opisuje sve detalje vezane za [konfiguraciju](https://www.terraform.io/docs/configuration/index.html). Pročitajte je pazljivo kako bi razumijeli ostatak ovog poglavlja.

Ovo poglavlje opisuje ključne koncepte koji su korišteni unutar ove knjige.

## Resursi

Resursi (eng. resource) su `aws_vpc`, `aws_db_instance`, itd. Resurs pripada pružatelju usluga u oblaku odnosno cloudu (eng. cloud provider), prihvata argumente, kao izlaznu informaciju pruža atribute i ima svoj životni ciklus. Resursi mogu biti kreirani, možete dohvatiti ranije kreirane resurse, raditi njihovo ažuriranje i brisanje.

## Resurs moduli

Resurs moduli (eng. resource module) predstavljaju kolekciju resursa, koji skupa mogu napraviti neku zajedničku akciju (npr. [AWS VPC Terraform modul ](https://github.com/terraform-aws-modules/terraform-aws-vpc/)kreira VPC, podmreže, NAT, itd). Od konfiguracije cloud provajdera zavisi koji resursi mogu biti definisani unutar modula, ili unutar struktura na većem nivou (npr. unutar infrastrukturnog modula).

## Infrastrukturni moduli

Infrastrukturni moduli predstavljaju kolekciju resurs modula, oni logički ne moraju biti povezani ali u odredjenoj situaciji ili konfiguraciji projekta služe istoj svrsi. Definišu kofiguraciju za cloud provajdera koja je prosljeđena resurs modulima a dalje prema samim resursima. Limitirani su na jedan entitet unutar logičke cjeline. (npr. AWS region, Google projekat)

Na primjer, modul [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis/) koristi resurs module kao što su  [terraform-aws-vpc ](https://github.com/terraform-aws-modules/terraform-aws-vpc/)i [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group/) kako bi se kreirala infrastruktura potrebna za pokretanje [Atlantisa](https://www.runatlantis.io) unutar [AWS Fargate](https://aws.amazon.com/fargate/) servisa.

Još jedan primjer je modul [terraform-aws-cloudquery](https://github.com/cloudquery/terraform-aws-cloudquery) gdje su zajedno korišteni drugi razlčiti moduli od strane [terraform-aws-modules ](https://github.com/terraform-aws-modules/)kao i od strane Docker resursa, kako bi se postiglo kreiranje i deplojment Docker slika, sve unutar jednog istog seta komandi.&#x20;

## Kompozicija

Kompozicija (eng. composition) je kolekcija infrastrukturnih modula, koji mogu biti rašireni preko nekoliko logički razdvojenih područja (npr. AWS regioni, različiti AWS računi). Kompozicija se koristi kako bi se opisala kompletna infrastruktura potrebna za čitavu organizaciju ili projekat.

Kompozicija se sastoji od infrastrukturnih modula, koji se dalje sastoje od modula resursa koji dalje implementiraju same resurse.

![Jednostavna infrastruktura kompozicije](.gitbook/assets/composition-1.png)

## Izvor podataka

Izvor podataka (eng. data source) je zadužen samo za operaciju čitanja, i zavisi od pružatelja cloud usluga, koristi se kao resurs modul i kao infrastrukturni modul.&#x20;

Izvor podataka `terraform_remote_state` se ponaša kao vezivno tkivo za module višeg nivoa i kompozicije.

Izvor podataka [external](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data\_source) dozvoljava vanjskim programima da budu izvor podataka, omogućavajući im kasnije korištenje u drugim dijelovima Terrafrom konfiguracije. Ovdje je primjer [terraform-aws-lambda module](https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/258e82b50adc451f51544a2b57fd1f6f8f4a61e4/package.tf#L5-L7) modula gdje je ime datoteke kreirano pozivajuci eksternu Paython skriptu.

Izvor podataka [http](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) pravi HTTP GET zahtjeve prema datom URL-u i eksportuje informacije dobijenog odgovora. Ovaj pristup se obično koristi da bi se dobile informacije izvora podataka od pristupne tačke (eng. endpoint) koja ne podržava Terrafrom.

## Udaljeno stanje

Infrastrukturni moduli i kompozicije bi se trebali nalaziti unutar svog fajla [Terrafrom stanja](https://developer.hashicorp.com/terraform/language/state) koji se pohranjuje na nekoj udaljenoj lokaciji sa koje moze biti dohvaćena od strane drugih programera na kontrolisan način (sa dnevnikom pristupa, specifičnom sigurnosnom politikom itd.)

## Provjader, provisioner, itd

Provajderi dostupni unutar terrafroma, zatim provisioners, kao i nekoliko drugih pojmova su vrlo dobro opisani i objašnjeni unutar zvanične dokumentacije tako da ih nećemo ovdje dodatno opisivati. Po mom mišljenju, oni imaju malo ili nimalo veze sa pisanjem dobrih Terrafrom modula.

## Zašto je tako teško?

Dok su individualni resursi kao atomi unutar infrastrukture, resurs moduli su molekule koje su sastavljene od atoma. Modul je namanja verzionisana i dijeljena jedinica. Posjeduje tačnu listu argumenata, osnovnu implementacijsku logiku da bi se napravila željena funkcionalnost. Npr. modul [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group) kreira `aws_security_group` i `aws_security_group_rule` resurse na osnovu ulaznih podataka. Ovaj resurs modul se sam po sebi može koristiti skupa sa drugim modulima kako bi se kreirao infruastrukturni modul.

Pristup podacima kroz različite molekule (resurs module i infrastrukturne module) je napravljen koristći izlazne podatke dobijene od strane modula i izvora podataka.

Pristup između kompozicija je često napravljen koristeći udaljeni fajl stanja izvora podataka. Postoji [više načina](https://developer.hashicorp.com/terraform/language/state/remote-state-data#alternative-ways-to-share-data-between-configurations) uz pomoć kojih se mogu dijeliti podaci između konfiguracija.

Ako koncepte opisane iznad postavimo u pseudo vezu onda bi to moglo izlgedati ovako:

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
