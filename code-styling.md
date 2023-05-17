# कोड स्टाइलिंग

{% hint style="info" %}
* उदाहरण और टेराफॉर्म मॉड्यूल में सुविधाओं की व्याख्या करने वाले दस्तावेज और उनका उपयोग कैसे करना चाहिए।&#x20;
* टेराफॉर्म रजिस्ट्री वेबसाइट को सही ढंग से दिखाने के लिए README.md फाइलों के सभी लिंक पूर्ण होने चाहिए।
* &#x20;दस्तावेज़ीकरण में  [mermaid](https://github.com/mermaid-js/mermaid) के साथ बनाए गए आरेख और [cloudcraft.co](https://cloudcraft.co) के साथ बनाए गए ब्लूप्रिंट शामिल हो सकते हैं।
* &#x20;यह सुनिश्चित करने के लिए [Terraform pre-commit hooks](https://github.com/antonbabenko/pre-commit-terraform) का उपयोग करें कि कोड मान्य है, ठीक से स्वरूपित है, और स्वचालित रूप से इसे git में धकेलने और मनुष्यों द्वारा समीक्षा करने से पहले प्रलेखित किया गया है।


{% endhint %}

## प्रलेखन

### स्वचालित रूप से उत्पन्न दस्तावेज

[pre-commit](https://pre-commit.com/) बहु-भाषा प्री-कमिट हुक के प्रबंधन और रखरखाव के लिए एक ढांचा है। यह Python में लिखा गया है और एक गिट रिपॉजिटरी के लिए कोड प्रतिबद्ध होने से पहले एक डेवलपर की मशीन पर स्वचालित रूप से कुछ करने के लिए एक शक्तिशाली उपकरण है। आम तौर पर, इसका उपयोग लिंटर चलाने और कोड को प्रारूपित करने के लिए किया जाता है (see [supported hooks](https://pre-commit.com/hooks.html)).

टेराफॉर्म कॉन्फ़िगरेशन के साथ `pre-commit`  का उपयोग कोड को प्रारूपित करने और मान्य करने के साथ-साथ प्रलेखन को अपडेट करने के लिए किया जा सकता है.&#x20;

इसके साथ खुद को परिचित करने के लिए [pre-commit-terraform repository ](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md)भंडार देखें, और मौजूदा भंडार (उदाहरण के लिए,  [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc))) जहां यह पहले से ही उपयोग किया जाता है।&#x20;

### terraform-docs

[terraform-docs](https://github.com/segmentio/terraform-docs) एक ऐसा उपकरण है जो विभिन्न आउटपुट स्वरूपों में टेराफॉर्म मॉड्यूल से प्रलेखन तैयार करता है। आप इसे मैन्युअल रूप से चला सकते हैं (प्री-कमिट हुक के बिना), or use [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform) दस्तावेज़ को स्वचालित रूप से अपडेट करने के लिए.

@todo: Document module versions, release, GH actions

## साधन

1. [pre-commit framework homepage](https://pre-commit.com/)
2. [Collection of git hooks for Terraform to be used with pre-commit framework](https://github.com/antonbabenko/pre-commit-terraform)
3. Blog post by [Dean Wilson](https://github.com/deanwilson): [pre-commit hooks and terraform - a safety net for your repositories](https://www.unixdaemon.net/tools/terraform-precommit-hooks/)
