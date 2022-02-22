# Infrastruktura wielkogabarytowa z Terraform

Źródło: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/large-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/large-terraform)

Ten przykład zawiera kod dla strukturyzacji konfiguracji Terraform dla dużego rozmiaru infrastruktury, która zawiera:

* 2 konta AWS
* 2 regiony
* 2 oddzielne środowiska (`prod` i `stage`, które nic ze sobą nie dzielą). Każde środowisko funkcjonuje na osobnym koncie AWS
* Każde środowisko korzysta z innej wersji gotowego modułu infrastruktury (`alb`) pochodzącego z [Terraform Registry](https://registry.terraform.io)
* Każde środowisko używa tej samej wersji modułów/sieci (`modules/network`) modułu wewnętrznego, ponieważ pochodzi z katalogu lokalnego.

{% hint style="info" %}
W dużych projektach, takich jak przedstawiono tutaj, korzyści z użycia Terragrunt stają się bardzo widoczne. Spójrz na [przykłady kody Terragrunt](../terragrunt.md).
{% endhint %}

{% hint style="success" %}
* Idealny dla projektów, w których infrastruktura jest logicznie odseparowana (osobne konta AWS)
* Dobre, gdy nie ma potrzeby modyfikowania zasobów współdzielonych między kontami AWS (jedno środowisko = jedno konto AWS = jeden plik stanu)
* Dobre, gdy nie ma potrzeby organizowania zmian między środowiskami
* Dobre, gdy zasoby infrastruktury są celowo różne w zależności od środowiska i nie można ich uogólniać (np. niektóre zasoby są nieobecne w jednym środowisku lub w niektórych regionach)
{% endhint %}

{% hint style="warning" %}
W miarę rozwoju projektu coraz trudniej będzie zapewnić wzajemną aktualność tych środowisk. Rozważ użycie modułów infrastruktury (gotowych lub wewnętrznych) do powtarzalnych zadań.
{% endhint %}

##
