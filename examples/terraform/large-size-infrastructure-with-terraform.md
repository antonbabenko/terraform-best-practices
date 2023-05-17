# Kreiranje velike infrastrukture uz pomoc Terraforma

Source: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/large-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/large-terraform)

Ovaj primjer sadrzi kod koji je primjer organizacije Terrafrom konfiguracije za vece infrastrukture, u primjeru se koriste:

* 2 AWS racuna
* 2 regiona
* 2 odvojena okruzenja (`produkcijsko` and `testno`). Svako okruzenje je smjesteno unutar posebnog AWS racuna i resursi se prostiru izmedju 2 regije.
* Svako okruzenje koristi razlicitu verziju infrastrukturnog modula (`alb`) preuzetog sa [Terraform Registry-a](https://registry.terraform.io/)
* Svako okruzenje koristi istu verziju internog modula `modules/network` posto je taj modul preuzet iz lokalnog direktorija.

{% hint style="info" %}
U velikim projektima kao sto je opisano ovdje prednosti koristenja Terragrunta postaju ocigledne. Pogledajte [Primjeri organizacije koda sa Terragruntom](../terragrunt.md).
{% endhint %}

{% hint style="success" %}
* Idealan za projekte gdje je infrastruktura logicki razdvojena (radvojeni AWS racuni)&#x20;
* Dobar kada nema potrebe da mijenjate resurse koji su dijeljeni izmedju AWS racuna (jedno okruzenje = jedan AWS racun = jedan Terraform fajl stanja)
* Dobar kada nema potrebe za orkestracijom izmjena izmedju okruzenja
* Dobar kada su resursi infrastrukture u razilicitim okruzenjima sa svrhom i kada se ne mogu generalizovati (npr: neki resursi se ne koriste u jednom od okruzenja ili u nekom od regiona)
{% endhint %}

{% hint style="warning" %}
Kako projekat raste, bit ce teze odrzati ova okruzenja u azuriranom stanju. Razmislite o upotrebi infrastruktrurnih modula za zadatke koji se ponavljaju.
{% endhint %}

##
