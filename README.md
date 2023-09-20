---
description: >-
  Bu döküman Terraform aracının en iyi uygulama metodlarını ve Terraform
  kullanıcılarının sık karşılaştığı problemlere yönelik çözüm önerilerini
  sistematik bir şekilde açıklamaktadır.
---

# Hoşgeldiniz...

Çoğu DevOps aracı gibi [Terraform](https://www.terraform.io/) için de oldukça yeni bir proje diyebiliriz. (2014'de kullanıma açıldı.)

Terraform yetenekli, güçlü ve altyapıyı kod ile kontrol etmenize olanak sağlayan en fazla kullanılan araçlardan biridir. Tamamiyle geliştirici dostu, çok fazla operasyonu yapmaya olanak sağladığı gibi yapılan operasyonlarda entegrasyonu sağlayabilmek için kısıtlayıcı şekilde sadece tek bir yol sunmaz. Oldukça esnek bir araçtır.

Bu kitaptaki bazı bilgiler Terraform'un en iyi uygulama metodları gibi görünmeyebilir. Bunu biliyorum ve kullanıcıların neyin en iyi uygulamalar, neyin konu hakkında başka bir bakış açısı olduğunu ayırt etmesi için bazı yerlerde küçük ipuçları, simgeler ve bağlamlar kullandım.

Bu kitap 2018'de bir Madrid yazında yazılmaya başlandı ve  [https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com) adresinden ulaşabilirsiniz.

Sözün özü, bu kitap Terraform kullanıcıları için en iyi uygulama metodlarını ve önerileri içermektedir ve içermelidir.

## Sponsors

Please [contact me](https://github.com/antonbabenko/terraform-aws-devops#social-links) if you want to become a sponsor.

| [![](.gitbook/assets/cast-logo.png)](https://cast.ai/antonbabenko) | [CAST AI](https://cast.ai/antonbabenko) — Cut your Kubernetes costs by 60%+ on average. First cluster optimization FREE! |
| ------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------ |

## Translations

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

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/DyguS0uZfMW7X7m9BWx1/" %}
[ქართული (Georgian)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/DyguS0uZfMW7X7m9BWx1/)
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

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/" %}
[Українська (Ukrainian)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/)
{% endcontent-ref %}

Bu kitabın başka dillere çevirisi için yardım etmek istiyorsanız benle iletişime geçebilirsiniz.

## Katkıda Bulunma

Belirli bir konu hakkında ilgileniyorsanız, işini açabilirsiniz veya açık işi işaretleyerek ön plana çıkarabilirsiniz.

Bir konu hakkında yazacak şeyleriniz olduğunu hissediyorsanız ve bunları paylaşmak istiyorsanız, bir taslak hazırlayıp 'Pull Request' [açabilirsiniz](https://github.com/antonbabenko/terraform-best-practices/issues). (Bu noktada mükemmel bir şekilde yazmayabilirsiniz!)

## Authors

Bu kitap[ Anton Babenko](https://github.com/antonbabenko) tarafından katkı sağlayanlar ve çevirmenlerin yardımıyla düzenlenmektedir.

## Lisans

Bu çalışma Apache 2 Lisans'ı ile lisanslanmıştır. Lisans'ın tüm detaylarını okuyabilirsiniz.

Bu içeriğin yazarları ve katkıda bulunanlar, burada bulunan bilgilerin geçerliliğini garanti edemez. Lütfen burada verilen bilgilerin ücretsiz olarak verildiğini anladığınızdan ve proje ile ilişkili herhangi bir kişi arasında hiçbir tür anlaşma veya sözleşme oluşturulmamış olduğundan emin olabilirsiniz. Yazarlar ve katkıda bulunanlar, bu içerikte yer alan, içerikle ilişkili veya bu içerikten bağlantı verilen bilgilerdeki hata veya eksikliklerden kaynaklanan herhangi bir kayıp, hasar veya kesinti için, bu tür hatalar veya eksikliklerden kaynaklanıp kaynaklanmadığına bakılmaksızın, herhangi bir tarafa herhangi bir sorumluluk kabul etmez ve burada sorumluluk kabul etmez.

Tüm hakları saklıdır © 2018-2023 Anton Babenko.
