---
description: PFT (Probleme Frecvente cu Terrafom)
---

# FAQ

## Care sunt instrumentele pe care ar trebui să le cunosc și pe care ar trebui să le folosesc?

* [**Terragrunt**](https://terragrunt.gruntwork.io/) - Instrument de orchestrare
* [**tflint**](https://github.com/terraform-linters/tflint) - Cod linter
* [**tfenv**](https://github.com/tfutils/tfenv) - Manager de versiuni
* [**Atlantis**](https://www.runatlantis.io/) - Automatizare pentru Pull Requests
* [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) - O colecție de git hooks pentru Terraform pentru a fi folosite cu [pre-commit framework](https://pre-commit.com/)

## Ați avut ocazia să răspundeți la întrebarea anterioară?

Da, după câteva luni am găsit în sfârșit răspunsul. Din păcate, Mike este în vacanță acum, așa că mă tem că nu putem oferi răspunsul în acest moment.

## Care sunt soluțiile pentru iadul dependenței - [dependency hell](https://en.wikipedia.org/wiki/Dependency\_hell), cu module?

Ar trebui specificate versiunile modulelor de resurse și infrastructură. Furnizorii de infrastructură (providers) ar trebui configurați în afara modulelor, dar numai în compoziție. Versiunea furnizorilor și  cea a Terraform pot fi, de asemenea, blocate.

Nu există un instrument principal de gestionare a dependenței, dar există câteva sfaturi pentru a face iadul dependenței mai puțin problematic. De exemplu, [Dependabot](https://dependabot.com/) poate fi folosit pentru a automatiza actualizările dependenței. Dependabot creează pull requests pentru a vă menține dependențele în siguranță și actualizate. Dependabot acceptă configurații Terraform.
