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

| [![](.gitbook/assets/ctf-logo.png)](https://compliance.tf/?utm_source=tf_best_practices&utm_medium=sponsorship) | [Compliance.tf](https://compliance.tf/?utm_source=tf_best_practices&utm_medium=sponsorship) — Terraform Compliance Simplified. Make your Terraform modules compliance-ready. |
| --------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [![](.gitbook/assets/)]()                                                                                       | []() —                                                                                                                                                                       |

## თარგმანები

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

{% content-ref url="https://app.gitbook.com/s/dcjhau04KQIKHUJA90iN/" %}
[اردو (Urdu)](https://app.gitbook.com/s/dcjhau04KQIKHUJA90iN/)
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
