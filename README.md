---
description: >-
  الهدف من هذا التوثيق هو توصيف  أفضل الممارسات لاستعمال أداة Terraform وتوفير
  توصيات للتعامل مع المشكلات الأكثر شيوعاً التي يواجهها مستخدمو هذه الأداة.
---

# مرحباً

يعد الـ [Terraform](https://www.terraform.io/)مشروع جديد نسبياً (مثل معظم أدوات الـ DevOps )، صدر في عام 2014.

تعد أداة Terraform قوية (إن لم تكن الأقوى الآن) وواحدة من أكثر الأدوات استعمالاً لتوصيف البنى التحتية المعلوماتية باستعمال الكود (Infrastructure as code). تسمح هذه الأداة للمطورين بالقيام بالكثير من الوظائف ولا تمنعهم من فعل الأشياء بطرق يصعب دعمها أو التواصل معها.

بعض المعلومات في هذا الكتاب قد تبدو وكأنها لا تصنف كأفضل الممارسات. أعلم هذا. ولمساعدة القراء على التفريق بين ما يعد أفضل ممارسة أو ما هو مجرد طريقة أخرى لفعل الأشياء، فإني سأقوم باستعمال التلميحات (hints) في بعض الأحيان وتوفير الأيقونات لتحديد مستوى النضج في كل قسم فرعي يتعلق بأفضل الممارسات.

تم البدء بكتابة هذا الكتاب في مدريد في سنة 2018 وهو متوفر مجاناً على الرابط -

[https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com/)

تم التعديل على هذا الكتاب بعد عدة سنين لإضافة أفضل الممارسات المتوفرة لإصدار Terraform 1.0 ، هذا الكتاب يجب أن يحتوي أفضل الممارسات والتوصيات الغير القابلة للجدل ليتم استعمالها من قبل مستخدمي الـ Terraform

## الترجمات



{% content-ref url="http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/PJbgKPAX0ohEMLpETpg7/" %}
[Bosanski (Bosnian)](http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/PJbgKPAX0ohEMLpETpg7/)
{% endcontent-ref %}

{% content-ref url="http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/" %}
[Português (Brazilian Portuguese)](http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/)
{% endcontent-ref %}

{% content-ref url="http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/e1Mp2scOX6OnQbifCen3/" %}
[English](http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/e1Mp2scOX6OnQbifCen3/)
{% endcontent-ref %}

{% content-ref url="http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/" %}
[Français (French)](http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/)
{% endcontent-ref %}

{% content-ref url="http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/DyguS0uZfMW7X7m9BWx1/" %}
[ქართული (Georgian)](http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/DyguS0uZfMW7X7m9BWx1/)
{% endcontent-ref %}

{% content-ref url="http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/PKopCWJZbhpQ9FT0W8tL/" %}
[Deutsch (German)](http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/PKopCWJZbhpQ9FT0W8tL/)
{% endcontent-ref %}

{% content-ref url="http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/5c1kFpqxaDZC2g9e6rtT/" %}
[ελληνικά (Greek)](http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/5c1kFpqxaDZC2g9e6rtT/)
{% endcontent-ref %}

{% content-ref url="http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/4bq6CyY8vYiEHkjN63rT/" %}
[עברית (Hebrew)](http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/4bq6CyY8vYiEHkjN63rT/)
{% endcontent-ref %}

{% content-ref url="http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/Mgong4S6IjtibE055zUM/" %}
[हिंदी (Hindi)](http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/Mgong4S6IjtibE055zUM/)
{% endcontent-ref %}

{% content-ref url="http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/" %}
[Bahasa Indonesia (Indonesian)](http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/)
{% endcontent-ref %}

{% content-ref url="http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/8VlMHbHDbW6qRWdgN5oU/" %}
[Italiano (Italian)](http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/8VlMHbHDbW6qRWdgN5oU/)
{% endcontent-ref %}

{% content-ref url="http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/BoZVs6O2OJFQLNV1utmm/" %}
[ಕನ್ನಡ (Kannada)](http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/BoZVs6O2OJFQLNV1utmm/)
{% endcontent-ref %}

{% content-ref url="http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/" %}
[Polski (Polish)](http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/)
{% endcontent-ref %}

{% content-ref url="http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/sFM1GW5TPCGsskQ03mTm/" %}
[Română (Romanian)](http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/sFM1GW5TPCGsskQ03mTm/)
{% endcontent-ref %}

{% content-ref url="http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/5VD4NK4mHOY8SWjC9N5e/" %}
[简体中文 (Simplified Chinese)](http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/5VD4NK4mHOY8SWjC9N5e/)
{% endcontent-ref %}

{% content-ref url="http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/" %}
[Español (Spanish)](http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/)
{% endcontent-ref %}

{% content-ref url="http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/Fedpbc5NbKjynXI8xTeF/" %}
[Türkçe (Turkish)](http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/Fedpbc5NbKjynXI8xTeF/)
{% endcontent-ref %}

{% content-ref url="http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/" %}
[Українська (Ukrainian)](http://localhost:5000/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/)
{% endcontent-ref %}





اتصل بي إذا كنت تود المساعدة بالترجمة إلى لغات أخرى

## المساهمات

أرغب دائمًا في الحصول على تعليقات وتحديثات لهذا الكتاب بينما ينضج المجتمع ويتم تنفيذ الأفكار الجديدة والتحقق منها بمرور الوقت.

إذا كنت مهتمًا بموضوعات معينة فالرجاء طرح مشكلتك [open an issue](https://github.com/antonbabenko/terraform-best-practices/issues) أو إبداء الإعجاب بالمشكلة التي تريد تغطيتها أكثر من غيرها. إذا كنت تشعر أن لديك محتوى وتريد المساهمة، فاكتب مسودة وأرسل Pull request (لا تقلق بشأن كتابة نص جيد في هذه المرحلة!)

## المؤلفون

هذا الكتاب من إعداد [Anton Babenko](https://github.com/antonbabenko) بمساعدة مساهمين ومترجمين مختلفين.

## الرعاة

| [<img src=".gitbook/assets/cluster-dev-logo-site.png" alt="" data-size="original">](https://cluster.dev/) | [Cluster.dev](http://cluster.dev/) — the only manager for cloud-native infrastructures. |
| --------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |

## الترخيص

هذا العمل مرخص بموجب ترخيص Apache 2. انظر LICENSE للحصول على التفاصيل الكاملة.

لا يمكن للمؤلفين والمساهمين في هذا المحتوى ضمان صحة المعلومات الموجودة هنا. يرجى التأكد من أنك تفهم أن المعلومات المقدمة هنا يتم توفيرها بحرية ، وأنه لا يوجد أي نوع من الاتفاقية أو العقد بينك وبين أي أشخاص مرتبطين بهذا المحتوى أو المشروع. لا يتحمل المؤلفون والمساهمون ، وبموجب هذا ، أي مسؤولية تجاه أي طرف عن أي خسارة أو ضرر أو اضطراب ناتج عن أخطاء أو سهو في المعلومات الواردة في هذا المحتوى أو المرتبطة به أو المرتبطة به ، سواء كانت هذه الأخطاء أو الإغفالات ناتجة عن إهمال أو حادث أو أي سبب آخر.

حقوق النشر © 2018-2022 Anton Babenko.
