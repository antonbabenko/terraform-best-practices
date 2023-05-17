# Struktura koda

Pitanja vezana za strukturu Terrafrom koda su daelko najecsca pitanja unutar zajednice. Takodjer svi se u odredjenom trenutku nadju u sitauaciji da razmisljaju koji je najbolji nacin da najbolje struktruiraju kod za svoj projekat.

## Kako bi trebali organizovati Terrafrom konfiguraciju?

Ovo je jedno od pitanja za koje postoje razlicita rjesenja i tesko je dati univerzalni savjet, pocnimo prvo sa razumijevanje na sta se sve ovo pitanje odnosi.&#x20;

* Kakava je kompleksnost projekta?
  * Broj povezanih resursa
  * Broj Terraform provajdera (pogledati biljesku ispod o "logickim provajderima")
* Koliko cesto se vasa infrastruktura mijenja
  * **Od** jedanput mjesecno/sedmicno/godisnje
  * **Do** kontinuirano (svaki put kada napravite novu izmjenu)
* Inicijatori izmjene koda? Da li dozvoljavate da vas CI server radi azuiranje repozitorija kada se napravi novi artifakt?
  * Samo programeri mogu praviti izmjene unutar repozitorija u kojem cuvamo infrastruktruni kod
  * Svi mogu predloziti izmjenu praveci zahtijev za izmjenom (eng. Pull Request) ukljucuji i automatske zatatke pokrenute od strane CI servera
* Koju deplojmet platformu odnosno servis koristite?&#x20;
  * AWS CodeDeploy, Kubernetes, ili OpenShift zahtijevaju malo drugaciji pristup
* Kako ste grupisali vasa okruzenja?
  * Po okruzenju (produkcijsko, testno), regionu ili projektu

{% hint style="info" %}
_Logicki provajderi rade u potpusnosti unutar logike Terrafroma i vrlo cesto nemaju interakciju sa bilo kojim drugim servisima. Za njih mozemo smatrati da su binarni 0 ili 1. Najcesci logicki provajderi ukljucuju_ [random](https://registry.terraform.io/providers/hashicorp/random/latest/docs), [local](https://registry.terraform.io/providers/hashicorp/local/latest/docs), [terraform](https://www.terraform.io/docs/providers/terraform/index.html), [null](https://registry.terraform.io/providers/hashicorp/null/latest/docs), [time](https://registry.terraform.io/providers/hashicorp/time/latest).
{% endhint %}

## Zapocnite sa organizacijom Terrafrom konfiguracija

Stavljanjem cjelokupnog koda unutar `main.tf` je dobra ideja kada ste na pocetku ili pravite neki jednostavni primjer. U svim drugim slucajevima puno bolja opcija je radvojiti fajlove u nekoliko logickih cjelina kao sto su:

* `main.tf` - poziva module, sadrzi lokalne varijable i izvore podataka da bi se kreirali svi resursi.
* `variables.tf` - sadrzi deklaraciju varijabli koristenih unutar `main.tf`
* `outputs.tf` - sadrzi izlazne podatke za resurse kreirane unutar `main.tf`
* `versions.tf` - sadrzi detalje o verziji Terrafroma i projevajdera

`terraform.tfvars` ne bi trebao biti koristen nigdje osim unutar [kompozija](key-concepts.md#composition).

## Kako da razmisljate o organizaciji Terrafrom strukture

{% hint style="info" %}
Pobrinite se da razumijete kljucne koncepte - [resurs module](key-concepts.md#resource-module), [infrastrukturne module](key-concepts.md#infrastructure-module), i [ckompozicije](key-concepts.md#composition), kao sto su koristene u sljecem primjeru.
{% endhint %}

### Ceste preporuke za organizaciju koda

* Lakse je i brze raditi sa manjim brojem resursa
  * `terraform plan` i `terraform apply` prave API pozive da bi projeverili status resursa
  * Ako imate citavu infrastrukturu unutar jedne kompozicije to moze uzeto dosta vremena
* Ranjivos (u slucaju sigurnosnog incidenta) je manja sa manjim brojem resursa
  * Izolacija ne relevantnih resursa jednih od drugih stavljajuci ih unutar razlicitih kompozicija smanjuje rizik ukoliko nesto krene po zlu&#x20;
* Zapocnite svoj projekat koristeci udaljeno stanje zato sto:
  * Vas laptop nije mjesto na kojem cete cuvati jedinu ispravnu verziju vaze infrastrukture
  * Menadzment `tfstate` fajla unutar git-a je nocna mora
  * Kasnije kada slojevi infrastrukture krenu da rastu u vise smjerova (broj njihovih zavisnosti ili resursa) bit ce lakse drzati stvari pod kontrolom&#x20;
* Vjezbajte konzistentnu strukturu i [konvenciju o imenovanjima](naming.md):
  * Kao i proceduralni kod, Terrafrom kod treba biti pisan kako bi ga u prvom redu bio citljiv rudima, konzistentnost ce pomoci kada krenete da mijenjate vas kod u buducnosti
  * Moguce je pomjerati resurse unutar Terrafrom fajla stanja ali je to dosta teze raditi ukoliko imate ne konzistentnu sturkturu koda i nacin imenovanja.
* Drzite resurs module sto je moguce jednostavnijim
* Nemojte pisati vrijednosti direktno u kodu ukoliko te vrijednosti mogu biti prosljedjene kao varijabile ili mogu biti procitane direktno iz izvora podataka.&#x20;
* Koristite izvor podataka i `terraform_remote_state` kao poveznicu izmedju infrastrukturnih modula i kompozicija.

U ovoj knjizi primjeri su grupisani po kompleksnosti - od manjih prema vecim infrastrukturama. Ovakvo razdvajanje nije striktrno pa svakako provjerite i druge struktrue koda.

### Orkestracija infrastruktrunih modula i kompozicija

Imati malu infrastrukturu znaci imati mali broj zavisnosti i nekoliko resursa. Kako projekat raste, raste i potreba za lancem izvrsavanja Terrafrom konfigracija, spajajci razlicite infrastukturne module i prosljedjujuci vrijednosti unutar kompozicija koje su postale ocigledne.

Postoji najmanje 5 razlicitih grupa orkestracijskih rjesenja koje bi programeri trebalo da koriste:

1. Samo Terraform. Vrlo jednostavno, programer treba da zna samo Terrafrom kako bi zavrsio posao.&#x20;
2. Terragrunt. Cisti orkestracijski alat koji moze biti koristen za orkestraciju citave infrastrukture kao i za brigu o zavisnostima. Terragrunt po prirodi radi sa infrastukturnim modulima i kompozicijama sto smanjuje ponavljanje koda.
3. Vlastite skripte. Cesto se dogadja na pocetku i prije otkrivanja Terragrunt-a
4. Ansibl ili slicni alati automatizacijski alati. Obicno se koristi kada se sa upotrebom Terrafroma krenulo nakon Ansibl-a ili kada se Ansibl UI aktivno kroisti.
5. [Crossplane](https://crossplane.io) i druga rjesenja inspirisana Kubernetesom. Ponekad ima smisla da koristite Kubernetes eko sistem alata da bi postigli zeljeno stanje vase Terrafrom konfiguracije. Pogledati video [Crossplane vs Terraform](https://www.youtube.com/watch?v=ELhVbSdcqSY) za vise informacija.

Sa tim na umu, u ovoj knjizi je napravljen osvrt na prve dvije vrste strukture projekta, samo Terrafrom i Terragrunt.

Pogledajte primjere organizacije koda za [Terraform](examples/terraform/) ili [Terragrunt](examples/terragrunt.md) u sljedecem poglavlju.
