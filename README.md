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

## Спонсори

Please [contact me](https://github.com/antonbabenko/terraform-aws-devops#social-links) if you want to become a sponsor.

| [![](.gitbook/assets/ctf-logo.png)](https://compliance.tf/?utm_source=tf_best_practices&utm_medium=sponsorship) | [Compliance.tf](https://compliance.tf/?utm_source=tf_best_practices&utm_medium=sponsorship) — Terraform Compliance Simplified. Make your Terraform modules compliance-ready. |
| --------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [![](.gitbook/assets/)]()                                                                                       | []() —                                                                                                                                                                       |

## Переклади

{% content-ref url="https://app.gitbook.com/s/u3iITRIHQx97ro2PkfdC/" %}
[العربية (Arabic)](https://app.gitbook.com/s/u3iITRIHQx97ro2PkfdC/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/PJbgKPAX0ohEMLpETpg7/" %}
[Bosanski (Bosnian)](https://app.gitbook.com/s/PJbgKPAX0ohEMLpETpg7/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/B48qUSNPO2XmkIySLzfr/" %}
[Português (Brazilian Portuguese)](https://app.gitbook.com/s/B48qUSNPO2XmkIySLzfr/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/e1Mp2scOX6OnQbifCen3/" %}
[English](https://app.gitbook.com/s/e1Mp2scOX6OnQbifCen3/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/6shyPtr2KrqW4ANbFXYg/" %}
[Français (French)](https://app.gitbook.com/s/6shyPtr2KrqW4ANbFXYg/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/DyguS0uZfMW7X7m9BWx1/" %}
[ქართული (Georgian)](https://app.gitbook.com/s/DyguS0uZfMW7X7m9BWx1/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/PKopCWJZbhpQ9FT0W8tL/" %}
[Deutsch (German)](https://app.gitbook.com/s/PKopCWJZbhpQ9FT0W8tL/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/5c1kFpqxaDZC2g9e6rtT/" %}
[ελληνικά (Greek)](https://app.gitbook.com/s/5c1kFpqxaDZC2g9e6rtT/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/4bq6CyY8vYiEHkjN63rT/" %}
[עברית (Hebrew)](https://app.gitbook.com/s/4bq6CyY8vYiEHkjN63rT/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/Mgong4S6IjtibE055zUM/" %}
[हिंदी (Hindi)](https://app.gitbook.com/s/Mgong4S6IjtibE055zUM/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/ZLCz7lNWbSJxDGuNOI44/" %}
[Bahasa Indonesia (Indonesian)](https://app.gitbook.com/s/ZLCz7lNWbSJxDGuNOI44/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/8VlMHbHDbW6qRWdgN5oU/" %}
[Italiano (Italian)](https://app.gitbook.com/s/8VlMHbHDbW6qRWdgN5oU/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/3vykLOWgdQLPLgHtxqQH/" %}
[日本語 (Japanese)](https://app.gitbook.com/s/3vykLOWgdQLPLgHtxqQH/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/BoZVs6O2OJFQLNV1utmm/" %}
[ಕನ್ನಡ (Kannada)](https://app.gitbook.com/s/BoZVs6O2OJFQLNV1utmm/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/bJnDvAqIyVgo7LDHgxYJ/" %}
[한국어 (Korean)](https://app.gitbook.com/s/bJnDvAqIyVgo7LDHgxYJ/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/9yChMGbFo2G47Wiow1yY/" %}
[Polski (Polish)](https://app.gitbook.com/s/9yChMGbFo2G47Wiow1yY/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/sFM1GW5TPCGsskQ03mTm/" %}
[Română (Romanian)](https://app.gitbook.com/s/sFM1GW5TPCGsskQ03mTm/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/5VD4NK4mHOY8SWjC9N5e/" %}
[简体中文 (Simplified Chinese)](https://app.gitbook.com/s/5VD4NK4mHOY8SWjC9N5e/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/fTxekzr50pIuGmrPkXUD/" %}
[Español (Spanish)](https://app.gitbook.com/s/fTxekzr50pIuGmrPkXUD/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/Fedpbc5NbKjynXI8xTeF/" %}
[Türkçe (Turkish)](https://app.gitbook.com/s/Fedpbc5NbKjynXI8xTeF/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/dcjhau04KQIKHUJA90iN/" %}
[اردو (Urdu)](https://app.gitbook.com/s/dcjhau04KQIKHUJA90iN/)
{% endcontent-ref %}

Зв’яжіться зі мною, якщо ви хочете допомогти перекласти цю книгу іншими мовами.

## Внески

Я завжди хочу отримувати відгуки та оновлювати цю книгу, коли спільнота росте, а нові ідеї втілюються та перевіряються часом.

Якщо вас цікавлять конкретні теми, будь ласка [open an issue](https://github.com/antonbabenko/terraform-best-practices/issues), або опишіть проблему, яку ви найбільше хочете прояснити. Якщо ви думаєте, **що маєте контент,** і хочете зробити внесок, напишіть чернетку та зробіть Pull Request (не турбуйтеся про написання гарного тексту на цьому етапі!)

## Автори

Ця книга підтримується [Anton Babenko](https://github.com/antonbabenko) за допомогою інших дописувачів і перекладачів.

## Ліцензія

Ця робота ліцензована згідно з Apache 2 License. Дивіться ЛІЦЕНЗІЯ для повної інформації.

Автори та учасники цього контенту не можуть гарантувати достовірність інформації, що міститься тут. Будь ласка, переконайтеся, що ви розумієте, що надана тут інформація надається безкоштовно, і що між вами та будь-якими особами, пов’язаними з цим контентом або проектом, не укладається жодна угода чи контракт. Автори та учасники не приймають і відмовляються від будь-якої відповідальності перед будь-якою стороною за будь-які втрати, пошкодження або порушення, спричинені помилками або упущеннями в інформації з цього контенту, або пов’язані з ним, незалежно від того, чи є ці помилки або упущення внаслідок недбалості, випадково чи за будь-якої іншої причини.

Copyright © 2018-2023 Anton Babenko.
