---
description: FTP (Cesti Terraform Problemi)
---

# Česta pitanja

## Koje alate bi trebali korisititi ili razmisliti o njihovoj upotrebi?

* [**Terragrunt**](https://terragrunt.gruntwork.io/) - Orkestracijski alat
* [**tflint**](https://github.com/terraform-linters/tflint) - Alat za formatiranje koda
* [**tfenv**](https://github.com/tfutils/tfenv) - Menadzer verzija
* [**Atlantis**](https://www.runatlantis.io/) - Automatizacija zahtijeva za izmjene&#x20;
* [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) - Kolekcija git okidaca za Terraform koji mogu biti koristeni sa [pre-commit framework](https://pre-commit.com/)
* [**Infracost**](https://www.infracost.io) - Procjena troskova infrastrukture za Terraform unutar zahtjeva za izmjenu. Radi sa Terragruntom, Atlantisom i pre-commit-terraform.

## Sta su rjesenja za [pakao zavisnosti](https://en.wikipedia.org/wiki/Dependency\_hell) izmedju modula?

Verzionisanje resursa i infrastrukturnih modula treba biti specificirano. Provajderi trebaju biti konfigurisani izvan modula, ali samo unutar kompozicija. Verzinisanje provajdera i Terrafroma moze takodjer biti zakljucano.

Ne postoji najbolji alat za odrzavanje zavisnosti i njihov menadzment, ali postoje odredjene upute kako napraviti zavisnosti manje problematicnim. Na primjer, [Dependabot](https://dependabot.com/) moze biti koriste za automatizaciju azuriranja zavisnosti. Dependabot zahtjev za izmjenu da bi drzao vase zavisnosti sigurnim i azuiranim. Dependabot podrzava Terraform konfiguracije.
