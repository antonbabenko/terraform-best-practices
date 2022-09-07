# Infrastructură de dimensiune mică - Terraform

Sursă: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

Acest exemplu conține un cod ca exemplu de structurare a configuraților Terraform pentru o infrastructură de dimensiuni mici, unde nu există dependențe externe.

{% hint style="success" %}
* Perfect pentru a începe și pentru a edita pe parcurs
* Perfect pentru module cu resurse puține
* Bun pentru module de infrastructură mici si lineare (ex: [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis))
* Bun pentru un număr redus de resurse (mai puține de 20-30)
{% endhint %}

{% hint style="warning" %}
Un singur fișier de stare pentru toate resursele poate face procesul de lucru cu Terraform să încetinească dacă numărul de resurse crește (considerați folosirea unui argument ca  `-target` pentru a limita numărul de resurse).
{% endhint %}
