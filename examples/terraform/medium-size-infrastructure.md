# Kreiranje infrastrukture srednje velicine uz pomoc Terraforma

Izvor: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform)

Ovaj primjer sadrzi kod koji je primjer organizacije Terrafrom konfiguracije za infrastrukture srednje velicine, u ovom primjeru se koriste:

* 2 AWS racuna
* 2 odvojena okruzenja (`produkcijsko` and `testno`). Svako okruzenje je smjesteno unutar posebnog AWS racuna i nemaju dodairnih tacaka.
* Svako okruzenje koristi razlicitu verziju infrastrukturnog modula (`alb`) preuzetog sa [Terraform Registry-a](https://registry.terraform.io/)
* Svako okruzenje koristi istu verziju internog modula `modules/network` posto je taj modul preuzet iz lokalnog direktorija.

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
