# Formatarea codului

{% hint style="info" %}
* Exemplele și modulele Terraform ar trebui să conțină documentație care explică caracteristicile și modul de utilizare a acestora.
* Toate linkurile din fișierele README.md ar trebui să fie absolute pentru ca site-ul Terraform Registry să le arate corect.
* Documentația poate include diagrame create cu [mermaid](https://github.com/mermaid-js/mermaid) și schițe create cu [cloudcraft.co](https://cloudcraft.co).
* Folosiți [Terraform pre-commit hooks](https://github.com/antonbabenko/pre-commit-terraform) to asigurați-vă că codul este valid, formatat corespunzător și documentat automat înainte de a fi salvat în git și revizuit de oameni.
{% endhint %}

## Documentație

### Documentație generată automat

[pre-commit](https://pre-commit.com/) este un cadru (framework) pentru gestionarea și menținerea pre-commit hooks în mai multe limbi. Este scris în Python și este un instrument puternic pentru a face ceva automat pe mașina unui dezvoltator înainte ca acel cod să fie salvat într-un git repository. În mod normal, este folosit pentru a rula linters și pentru a formata cod (vezi [supported hooks](https://pre-commit.com/hooks.html)).

Cu configurații Terraform `pre-commit` poate fi folosit pentru a formata și valida codul, precum și pentru a actualiza documentația.

Verificați [pre-commit-terraform repository](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md) pentru a vă familiariza cu acesta și cu repositories existente (ex.: [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc)) unde acesta este deja folosit.

### terraform-docs

[terraform-docs](https://github.com/segmentio/terraform-docs) este un instrument care generează documentație din modulele Terraform în diverse formate de ieșire. Îl puteți rula manual (fără pre-commit hooks) sau puteți utiliza [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform) pentru a actualiza automat documentația.

@todo: Versiuni ale modulelor de documente, release, acțiuni GH

## Resurse

1. [pre-commit framework homepage](https://pre-commit.com/)
2. [Collection of git hooks for Terraform to be used with pre-commit framework](https://github.com/antonbabenko/pre-commit-terraform)
3. Blog post de [Dean Wilson](https://github.com/deanwilson): [pre-commit hooks and terraform - a safety net for your repositories](https://www.unixdaemon.net/tools/terraform-precommit-hooks/)
