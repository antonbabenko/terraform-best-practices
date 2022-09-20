---
description: >-
  Цей документ - спроба систематично описати найкращі методи використання
  Terraform та надати рекомендації щодо найбільш частих проблем, які виникають у
  його користувачів.
---

# Ласкаво просимо

[Terraform](https://www.terraform.io) - це досить новий проект (як і більшість інструментів DevOps), який було розпочато у 2014 році.

Terraform є одним із найпотужніших і найбільш використовуваних на даний момент інтрументів, які дозволяють керувати інфраструктурою як кодом. Це дозволяє розробникам робити багато речей і не обмежує їх у створенні того, що, можливо, буде важко підтримувати або інтегрувати.

Деяка інформація, описана в цій книзі, на перший погляд може здатися не найкращою практикою. Я знаю це, і, щоб допомогти читачам відокремити, що є загальноприйнятими найкращими практиками, а що - просто додатковим упевненим способом робити речі, я іноді використовую підказки, щоб надати деякий контекст, а також піктограми, щоб визначити рівень відповідності найкращим практикам.

Книга вийшла в сонячному Мадриді у 2018 році і доступна безкоштовно за цим посиланням - [https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com)

Кілька років потому вона була оновлена більш актуальними передовими методами, доступними з Terraform 1.0. Зрештою, ця книга має містити більшість незаперечних найкращих практик та рекомендацій для користувачів Terraform.

## Переклади

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/e1Mp2scOX6OnQbifCen3/" %}
[English](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/e1Mp2scOX6OnQbifCen3/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/" %}
[Español (Spanish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/" %}
[Bahasa Indonesia (Indonesian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/" %}
[Français (French)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/PKopCWJZbhpQ9FT0W8tL/" %}
[Deutsch (German)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/PKopCWJZbhpQ9FT0W8tL/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/4bq6CyY8vYiEHkjN63rT/" %}
[עברית (Hebrew)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/4bq6CyY8vYiEHkjN63rT/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/8VlMHbHDbW6qRWdgN5oU/" %}
[Italiano (Italian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/8VlMHbHDbW6qRWdgN5oU/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/" %}
[Português (Brazilian Portuguese)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/" %}
[Polski (Polish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/sFM1GW5TPCGsskQ03mTm/" %}
[Română (Romanian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/sFM1GW5TPCGsskQ03mTm/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/Fedpbc5NbKjynXI8xTeF/" %}
[Türkçe (Turkish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/Fedpbc5NbKjynXI8xTeF/)
{% endcontent-ref %}

Зв’яжіться зі мною, якщо ви хочете допомогти перекласти цю книгу іншими мовами.

## Внески

Я завжди хочу отримувати відгуки та оновлювати цю книгу, коли спільнота росте, а нові ідеї втілюються та перевіряються часом.

Якщо вас цікавлять конкретні теми, будь ласка [open an issue](https://github.com/antonbabenko/terraform-best-practices/issues), або опишіть проблему, яку ви найбільше хочете прояснити. Якщо ви думаєте, **що маєте контент,** і хочете зробити внесок, напишіть чернетку та зробіть Pull Request (не турбуйтеся про написання гарного тексту на цьому етапі!)

## Автори

Ця книга підтримується [Anton Babenko](https://github.com/antonbabenko) за допомогою інших дописувачів і перекладачів.

## Спонсори

| [![](.gitbook/assets/cluster-dev-logo-site.png)](https://cluster.dev) | [Cluster.dev](http://cluster.dev) — єдиний менеджер для хмарних інфраструктур.                           |
| --------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| [![](.gitbook/assets/coder-logo-for-sponsor.png)](http://coder.com/)  | [Coder.com](http://coder.com/) — create remote development machines for your team, powered by Terraform. |

## Ліцензія

Ця робота ліцензована згідно з Apache 2 License. Дивіться ЛІЦЕНЗІЯ для повної інформації.

Автори та учасники цього контенту не можуть гарантувати достовірність інформації, що міститься тут. Будь ласка, переконайтеся, що ви розумієте, що надана тут інформація надається безкоштовно, і що між вами та будь-якими особами, пов’язаними з цим контентом або проектом, не укладається жодна угода чи контракт. Автори та учасники не приймають і відмовляються від будь-якої відповідальності перед будь-якою стороною за будь-які втрати, пошкодження або порушення, спричинені помилками або упущеннями в інформації з цього контенту, або пов’язані з ним, незалежно від того, чи є ці помилки або упущення внаслідок недбалості, випадково чи за будь-якої іншої причини.

Copyright © 2018-2022 Anton Babenko.
