# Mała infrastruktura z Terraform

Źródło: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

Ten przykład zawiera kod dla strukturyzacji konfiguracji Terraform dla małego rozmiaru infrastruktury, w której nie są używane zależności zewnętrzne.

{% hint style="success" %}
* Idealny na początek i gdy refaktoryzacja na bieżąco jest możliwa
* Idealny do modułów z małymi zasobami
* Dobry dla małych i liniowych modułów infrastruktury (np. [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis))
* Dobry dla małej liczby zasobów (mniej niż 20-30)
{% endhint %}

{% hint style="warning" %}
Plik jednego stanu dla wszystkich zasobów może spowolnić proces pracy z Terraform. Jeśli liczba zasobów rośnie, rozważ użycie argumentu `-target`, aby je ograniczyć.
{% endhint %}
