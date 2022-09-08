# Concepte cheie

Documentația oficială pentru Terraform descrie [toate aspectele configurației în detaliu](https://www.terraform.io/language.). Citiți-o cu atenție pentru a înțelege restul capitolului.&#x20;

Acest capitol descrie conceptele cheie folosite în această carte.

## Resurse

Resursele sunt, de exemplu, `aws_vpc`, `aws_db_instance`, etc. O resursă aparține unui furnizor (provider), acceptă argumente, întoarce atribute și are cicluri de viață. O resursă poate fi creată, preluată, actualizată și ștearsă.

## Modulul de resurse

Modulul de resurse este o colecție de resurse conectate care realizează împreună o acțiune comună (de exemplu, [modulul Terraform pentru AWS VPC](https://github.com/terraform-aws-modules/terraform-aws-vpc/) creează VPC, subrețele, NAT gateway etc.). Depinde de configurația furnizorului, care poate fi definită în acesta, sau în structuri de nivel superior (de exemplu, în modulul de infrastructură).

## Modulul de infrastructură

Un modul de infrastructură este o colecție de module de resurse, care în mod logic nu pot fi conectate, dar în situația actuală/proiectul/setarea servesc aceluiași scop. Acesta definește configurația pentru furnizori, care este transmisă modulelor de resurse din interior și resurselor. În mod normal, este limitat să funcționeze într-o singură entitate per separator logic (de exemplu, Regiune AWS, Proiect Google).

De exemplu, modulul [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis/) folosește module de resurse ca [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc/) și [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group/) pentru a gestiona infrastructura necesară rulării [Atlantis](https://www.runatlantis.io) în [AWS Fargate](https://aws.amazon.com/fargate/).

Un alt exemplu este modulul [terraform-aws-cloudquery](https://github.com/cloudquery/terraform-aws-cloudquery) unde mai multe module de [terraform-aws-modules](https://github.com/terraform-aws-modules/) sunt utilizate împreună pentru a gestiona infrastructura, precum și pentru a folosi resursele Docker pentru a face build, push, și deploy imaginilor de Docker. Toate într-un singur set.

## Compoziţia de infrastructură

Compoziţia este o colecție de module de infrastructură, care se pot întinde pe mai multe zone separate logic (de exemplu, regiuni AWS, mai multe conturi AWS). Compoziţia este utilizată pentru a descrie infrastructura completă necesară pentru întreaga organizație sau întreagul proiect.

O compoziţie este constituită din module de infrastructură, care sunt constituite din module de resurse, care implementează resurse individuale.

![O compoziţie de infrastructură simplă ](.gitbook/assets/composition-1.png)

## Sursa de date

Sursa de date efectuează o operație doar de citire și depinde de configurația furnizorului, este utilizată într-un modul de resurse și într-un modul de infrastructură.

Sursa de date `terraform_remote_state` acționează ca o legătură între module de nivel superior și compoziții.

Sursa externă de date permite unui program extern să acționeze ca sursă de date, expunând date arbitrare pentru a fi utilizate în altă parte în configurația Terraform. Iată un exemplu din modulul [terraform-aws-lambda](https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/258e82b50adc451f51544a2b57fd1f6f8f4a61e4/package.tf#L5-L7) în care numele fișierului este calculat prin apelarea unui script de Python extern.

Sursa de date [http ](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http)face o solicitare HTTP GET către adresa URL dată și exportă informații despre răspuns, care sunt adesea utile pentru a obține informații de la punctele finale (endpoints) în care nu există un furnizor Terraform nativ.

## Remote state

Modulele de infrastructură și compozițiile ar trebui să-și păstreze [starea Terraform](https://www.terraform.io/language/state) într-o locație la distanță numită remote state, unde pot fi preluate de către alții într-un mod controlabil (de exemplu, specificații ACL, versionări, logging).

## Provider, provisioner, etc

Providers, provisioners, și alți câțiva termeni sunt descriși foarte bine în documentația oficială și nu are rost să repet aici. După părerea mea, au puțin de-a face cu scrierea unor module bune de Terraform.

## De ce atât de _dificil_?

În timp ce resursele individuale sunt ca atomii din infrastructură, modulele de resurse sunt ca moleculele. Un modul este cea mai mică unitate versionabilă și partajabilă. Are o listă exactă de argumente, implementează logica de bază pentru ca o astfel de unitate să facă funcția necesară. De exemplu, modulul [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group) creează resursele `aws_security_group`și `aws_security_group_rule` pe baza informației de intrare. Acest modul de resurse poate fi folosit împreună cu alte module pentru a crea modulul de infrastructură.

Accesul la date între molecule (module de resurse și module de infrastructură) se realizează folosind datele de ieșire ale modulelor (outputs) și sursele de date (data sources).

Accesul între compoziții se realizează adesea folosind surse de date de la distanță (remote state data sources). Există mai [multe moduri de a partaja date între configurații](https://www.terraform.io/language/state/remote-state-data#alternative-ways-to-share-data-between-configurations).

Când puneți conceptele descrise mai sus în pseudo-relații, acestea pot arăta astfel:

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
