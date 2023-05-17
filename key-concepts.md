# मुख्य अवधारणाएं

आधिकारिक टेराफॉर्म दस्तावेज़ीकरण विवरण में कॉन्फ़िगरेशन के सभी पहलुओं का वर्णन करता है। इस सेक्शन के बाकी हिस्सों को समझने के लिए इसे ध्यान से पढ़ें।&#x20;

यह खंड उन प्रमुख अवधारणाओं का वर्णन करता है जिनका उपयोग पुस्तक के अंदर किया जाता है।

## संसाधन&#x20;

संसाधन aws\_vpc, aws\_db\_instance, आदि है, एक संसाधन एक प्रदाता से संबंधित है, तर्कों को स्वीकार करता है, विशेषताओं को आउटपुट करता है, और उसका जीवन चक्र होता है। संसाधन बनाया जा सकता है, पुनर्प्राप्त किया जा सकता है, अपडेट किया जा सकता है और हटाया जा सकता है।

## संसाधन मॉड्यूल

संसाधन मॉड्यूल कनेक्टेड संसाधनों का एक संग्रह है जो एक साथ सामान्य क्रिया करता है (for e.g., [AWS VPC Terraform module](https://github.com/terraform-aws-modules/terraform-aws-vpc/) creates VPC, subnets, NAT gateway, etc).यह प्रदाता कॉन्फ़िगरेशन पर निर्भर करता है, जिसे इसमें परिभाषित किया जा सकता है, या उच्च-स्तरीय संरचनाओं (e.g., in infrastructure module).

## इंफ्रास्ट्रक्चर मॉड्यूल

एक इंफ्रास्ट्रक्चर मॉड्यूल संसाधन मॉड्यूल का एक संग्रह है, जिसे तार्किक रूप से कनेक्ट नहीं किया जा सकता है, लेकिन वर्तमान स्थिति/प्रोजेक्ट/सेटअप में एक ही उद्देश्य पूरा होता है। यह प्रदाताओं के लिए कॉन्फ़िगरेशन को परिभाषित करता है, जो डाउनस्ट्रीम संसाधन मॉड्यूल और संसाधनों को पास किया जाता है। यह आमतौर पर एक इकाई प्रति लॉजिकल सेपरेटर (जैसे, AWS क्षेत्र, Google प्रोजेक्ट) में काम करने तक सीमित होता है।

For example, [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis/) मॉड्यूल जैसे संसाधन मॉड्यूल का उपयोग करता है [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc/) and [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group/) चलाने के लिए आवश्यक बुनियादी ढांचे का प्रबंधन करने के लिए [Atlantis](https://www.runatlantis.io) on [AWS Fargate](https://aws.amazon.com/fargate/).

एक और उदाहरण [terraform-aws-cloudquery](https://github.com/cloudquery/terraform-aws-cloudquery) मॉड्यूल जहां द्वारा कई मॉड्यूल [terraform-aws-modules](https://github.com/terraform-aws-modules/) बुनियादी ढांचे के प्रबंधन के साथ-साथ डॉकर छवियों को बनाने, धक्का देने और तैनात करने के लिए डॉकर संसाधनों का उपयोग करने के लिए एक साथ उपयोग किया जा रहा है। ऑल इन वन सेट।

## संरचना

संरचना बुनियादी ढांचे के मॉड्यूल का एक संग्रह है, जो कई तार्किक रूप से अलग क्षेत्रों (जैसे, AWS क्षेत्र, कई AWS खातों) में फैला हो सकता है। संरचना का उपयोग पूरे संगठन या परियोजना के लिए आवश्यक संपूर्ण बुनियादी ढांचे का वर्णन करने के लिए किया जाता है।&#x20;

एक रचना में बुनियादी ढांचे के मॉड्यूल शामिल होते हैं, जिसमें संसाधन मॉड्यूल शामिल होते हैं, जो व्यक्तिगत संसाधनों को लागू करते हैं।

![Simple infrastructure composition](.gitbook/assets/composition-1.png)

## डेटा स्त्रोत

डेटा स्रोत केवल पढ़ने के लिए ऑपरेशन करता है और प्रदाता कॉन्फ़िगरेशन पर निर्भर होता है, इसका उपयोग संसाधन मॉड्यूल और इन्फ्रास्ट्रक्चर मॉड्यूल में किया जाता है।&#x20;

डेटा स्रोत terraform\_remote\_state उच्च-स्तरीय मॉड्यूल और रचनाओं के लिए एक गोंद के रूप में कार्य करता है।

The [external](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data\_source) डेटा स्रोत एक बाहरी प्रोग्राम को डेटा स्रोत के रूप में कार्य करने की अनुमति देता है, जो टेराफ़ॉर्म कॉन्फ़िगरेशन में कहीं और उपयोग के लिए मनमाने ढंग से डेटा को उजागर करता है.यहां से एक उदाहरण दिया गया है [terraform-aws-lambda module](https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/258e82b50adc451f51544a2b57fd1f6f8f4a61e4/package.tf#L5-L7) जहां बाहरी पायथन स्क्रिप्ट को कॉल करके फ़ाइल नाम की गणना की जाती है।

The [http](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) डेटा स्रोत दिए गए URL पर एक HTTP GET अनुरोध करता है और प्रतिक्रिया के बारे में जानकारी निर्यात करता है जो अक्सर उन एंडपॉइंट्स से जानकारी प्राप्त करने के लिए उपयोगी होता है जहां एक देशी टेराफ़ॉर्म प्रदाता मौजूद नहीं है।

## रिमोट स्टेट

इन्फ्रास्ट्रक्चर मॉड्यूल और रचनाओं को अपना बना रहना चाहिए [Terraform state](https://www.terraform.io/docs/language/state/index.html) एक दूरस्थ स्थान पर जहां इसे दूसरों द्वारा नियंत्रित तरीके से पुनर्प्राप्त किया जा सकता है (e.g., specify ACL, versioning, logging).

## प्रदाता, प्रोविजनर, आदि

आधिकारिक दस्तावेज़ीकरण में प्रदाता, प्रोविजनर और कुछ अन्य शर्तें बहुत अच्छी तरह से वर्णित हैं और यहां इसे दोहराने का कोई मतलब नहीं है। मेरी राय में, अच्छे टेराफॉर्म मॉड्यूल लिखने से उनका कोई लेना-देना नहीं है।

## इतना मुश्किल क्यों है?

जबकि व्यक्तिगत संसाधन बुनियादी ढांचे में परमाणुओं की तरह होते हैं, संसाधन मॉड्यूल अणु (परमाणुओं से युक्त) होते हैं। एक मॉड्यूल सबसे छोटी संस्करण वाली और साझा करने योग्य इकाई है। इसमें तर्कों की एक सटीक सूची है, ऐसी इकाई के लिए आवश्यक फ़ंक्शन करने के लिए मूल तर्क लागू करें। e.g., [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group) module creates `aws_security_group` and `aws_security_group_rule` resources based on input. इन्फ्रास्ट्रक्चर मॉड्यूल बनाने के लिए अपने आप में इस संसाधन मॉड्यूल का उपयोग अन्य मॉड्यूल के साथ किया जा सकता है।

मॉड्यूल के आउटपुट और डेटा स्रोतों का उपयोग करके अणुओं (संसाधन मॉड्यूल और अवसंरचना मॉड्यूल) में डेटा तक पहुंच की जाती है।

रचनाओं के बीच पहुंच अक्सर रिमोट स्टेट डेटा स्रोतों का उपयोग करके की जाती है। There are [multiple ways to share data between configurations](https://www.terraform.io/docs/language/state/remote-state-data.html#alternative-ways-to-share-data-between-configurations).

छद्म संबंधों में ऊपर वर्णित अवधारणाओं को डालते समय यह इस तरह दिख सकता है:

```
composition-1 {
  infrastructure-module-1 {
    data-source-1 => d1

    resource-module-1 {
      data-source-2 => d2
      resource-1 (d1, d2)
      resource-2 (d2)
    }

    resource-module-2 {
      data-source-3 => d3
      resource-3 (d1, d3)
      resource-4 (d3)
    }
  }
}
```
