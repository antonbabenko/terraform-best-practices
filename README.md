---
description: >-
  Бұл құжат Terraform-ды қолданудың үздік тәжірибелерін жүйелі түрде сипаттауға
  және Terraform пайдаланушылары жиі кездесетін мәселелер бойынша ұсыныстар
  беруге жасалған талпыныс.
metaLinks:
  alternates:
    - https://app.gitbook.com/s/e1Mp2scOX6OnQbifCen3/
---

# Қош келдіңіздер...

[Terraform](https://www.terraform.io) инфрақұрылымды код ретінде басқаруға мүмкіндік беретін қуатты (егер қазіргі кездегі ең қуаттысы болмаса) және ең көп қолданылатын құралдардың бірі. Ол әзірлеушілерге көптеген нәрселерді жасауға мүмкіндік береді және оларды қолдау немесе басқа жүйелермен біріктіру қиын болатындай әрекет етуден шектемейді.

Бұл кітапта сипатталған кейбір ақпарат үздік тәжірибе сияқты көрінбеуі мүмкін. Мен мұны білемін, сондықтан оқырмандарға қалыптасқан үздік тәжірибелер мен жай ғана «меніңше дұрыс» делінген субъективті әдістерді ажыратуға көмектесу үшін, кейде контекст беретін кеңестерді және әр бөлімшедегі тәжірибенің жетілу деңгейін көрсететін белгішелерді қолданамын.

Кітап 2018 жылы шуақты Мадридте басталды және оны [https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com) сайтынан тегін оқуға болады.

Бірнеше жылдан кейін ол Terraform 1.0 нұсқасымен қолжетімді болған өзекті үздік тәжірибелермен жаңартылды. Түптеп келгенде, бұл кітап Terraform пайдаланушыларына арналған даусыз үздік тәжірибелер мен ұсыныстардың көпшілігін қамтуы тиіс.

## Демеушілер

Демеуші болғыңыз келсе, маған [хабарласыңыз](https://github.com/antonbabenko/terraform-aws-devops#social-links)

| [![](.gitbook/assets/ctf-logo.png)](https://compliance.tf/?utm_source=tf_best_practices\&utm_medium=sponsorship) | [Compliance.tf](https://compliance.tf/?utm_source=tf_best_practices\&utm_medium=sponsorship) - Terraform сәйкестігі оңайлатылды. Terraform модульдеріңізді сәйкестікке (compliance) дайын етіңіз. |
| ---------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |

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

Бұл кітапты басқа тілдерге аударуға көмектескіңіз келсе, маған хабарласыңыз.

## Үлес қосу

Қауымдастық дамып, уақыт өте келе жаңа идеялар жүзеге асырылып, тексерілген сайын, мен әрқашан кері байланыс алып, бұл кітапты жаңартып отырғым келеді.

Егер сізді нақты тақырыптар қызықтырса, [open an issue](https://github.com/antonbabenko/terraform-best-practices/issues), немесе қамтылғанын қалайтын мәселеге дауыс беріңіз. Егер сізде **дайын мазмұн бар** деп санасаңыз және үлес қосқыңыз келсе, жобасын (draft) жазып, pull request жіберіңіз (бұл кезеңде мәтіннің керемет жазылуына алаңдамаңыз!).

## Авторлар

Бұл кітапты түрлі үлес қосушылар мен аудармашылардың көмегімен [Anton Babenko](https://github.com/antonbabenko) жүргізеді (сүйемелдейді).

## Лицензия

Бұл жұмыс Apache 2 лицензиясы бойынша таратылады. Толық мәліметтерді LICENSE файлынан қараңыз.

&#x20;

Осы мазмұнның авторлары мен үлес қосушылары мұнда табылған ақпараттың жарамдылығына кепілдік бере алмайды. Мұнда ұсынылған ақпараттың тегін берілетінін және сіз бен осы мазмұнға немесе жобаға қатысты кез келген тұлғалардың арасында ешқандай келісім немесе келісімшарт жасалмайтынын түсінетініңізге көз жеткізіңіз. Авторлар мен үлес қосушылар осы мазмұнда қамтылған, онымен байланысты немесе одан сілтеме жасалған ақпараттағы қателер немесе олқылықтар салдарынан кез келген тарапқа келген жоғалту, зақым немесе бұзылу үшін жауапкершілікті өз мойнына алмайды және одан бас тартады; мейли мұндай қателер немесе олқылықтар ұқыпсыздықтан, жазатайым оқиғадан немесе басқа себептерден туындаған болса да.

Copyright © 2018-2023 Anton Babenko.
