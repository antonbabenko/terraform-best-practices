---
description: >-
  यह दस्तावेज़ टेराफ़ॉर्म का उपयोग करके सर्वोत्तम प्रथाओं का व्यवस्थित रूप से
  वर्णन करने का एक प्रयास है और टेराफ़ॉर्म उपयोगकर्ताओं द्वारा अनुभव की जाने
  वाली सबसे लगातार समस्याओं के लिए सिफारिशें प्रदान
---

# स्वागतम्

[Terraform](https://www.terraform.io) शक्तिशाली है (यदि अभी सबसे शक्तिशाली नहीं है) और सबसे अधिक उपयोग किए जाने वाले उपकरणों में से एक है जो बुनियादी ढांचे के प्रबंधन को कोड के रूप में अनुमति देता है। यह डेवलपर्स को बहुत सी चीजें करने की अनुमति देता है और उन्हें उन चीजों को करने से प्रतिबंधित नहीं करता है जिनका समर्थन करना या एकीकृत करना मुश्किल होगा।

इस पुस्तक में वर्णित कुछ जानकारी सर्वोत्तम प्रथाओं की तरह नहीं लग सकती है। मुझे यह पता है, और पाठकों को स्थापित सर्वोत्तम प्रथाओं को अलग करने में मदद करने के लिए और चीजों को करने का एक और राय वाला तरीका क्या है, मैं कभी-कभी सर्वोत्तम प्रथाओं से संबंधित प्रत्येक उपखंड पर परिपक्वता के स्तर को निर्दिष्ट करने के लिए कुछ संदर्भ और आइकन प्रदान करने के लिए संकेतों का उपयोग करता हूं।

पुस्तक 2018 में सनी मैड्रिड में शुरू की गई थी, यहां मुफ्त में उपलब्ध है

[https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com).

कुछ वर्षों बाद इसे टेराफॉर्म 1.0 के साथ उपलब्ध अधिक वास्तविक सर्वोत्तम प्रथाओं के साथ अद्यतन किया गया है। आखिरकार, इस पुस्तक में टेराफॉर्म उपयोगकर्ताओं के लिए निर्विवाद सर्वोत्तम अभ्यास और अनुशंसाएं शामिल होनी चाहिए।

## Sponsors

Please [contact me](https://github.com/antonbabenko/terraform-aws-devops#social-links) if you want to become a sponsor.

| [![](.gitbook/assets/ctf-logo.png)](https://compliance.tf/?utm_source=tf_best_practices&utm_medium=sponsorship) | [Compliance.tf](https://compliance.tf/?utm_source=tf_best_practices&utm_medium=sponsorship) — Terraform Compliance Simplified. Make your Terraform modules compliance-ready. |
| --------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [![](.gitbook/assets/)]()                                                                                       | []() —                                                                                                                                                                       |

## Translations

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

यदि आप इस पुस्तक का अन्य भाषाओं में अनुवाद करने में सहायता करना चाहते हैं तो मुझसे संपर्क करें।

## योगदान

मैं हमेशा फीडबैक प्राप्त करना चाहता हूं और इस पुस्तक को अपडेट करना चाहता हूं क्योंकि समुदाय परिपक्व होता है और समय के साथ नए विचारों को लागू और सत्यापित किया जाता है।

यदि आप विशिष्ट विषयों में रुचि रखते हैं, तो कृपया [open an issue ](https://github.com/antonbabenko/terraform-best-practices/issues), या उस मुद्दे को स्वीकार करें जिसे आप कवर करना चाहते हैं। यदि आपको लगता है कि आपके पास सामग्री है और आप योगदान देना चाहते हैं, तो एक मसौदा लिखें और एक पुल अनुरोध सबमिट करें (इस समय अच्छा पाठ लिखने की चिंता न करें!)

## लेखकों

इस पुस्तक का रखरखाव [Anton Babenko](https://github.com/antonbabenko) द्वारा विभिन्न योगदानकर्ताओं और अनुवादकों की सहायता से किया जाता है।

## लाइसेंस

यह काम Apache 2 लाइसेंस के तहत लाइसेंस प्राप्त है। पूरी जानकारी के लिए लाइसेंस देखें।&#x20;

इस सामग्री के लेखक और योगदानकर्ता यहां मिली जानकारी की वैधता की गारंटी नहीं दे सकते। कृपया सुनिश्चित करें कि आप समझते हैं कि यहां प्रदान की गई जानकारी स्वतंत्र रूप से प्रदान की जा रही है, और यह कि आपके और इस सामग्री या परियोजना से जुड़े किसी भी व्यक्ति के बीच किसी प्रकार का समझौता या अनुबंध नहीं किया गया है। लेखक और योगदानकर्ता किसी भी पक्ष के लिए किसी भी नुकसान, क्षति, या इस सामग्री से जुड़ी या जुड़ी जानकारी में त्रुटियों या चूक के कारण होने वाले व्यवधान के लिए किसी भी दायित्व को स्वीकार नहीं करते हैं और इससे इनकार करते हैं, चाहे ऐसी त्रुटियां या चूक से परिणाम लापरवाही, दुर्घटना, या कोई अन्य कारण।

Copyright © 2018-2023 Anton Babenko.
