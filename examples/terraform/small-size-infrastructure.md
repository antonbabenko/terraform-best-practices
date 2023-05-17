# Kreiranje manjih infrastruktura uz pomoc Terraforma

Izvor: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

Ovaj primjer sadrzi kod koji je primjer organizacije Terrafrom konfiguracije za male infrastrukture bez vanjskih zavisnosti.

{% hint style="success" %}
* Idealan za pocetak i izmjene u hodu
* Idealan za male resurs module
* Dobar za male i linearne infrastrukturne module (npr: [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis))
* Dobar za mali broj resursa (manje od 20-30)
{% endhint %}

{% hint style="warning" %}
Jedan fajl stanja za sve resurse moze uciniti proces rada sa Terrafromom sporim ukoliko broj resursa poraste (razmislite o upotrebi argumenta -target da bi ogranicili broj resursa)
{% endhint %}
