---
description: >-
  Гэты дакумент з'яўляецца спробай сістэматычна апісаць найлепшыя практыкі
  выкарыстання Terraform і даць рэкамендацыі па самых распаўсюджаных праблемах,
  з якімі сутыкаюцца карыстальнікі Terraform.
---

# Сардэчна запрашаем

[Terraform](https://www.terraform.io) ёсць магутным (калі не наймагутнейшы на сёння) і адзным з самых распаўсюджаных інструментаў для кіравання інфраструктурай як кодам. Ён дазваляе распрацоўшчыкам выконваць шмат задач і не абмяжоўвае іх у выбары спосабаў, якія потым будзе цяжка падтрымліваць або інтэграваць.

Некаторая інфармацыя, апісаная ў гэтай кнізе, можа здавацца не найлепшымі практыкамі. Я ведаю гэта, і каб дапамагчы чытачам адрозніць усталяваныя найлепшыя практыкі ад простага суб'ектыўнага спосабу зрабіць што-небудзь, я часам выкарыстоўваю падказкі для надання кантэксту і значкі, якія ўказваюць узровень сталасці для кожнага падраздзела, звязанага з найлепшымі практыкамі.

Праца над кнігай распачалася ў сонечным Мадрыдзе ў 2018 годзе, яна даступная бясплатна тут: [https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com).

Праз некалькі гадоў яна была абноўлена даданнем больш актуальных перадавых практык, даступных у Terraform 1.0. Урэшце, гэтая кніга павінна змяшчаць большасць бясспрэчных перадавых практык і рэкамендацый для карыстальнікаў Terraform.

## Спонсары

Калі ласка, [звяжыцеся са мной](https://github.com/antonbabenko/terraform-aws-devops#social-links), калі хочаце стаць спонсарам.

| [![](.gitbook/assets/ctf-logo.png)](https://compliance.tf/?utm_source=tf_best_practices\&utm_medium=sponsorship) | [Compliance.tf](https://compliance.tf/?utm_source=tf_best_practices\&utm_medium=sponsorship) — Terraform Compliance Simplified. Make your Terraform modules compliance-ready. |
| ---------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |

## Translations

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/u3iITRIHQx97ro2PkfdC/" %}
[العربية (Arabic)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/u3iITRIHQx97ro2PkfdC/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/PJbgKPAX0ohEMLpETpg7/" %}
[Bosanski (Bosnian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/PJbgKPAX0ohEMLpETpg7/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/" %}
[Português (Brazilian Portuguese)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/" %}
[Français (French)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/DyguS0uZfMW7X7m9BWx1/" %}
[ქართული (Georgian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/DyguS0uZfMW7X7m9BWx1/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/PKopCWJZbhpQ9FT0W8tL/" %}
[Deutsch (German)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/PKopCWJZbhpQ9FT0W8tL/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/5c1kFpqxaDZC2g9e6rtT/" %}
[ελληνικά (Greek)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/5c1kFpqxaDZC2g9e6rtT/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/4bq6CyY8vYiEHkjN63rT/" %}
[עברית (Hebrew)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/4bq6CyY8vYiEHkjN63rT/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/Mgong4S6IjtibE055zUM/" %}
[हिंदी (Hindi)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/Mgong4S6IjtibE055zUM/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/" %}
[Bahasa Indonesia (Indonesian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/8VlMHbHDbW6qRWdgN5oU/" %}
[Italiano (Italian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/8VlMHbHDbW6qRWdgN5oU/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/3vykLOWgdQLPLgHtxqQH/" %}
[日本語 (Japanese)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/3vykLOWgdQLPLgHtxqQH/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/BoZVs6O2OJFQLNV1utmm/" %}
[ಕನ್ನಡ (Kannada)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/BoZVs6O2OJFQLNV1utmm/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/bJnDvAqIyVgo7LDHgxYJ/" %}
[한국어 (Korean)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/bJnDvAqIyVgo7LDHgxYJ/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/" %}
[Polski (Polish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/sFM1GW5TPCGsskQ03mTm/" %}
[Română (Romanian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/sFM1GW5TPCGsskQ03mTm/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/5VD4NK4mHOY8SWjC9N5e/" %}
[简体中文 (Simplified Chinese)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/5VD4NK4mHOY8SWjC9N5e/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/" %}
[Español (Spanish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/Fedpbc5NbKjynXI8xTeF/" %}
[Türkçe (Turkish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/Fedpbc5NbKjynXI8xTeF/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/" %}
[Українська (Ukrainian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/dcjhau04KQIKHUJA90iN/" %}
[اردو (Urdu)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/dcjhau04KQIKHUJA90iN/)
{% endcontent-ref %}

Звяжыцеся са мной, калі хочаце дапамагчы перакласці гэтую кнігу на іншыя мовы.

## Унёскі

Я заўсёды хачу атрымліваць зваротную сувязь і абнаўляць гэтую кнігу па меры сталення супольнасці, а таксама ўкаранення і праверкі новых ідэй з цягам часу.

Калі вы зацікаўлены ў спецыфічных тэмах, калі ласка [адкрыйце пытанне](https://github.com/antonbabenko/terraform-best-practices/issues), ці вялікі палец дагары на пытанне, якое вы хочаце, каб было разгледжана. Калі вы лічыце, што **ў вас ёсць кантэнт** і хочаце зрабіць унёсак, напішыце чарнавік і адпраўце pull request (не хвалюйцеся на гэтым этапе пра тое, каб тэкст быў добрым!).

## Аўтары

Гэтая кніга падтрымліваецца [Anton Babenko](https://github.com/antonbabenko) з дапамогай розных аўтараў і перакладчыкаў.

## Ліцэнзія

Гэтая праца ліцэнзавана пад ліцэнзіяй Apache 2. Падрабязней гл. у файле LICENSE.

Аўтары і ўкладчыкі не могуць гарантаваць дакладнасць змешчанай тут інфармацыі. Калі ласка, пераканайцеся, што вы разумееце, што прадастаўленая тут інфармацыя прадастаўляецца задарма, і што аніякіх пагадненняў або дамоўленасцей не заключаецца паміж вамі і любымі асобамі, звязанымі з гэтым зместам або праектам. Аўтары і ўкладчыкі не нясуць і гэтым адмаўляюцца ад любой адказнасці перад якой-небудзь асобай за ўсялякія страты, шкоду або збоі, выкліканыя памылкамі ці хібамі ў інфармацыі, якая змяшчаецца ў гэтым матэрыяле, звязанай з ёю або на якую спасылаецца, незалежна ад таго, ці выкліканы такія памылкі ці прапускі нядбайнасцю, здарэннем або любой іншай прычынай.

Copyright © 2018-2023 Anton Babenko.
