# Structura codului

Întrebările legate de structura codului Terraform sunt de departe cele mai frecvente în comunitate. La un moment dat, toată lumea s-a gândit la cea mai bună structură de cod pentru proiect.

## Cum ar trebui să-mi structurez configurațiile Terraform?

Aceasta este una dintre întrebările pentru care există o mulțime de soluții și este foarte greu să dai sfaturi universale, așa că este util să începem prin a înțelege cu ce avem de-a face.

* Care este complexitatea proiectului?
  * Numărul de resurse aferente
  * Numărul de furnizori Terraform (vezi nota de mai jos despre „furnizorii logici”)
* Cât de des se schimbă infrastructura proiectului?
  * **De la** o dată pe lună/săptămână/zi
  * **La** continuu (de fiecare dată când există un nou commit)
* Tirggeri pentru schimbari in cod? _Permiteți serverului CI să actualizeze Git repository atunci când este construit un nou artefact?_
  * Doar dezvoltatorii pot face push în repository-ul de infrastructură
  * Toată lumea poate propune o schimbare la orice, deschizând un PR (inclusiv activități automate care rulează pe serverul CI)
* Ce platformă de implementare sau serviciu de implementare utilizați?
  * AWS CodeDeploy, Kubernetes, sau OpenShift au nevoie de o abordare ușor diferită
* Cum sunt grupate mediile?
  * După mediu, regiune, proiect

{% hint style="info" %}
_Furnizorii logici_ lucrează în întregime în logica Terraform și de foarte multe ori nu interacționează cu niciun alt serviciu, așa că ne putem gândi la complexitatea lor ca O(1). Cei mai comuni furnizori logici includ: [random](https://registry.terraform.io/providers/hashicorp/random/latest/docs), [local](https://registry.terraform.io/providers/hashicorp/local/latest/docs), [terraform](https://www.terraform.io/docs/providers/terraform/index.html), [null](https://registry.terraform.io/providers/hashicorp/null/latest/docs), [time](https://registry.terraform.io/providers/hashicorp/time/latest).
{% endhint %}

## Introducere în structurarea fișierelor de configurație Terraform

Punerea întregului cod în `main.tf` este o idee bună atunci când începeți sau scrieți un exemplu de cod. În toate celelalte cazuri, va fi mai bine să aveți mai multe fișiere împărțite logic astfel:

* `main.tf` - apelați module, informații __ locale și surse de date pentru a crea toate resursele
* `variables.tf` - conține declarații ale variabilelor utilizate în `main.tf`
* `outputs.tf` - conține rezultate din resursele create în`main.tf`
* `versions.tf` - conține cerințele de versiune pentru Terraform și furnizori

`terraform.tfvars` nu trebuie folosit nicăieri decât in [Compoziţia de infrastructură](key-concepts.md#compozitia-de-infrastructura).

## Cum să ne gândim la structura fișierelor de configurație Terraform?

{% hint style="info" %}
Vă rog să vă asigurați că înțelegeți conceptele cheie - [modulul de resurse](key-concepts.md#modul-de-resurse), [modulul de infrastructură](key-concepts.md#modulul-de-infrastructura) și [compoziția de infrastructură](key-concepts.md#compozitia-de-infrastructura), așa cum sunt utilizate în exemplele următoare.
{% endhint %}

### Recomandări uzuale pentru structurarea codului

* Este mai ușor și mai rapid să lucrezi cu un număr mai mic de resurse
  * `terraform plan` și`terraform apply` ambele fac apeluri API în cloud pentru a verifica starea resurselor
  * Dacă aveți întreaga infrastructură într-o singură compoziție de infrastructură, acest lucru poate dura ceva timp
* O rază de impact este mai mică, cu mai puține resurse
  * Izolarea resurselor care nu depind unele de altele prin plasarea lor în compoziții separate reduce riscul în cazul în care ceva nu merge bine
* Începeți proiectul folosind remote state deoarece:
  * Laptopul nu este un loc bun pentru stocarea stării infrastructurii
  * Gestionarea unui fișier`tfstate` în git este un coșmar
  * Mai târziu, când straturile de infrastructură vor începe să crească în mai multe direcții (număr de dependențe sau resurse), va fi mai ușor să țineți lucrurile sub control
* Practicați o structură consecventă și o convenție de denumire a resurselor ([naming](naming.md) convention):
  * La fel ca în cazul codului procedural, codul Terraform ar trebui scris pentru ca oamenii să-l citească mai întâi, consecvența va ajuta atunci când vor avea loc schimbări peste șase luni
  * Este posibil să mutați resurse în fișierul de stare Terraform, dar poate fi mai greu de făcut dacă aveți o structură și o denumire inconsecventă
* Păstrați modulele de resurse cât mai simple posibil
* Nu puneți simplu text (hardcoded) valorile care pot fi transmise ca variabile sau descoperite folosind surse de date
* Utilizați surse de date și`terraform_remote_state` în special ca legatură între modulele de infrastructură din cadrul compoziției

În această carte, exemplele de proiecte sunt grupate în funcție de _complexitate_ - de la infrastructuri mici la infrastructuri foarte mari. Această separare nu este strictă, așa că verificați și alte structuri.

### Orchestrarea modulelor și compozițiilor de infrastructură

A avea o infrastructură mică înseamnă că există un număr mic de dependențe și puține resurse. Pe măsură ce proiectul crește, necesitatea de a înlănțui execuția configurațiilor Terraform, conectarea diferitelor module de infrastructură și transmiterea valorilor într-o compoziție, devine evidentă.

Există cel puțin 5 grupuri distincte de soluții de orchestrare pe care dezvoltatorii le folosesc:

1. Doar Terraform. Foarte simplu, dezvoltatorii trebuie să cunoască doar Terraform pentru a duce treaba la bun sfârșit.
2. Terragrunt. Instrument de orchestrare pur, care poate fi folosit pentru a orchestra întreaga infrastructură, precum și pentru a gestiona dependențe. Terragrunt operează cu module de infrastructură și compoziții în mod nativ, astfel încât reduce duplicarea codului.
3. Scripturi interne. Adesea, acest lucru se întâmplă ca punct de plecare către orchestrare și înainte de a descoperi Terragrunt.
4. Instrument de automatizare Ansible sau altceva asemănător. Utilizat de obicei atunci când Terraform este adoptat după Ansible sau când Ansible UI este utilizat în mod activ.
5. [Crossplane](https://crossplane.io/) și alte soluții inspirate de Kubernetes. Uneori, este logic să utilizați ecosistemul Kubernetes și să folosiți o funcție de buclă de reconciliere pentru a obține starea dorită a configurațiilor Terraform. Vizualizați videoclipul [Crossplane vs Terraform](https://www.youtube.com/watch?v=ELhVbSdcqSY) pentru mai multe informații.

Având în vedere acest lucru, această carte trece în revistă primele două dintre aceste structuri de proiect, doar Terraform și Terragrunt.

Vezi exemple de structuri de cod pentru [Terraform](examples/terraform/) sau [Terragrunt](examples/terragrunt.md) în capitolul următor.
