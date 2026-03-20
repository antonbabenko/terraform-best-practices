# Інфраструктура малога памеру з Terraform

Крыніца: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

Гэты прыклад змяшчае код у якасці прыкладу структуравання канфігурацый Terraform для невялікай інфраструктуры, дзе не выкарыстоўваюцца знешнія залежнасці.

{% hint style="success" %}
* Ідэальна для пачатку і рэфактарынгу ў працэсе
* Ідэальна для невялікіх модуляў рэсурсаў
* Падыходзіць для невялікіх і лінейных інфраструктурных модуляў (напрыклад, [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis))
* Падыходзіць для невялікай колькасці рэсурсаў (менш за 20-30)
{% endhint %}

{% hint style="warning" %}
Адзіны файл стану для ўсіх рэсурсаў можа запаволіць працэс працы з Terraform, калі колькасць рэсурсаў расце (разгледзьце магчымасць выкарыстання аргумента `-target` для абмежавання колькасці рэсурсаў)
{% endhint %}
