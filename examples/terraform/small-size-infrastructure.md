# टेराफॉर्म के साथ छोटे आकार का बुनियादी ढांचा

Source: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

इस उदाहरण में छोटे आकार के बुनियादी ढांचे के लिए टेराफॉर्म कॉन्फ़िगरेशन की संरचना के उदाहरण के रूप में कोड शामिल है, जहां कोई बाहरी निर्भरता का उपयोग नहीं किया जाता है।

{% hint style="success" %}
* आरंभ करने के लिए बिल्कुल सही और जैसे ही आप जाते हैं रिफैक्टर करें
* &#x20;छोटे संसाधन मॉड्यूल के लिए बिल्कुल सही&#x20;
* छोटे और रैखिक आधारभूत संरचना मॉड्यूल के लिए अच्छा है (eg, [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis))
* संसाधनों की एक छोटी संख्या के लिए अच्छा है (20-30 से कम)
{% endhint %}

{% hint style="warning" %}
यदि संसाधनों की संख्या बढ़ रही है तो सभी संसाधनों के लिए सिंगल स्टेट फाइल टेराफॉर्म के साथ काम करने की प्रक्रिया को धीमा कर सकती है (संसाधनों की संख्या को सीमित करने के लिए एक argument `-target` का उपयोग करने पर विचार करें)&#x20;
{% endhint %}
