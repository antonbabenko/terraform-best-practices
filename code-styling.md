# Stilovi koda

{% hint style="info" %}
* Primjeri Terrafrom modula trebaju sadrzavati dokumentovana objasnjenja mogucnosti i kako ih koristiti.
* Svi linkovi README.md trebaju biti apsulutni da bi ih Terrafrom Registry web stranica prikazivala ispravno
* Dokumentacija moze ukljucivati dijagrame krierane sa [mermaid](https://github.com/mermaid-js/mermaid) i primjere kreirane uz pomoc [cloudcraft.co](https://cloudcraft.co).
* Koristite [Terraform pre-commit hooks](https://github.com/antonbabenko/pre-commit-terraform) kako bi osigurali da je kod validan, pravilno formatiran i automatski dokumentovan prije nego bude dostupan na gitu i pregledan od strane ljudi.
{% endhint %}

## Dokumentacija

### Automatski generisana dokumentacija

[pre-commit](https://pre-commit.com/) je framework za menadzmen i odrzavanje visejezicnih okidaca prije nego se kod nadje na gitu. Napisan je u Python programskom jeziku i to je mocan alat koji vam omogucava da odradite nesto automatski na racunaru programera prije nego je kod postavljen na git repozitoriji. Koristi se za pokretanje automatskih formatera koda (pogledajte [podrzane okidace](https://pre-commit.com/hooks.html)).

Sa Terraform konfiguracijama `pre-commit` se moze korisititi da formatira i validira kod kao i da azurira dokumentaciju.&#x20;

Pogledajte [pre-commit-terraform repository](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md) kako bi se poblize upoznali sa tim, takodjer pogledajte i postojeci repozitoriji [terraform-aws-vpc ](https://github.com/terraform-aws-modules/terraform-aws-vpc)gdje se to i koristi.

### terraform-docs

[terraform-docs](https://github.com/segmentio/terraform-docs) je alat koji vam omogucava generisanje dokumenatacije iz Terrafrom modula u razlicitim izlaznim formatima. Mozete ga pokrenuti rucno bez upotrebe pre-commit okidaca, ili koristeci [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform) da bi se dokumentacija azurirala automatski..

@todo: Document module versions, release, GH actions

## Izvori

1. [pre-commit framework homepage](https://pre-commit.com/)
2. [Collection of git hooks for Terraform to be used with pre-commit framework](https://github.com/antonbabenko/pre-commit-terraform)
3. Blog post - [Dean Wilson](https://github.com/deanwilson): [pre-commit hooks and terraform - a safety net for your repositories](https://www.unixdaemon.net/tools/terraform-precommit-hooks/)
