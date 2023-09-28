---
description: >-
  ეს დოკუმენტი არის მცდელობა სისტემატიურად აღიწეროს Terraform-ის გამოყენების
  საუკეთესო პრაქტიკები და მოგაწოდოთ მითითებები ყველაზე გავრცელებულ პრობლემებზე,
  რომლებსაც აწყდებიან Terraform-ის მომხმარებლები.
---

# მოგესალმებით!

[Terraform](https://www.terraform.io) არის ერთერთი ძლიერი (თუ არა დღესდღეისობით ყველაზე ძლიერი) და ერთერთი ყველაზე ხშირად გამოყენებადი ხელსაწყო რომელიც გაძლევთ საშუალებას მართოთ ინფრასტრუქტურა როგორც კოდი (IaC). ის საშუალებას გაძლევთ შექმნათ სხვადასხვა რესურსები და არ ზღუდავს მათ ინტეგრაციასა და მხარდაჭერაში.&#x20;

ამ წიგნში აღწერილი ზოგიერთი ინფორმაცია შეიძლება არ ჩანდეს საუკეთესო პრაქტიკად. მე ვიცი ეს, ვეხმარები მკითხველს გამიჯნოს თუ რა არის საუკეთესო პრაქტიკა და რა არის კიდევ ერთი გზა ამის გამეორებისა.

ამ წიგნის შექმნა დაიწყო მზიან მადრიდში 2018 წელს და ის ხელმისაწვდომია შემდეგ მისამართზე: [https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com).

წლების შემდეგ ის განახლდა უფრო აქტუალური პრაქტიკები რომლებიც ხელმისაწვდომი გახდა Terraform 1.0-ის შემდეგ. საბოლოოდ, ეს წიგნი შეიცავს უდაოდ ყველაზე საუკეთესო პრაქტიკებსა და რეკომენდაციებს Terraform-ის მომხმარებლებისათვის.

## სპონსორები

Please [contact me](https://github.com/antonbabenko/terraform-aws-devops#social-links) if you want to become a sponsor.

| [![](.gitbook/assets/cast-logo.png)](https://cast.ai/antonbabenko)                                                             | [CAST AI](https://cast.ai/antonbabenko) — Cut your Kubernetes costs by 60%+ on average. First cluster optimization FREE!                                                            |
| ------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [![](.gitbook/assets/speakeasy-logo.png)](https://speakeasyapi.dev?utm_source=tf_best_practices&utm_medium=github+sponsorship) | [Speakeasy](https://speakeasyapi.dev?utm_source=tf_best_practices&utm_medium=github+sponsorship) — Terraform Providers, SDKs and docs for your API. Make your API enterprise-ready! |

## თარგმანები

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/u3iITRIHQx97ro2PkfdC/" %}
[العربية (Arabic)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/u3iITRIHQx97ro2PkfdC/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/PJbgKPAX0ohEMLpETpg7/" %}
[Bosanski (Bosnian)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/PJbgKPAX0ohEMLpETpg7/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/" %}
[Português (Brazilian Portuguese)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/e1Mp2scOX6OnQbifCen3/" %}
[English](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/e1Mp2scOX6OnQbifCen3/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/" %}
[Français (French)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/PKopCWJZbhpQ9FT0W8tL/" %}
[Deutsch (German)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/PKopCWJZbhpQ9FT0W8tL/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/5c1kFpqxaDZC2g9e6rtT/" %}
[ελληνικά (Greek)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/5c1kFpqxaDZC2g9e6rtT/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/4bq6CyY8vYiEHkjN63rT/" %}
[עברית (Hebrew)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/4bq6CyY8vYiEHkjN63rT/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/Mgong4S6IjtibE055zUM/" %}
[हिंदी (Hindi)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/Mgong4S6IjtibE055zUM/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/" %}
[Bahasa Indonesia (Indonesian)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/8VlMHbHDbW6qRWdgN5oU/" %}
[Italiano (Italian)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/8VlMHbHDbW6qRWdgN5oU/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/BoZVs6O2OJFQLNV1utmm/" %}
[ಕನ್ನಡ (Kannada)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/BoZVs6O2OJFQLNV1utmm/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/" %}
[Polski (Polish)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/sFM1GW5TPCGsskQ03mTm/" %}
[Română (Romanian)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/sFM1GW5TPCGsskQ03mTm/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/5VD4NK4mHOY8SWjC9N5e/" %}
[简体中文 (Simplified Chinese)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/5VD4NK4mHOY8SWjC9N5e/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/" %}
[Español (Spanish)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/Fedpbc5NbKjynXI8xTeF/" %}
[Türkçe (Turkish)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/Fedpbc5NbKjynXI8xTeF/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/" %}
[Українська (Ukrainian)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/)
{% endcontent-ref %}

დამეკონტაქტეთ თუ გსურთ დახმარება გამიწიოთ ამ წიგნის თარგმნაში სხვა ენაზე.

## კონტრიბუცია

მსურს ყოველთვის მივიღო უკუკავშირი და ახალი იდეები საზოგადოებისგან რაც მომცემს საშუალებას განვაახლო წიგნი დროდადრო.

თუ დაინტერესებული ხართ კონკრეტული საკითხებით, გახსენით ან მონიშნეთ [issue](https://github.com/antonbabenko/terraform-best-practices/issues), რომელიც გსურთ რომ უფრო დეტალურად იქნას განხილული. თუ გაქვთ კონტექნი კონკრეტული მიმართულებით რომელიც გსურთ რომ გააზიაროთ, დაწერეთ და გააკეთეთ pull-request (ამ ეტაპზე არ არის აუცილებელი იდეალურად დაწერილი ტექსტი გქონდეთ).

## ავტორები

ეს წიგნი შექმნილია[ ანტონ ბაბენკოს](https://github.com/antonbabenko), სხვადასხვა კონტრიბუტორებისა და მთარგმნელების მიერ.

## ლიცენზია

ეს ნამუშევარი გახლავთ Apache 2 License-ის ქვეშ. იხილეთ LICENSE მეტი ინფორმაციისთვის.

ამ წიგნში მოცემულ ინფორმაციის ვალიდურობაზე მისი ავტორები და კონტრიბუტორები ვერ მოგცემენ გარანტიას. გთხოვთ გაითვალისწინოთ რომ, ამ წიგნში მოყვანილი ინფორმაციას ვრცელდება უფასოდ, არანაირი ხელშეკრულება ან კონტრაქტი არ არსებობს თქვენსა და ამ კონტენტთან/პროექტთან ნებისმიერ ასოცირებულ პირს შორის.ავტორები და კონტრიბუტორები არ იღებენ და ამით უარს აცხადებენ პასუხისმგებლობაზე რომელიმე მხარის წინაშე ნებისმიერი დანაკარგის, დაზიანების ან შეფერხების გამო, რომელიც გამოწვეულია ამ კონტენტში შემავალ, ასოცირებულ ან დაკავშირებულ ინფორმაციაში შეცდომით ან უმოქმედობით, მიუხედავად იმისა, ასეთი შეცდომები ან გამოტოვებები გამოწვეულია დაუდევრობისა, უბედური შემთხვების ან სხვა მიზეზით.

Copyright © 2018-2022 ანტონ ბაბენკო.
