---
description: >-
  یہ دستاویز ایک کوشش ہے کہ منظم طریقے سے ٹیرافارم (Terraform) کا استعمال کرتے
  ہوئے بہترین طریقوں کو بیان کیا جائے اور ٹیرافارم کے صارفین کو پیش آنے والے
  اکثر مسائل کے لیے سفارشات فراہم کی جائیں۔
---

# خوش آمدید

ٹیرافارم ([Terraform](https://www.terraform.io/))  ایک طاقتور (اگرچہ اب تک کا سب سے طاقتورٹول نہیں ہے) اور سب سے زیادہ استعمال ہونے والے ٹولز میں سے ایک ہے جو انفراسٹرکچر کو کوڈ (infrastructure as code) کے طور پر منظم کرتا ہے۔ اور یہ ڈویلپرز کو بہت سے کام کرنے کی اجازت دیتا ہے . انہیں ایسی چیزوں کو کرنے سے نہیں  روکتا جن کی حمایت یا انضمام کرنا مشکل ہو گا۔

میں یہ جانتا ہوں،اس کتاب میں بیان کردہ کچھ معلومات بہترین طریقوں کی طرح نہیں ہو سکتی ہیں۔  اور قارئین کو یہ الگ کرنے میں مدد کرنے کے لیے کہ کیا قائم کردہ بہترین طریقے ہیں اور کیا صرف چیزوں کو کرنے کا ایک اور طریقہ ہے، میں کبھی کبھی بہترین طریقوں سے متعلق ہر ذیلی سیکشن پر پختگی کی سطح کو واضح کرنے کے لیے اشارے اور آئیکون (icons) استعمال کرتا ہو ں۔

**کتاب کی ابتدا 2018 میں اسپین کے خوبصورت شہر مدريد میں ہوئی تھی، اور یہ کتاب  مفت میں یہاں سے ڈاؤن لوڈ کی جا سکتی ہے ۔**\
&#x20;[https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com).

چند سالوں بعد، اس میں مزید حقیقی بہترین طریقوں کے ساتھ اپ ڈیٹ کیا گیا ہے جو ٹیرافارم (Terraform) 1.0 کے ساتھ دستیاب ہیں۔ آخر کار، یہ کتاب ٹیرافارم (Terraform) کے صارفین کے لئے ببہترین طریقوں اور تجویزات کا حامل ہونی چاہئے۔                                                                                                                                                      &#x20;

## **سرپرستان(**Sponsors)

Please [contact me](https://github.com/antonbabenko/terraform-aws-devops#social-links) if you want to become a sponsor.

| [![](.gitbook/assets/ctf-logo.png)](https://compliance.tf/?utm_source=tf_best_practices&utm_medium=sponsorship) | [Compliance.tf](https://compliance.tf/?utm_source=tf_best_practices&utm_medium=sponsorship) — Terraform Compliance Simplified. Make your Terraform modules compliance-ready. |
| --------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [![](.gitbook/assets/)]()                                                                                       | []() —                                                                                                                                                                       |

## ترجمہ

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

{% content-ref url="https://app.gitbook.com/s/tXRvMPILxeJaJTM2CsSq/" %}
[Українська (Ukrainian)](https://app.gitbook.com/s/tXRvMPILxeJaJTM2CsSq/)
{% endcontent-ref %}

اگر آپ اس کتاب کو دوسری زبانوں میں ترجمہ کرنے میں مدد کرنا چاہتے ہیں تو [مجھ سے رابطہ کریں](https://github.com/antonbabenko/terraform-aws-devops#social-links)۔

## &#x20;شراکت

\
**میں ہمیشہ اس کتاب کے بارے میں ردعمل حاصل کرنا اور اسے اپ ڈیٹ کرنا چاہتا ہوں کیونکہ کمیونٹی بڑھتی ہے اور نئے خیالات کو نافذ کیا جاتا ہے اور وقت کے ساتھ ساتھ تصدیق کی جاتی ہے** &#x20;

اگر آپ مخصوص موضوعات میں دلچسپی رکھتے ہیں، تو براہ کرم ایک مسئلہ کھولیں ([open an issue](https://github.com/antonbabenko/terraform-best-practices/issues))، یا اس مسئلے کو تھمبز اپ (thumb up) کریں جسے آپ شامل کرنا چاہتے ہیں۔ اگر آپ محسوس کرتے ہیں کہ آپ کے پاس مواد ہے اور آپ حصہ ڈالنا چاہتے ہیں، تو ایک مسودہ لکھیں اور ایک پل ریکویسٹ (pull request) جمع کروائیں (اس وقت اچھا متن لکھنے کے بارے میں فکر نہ کریں!)

## مصنفین

**اس کتاب کی دیکھ بھال**  [**Anton Babenko**](https://github.com/antonbabenko)   **کی طرف سے مختلف معاونین اور ترجمہ کاروں کی مدد سے کی جاتی ہے**&#x20;

## لائسنس

یہ کام Apache 2 لائسنس کے تحت لائسنس یافتہ ہے۔ مکمل تفصیلات کے لیے LICENSE فائل دیکھیں۔\

اس مواد کے مصنفین اور شراکت دار یہاں پائی جانے والی معلومات کی صحت کی ضمانت نہیں دے سکتے۔ براہ کرم یقینی بنائیں کہ آپ سمجھتے ہیں کہ یہاں فراہم کردہ معلومات آزادانہ طور پر فراہم کی جا رہی ہے، اور آپ اور اس مواد یا منصوبے سے وابستہ کسی بھی شخص کے درمیان کسی بھی قسم کا معاہدہ یا کنٹریکٹ نہیں بنایا گیا ہے۔ مصنفین اور شراکت دار اس مواد میں موجود معلومات میں کسی غلطی یا کمی کی وجہ سے ہونے والے کسی نقصان، نقصان، یا خرابی کے لیے کسی فریق کے سامنے کوئی ذمہ داری نہیں لیتے ہیں، خواہ وہ غلطیاں یا کمیاں غفلت، حادثہ، یا کسی اور وجہ سے ہو ں۔  \
\
کاپی رائٹ © 2018-2023 Anton Babenko
