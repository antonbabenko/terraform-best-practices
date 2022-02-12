# Малорозмірна структура із Terraform

Джерело: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

Цей приклад містить код як приклад структурування конфігурацій Terraform для невеликої інфраструктури, де не використовуються зовнішні залежності.

{% hint style="success" %}
* Ідеально підходить для початку та реорганізації у процесі
* Ідеально підходить для невеликих ресурсних модулів
* Добре підходить для невеликих і лінійних інфраструктурних модулів (наприклад, [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis))
* Добре для невеликої кількості ресурсів (менше ніж 20-30)
{% endhint %}

{% hint style="warning" %}
Єдиний файл стану для всіх ресурсів може уповільнити процес роботи з Terraform, якщо кількість ресурсів зростає (подумайте про використання аргументу`-target` щоб обмежити кількість ресурсів)
{% endhint %}
