# नामकरण की परंपरा

## सामान्य सम्मेलन

{% hint style="info" %}
कम से कम इन सम्मेलनों का पालन न करने का कोई कारण नहीं होना चाहिए :)
{% endhint %}

{% hint style="info" %}
सावधान रहें कि वास्तविक क्लाउड संसाधनों में अक्सर अनुमत नामों पर प्रतिबंध होते हैं। उदाहरण के लिए, कुछ संसाधनों में डैश नहीं हो सकते, कुछ में ऊंट-आवरण होना चाहिए। इस पुस्तक में सम्मेलन स्वयं टेराफॉर्म नामों का उल्लेख करते हैं।
{% endhint %}

1. हर जगह - (डैश) के बजाय \_ (अंडरस्कोर) का उपयोग करें (संसाधन नाम, डेटा स्रोत नाम, चर नाम, आउटपुट आदि में)
2. लोअरकेस अक्षरों और संख्याओं का उपयोग करना पसंद करें (भले ही UTF-8 समर्थित हो)।

## संसाधन और डेटा स्रोत तर्क

1. संसाधन नाम में संसाधन प्रकार को न दोहराएं (आंशिक रूप से नहीं, न ही पूरी तरह से):

{% hint style="success" %}
```
`resource "aws_route_table" "public" {}`
```
{% endhint %}

{% hint style="danger" %}
```
`resource "aws_route_table" "public_route_table" {}`
```
{% endhint %}

{% hint style="danger" %}
```
`resource "aws_route_table" "public_aws_route_table" {}`
```
{% endhint %}

1. यदि कोई और वर्णनात्मक और सामान्य नाम उपलब्ध नहीं है, या यदि संसाधन मॉड्यूल इस प्रकार का एकल संसाधन बनाता है, तो संसाधन नाम को इसका नाम दिया जाना चाहिए (eg, in [AWS VPC module](https://github.com/terraform-aws-modules/terraform-aws-vpc) प्रकार का एक ही संसाधन है `aws_nat_gateway` और प्रकार के कई संसाधन type`aws_route_table`, इसलिए `aws_nat_gateway`नाम दिया जाना चाहिए `this` तथा`aws_route_table` अधिक वर्णनात्मक नाम होने चाहिए - जैसे `private`, `public`, `database`).
2. नामों के लिए हमेशा एकवचन संज्ञा का प्रयोग करें।
3. उपयोग - तर्कों के अंदर मूल्यों और उन जगहों पर जहां मूल्य मानव के सामने आ जाएगा (eg, inside DNS name of RDS instance).
4. संसाधन या डेटा स्रोत ब्लॉक के अंदर तर्क count / for\_each को शीर्ष पर पहले तर्क के रूप में शामिल करें और इसके बाद न्यूलाइन द्वारा अलग करें।
5. तर्क `tags` शामिल करें, यदि संसाधन द्वारा समर्थित है, तो अंतिम वास्तविक तर्क के रूप में, यदि आवश्यक हो तो `depends_on` and `lifecycle` के बाद। इन सभी को एक खाली लाइन से अलग किया जाना चाहिए।&#x20;
6. एक तर्क में शर्तों का उपयोग करते समय `count` / `for_each` उपयोग करने के बजाय बूलियन मान पसंद करें `length` या अन्य भाव.

## &#x20;`resource` कोड के उदाहरण

### &#x20;  `count` / `for_each` का उपयोग

{% hint style="success" %}
{% code title="main.tf" %}
```hcl
resource "aws_route_table" "public" {
  count = 2

  vpc_id = "vpc-12345678"
  # ... remaining arguments omitted
}

resource "aws_route_table" "private" {
  for_each = toset(["one", "two"])

  vpc_id = "vpc-12345678"
  # ... remaining arguments omitted
}
```
{% endcode %}
{% endhint %}

{% hint style="danger" %}
{% code title="main.tf" %}
```hcl
resource "aws_route_table" "public" {
  vpc_id = "vpc-12345678"
  count  = 2

  # ... remaining arguments omitted
}
```
{% endcode %}
{% endhint %}

### `tags` का स्थानन

{% hint style="success" %}
{% code title="main.tf" %}
```hcl
resource "aws_nat_gateway" "this" {
  count = 2

  allocation_id = "..."
  subnet_id     = "..."

  tags = {
    Name = "..."
  }

  depends_on = [aws_internet_gateway.this]

  lifecycle {
    create_before_destroy = true
  }
}   
```
{% endcode %}
{% endhint %}

{% hint style="danger" %}
{% code title="main.tf" %}
```hcl
resource "aws_nat_gateway" "this" {
  count = 2

  tags = "..."

  depends_on = [aws_internet_gateway.this]

  lifecycle {
    create_before_destroy = true
  }

  allocation_id = "..."
  subnet_id     = "..."
}
```
{% endcode %}
{% endhint %}

### Conditions in `count`

{% hint style="success" %}
{% code title="outputs.tf" %}
```hcl
resource "aws_nat_gateway" "that" {    # Best
  count = var.create_public_subnets ? 1 : 0
}

resource "aws_nat_gateway" "this" {    # Good
  count = length(var.public_subnets) > 0 ? 1 : 0
}
```
{% endcode %}
{% endhint %}

## चर(Variables)

1. संसाधन मॉड्यूल में पहिया का पुन: आविष्कार न करें: जिस संसाधन के साथ आप काम कर रहे हैं, उसके लिए "तर्क संदर्भ" अनुभाग में परिभाषित चर के लिए नाम, विवरण और डिफ़ॉल्ट मान का उपयोग करें।&#x20;
2. चरों में सत्यापन के लिए समर्थन सीमित है (उदाहरण के लिए अन्य चरों तक नहीं पहुंच सकते हैं या लुकअप नहीं कर सकते हैं)। तदनुसार योजना बनाएं क्योंकि कई मामलों में यह सुविधा बेकार है।&#x20;
3. एक चर नाम में बहुवचन रूप का प्रयोग करें जब प्रकार list(...) or map(...) हो।&#x20;
4. इस तरह एक चर ब्लॉक में आदेश कुंजी:description , type, default, validation.
5. हमेशा सभी चरों पर विवरण शामिल करें, भले ही आपको लगता है कि यह स्पष्ट है (आपको भविष्य में इसकी आवश्यकता होगी)।&#x20;
6. जब तक आपको प्रत्येक कुंजी पर सख्त बाधाओं की आवश्यकता न हो, तब तक साधारण प्रकार(number, string, list(...), map(...), any) कोई भी) विशिष्ट प्रकार जैसे object() का उपयोग करना पसंद करें।&#x20;
7. यदि मानचित्र के सभी तत्वों का एक ही प्रकार (जैसे string) है या इसमें परिवर्तित किया जा सकता है (जैसे संख्या प्रकार को स्ट्रिंग में परिवर्तित किया जा सकता है) तो मानचित्र like map(map(string)) जैसे विशिष्ट प्रकारों का उपयोग करें।&#x20;
8. एक निश्चित गहराई से शुरू होने वाले प्रकार सत्यापन को अक्षम करने के लिए या जब कई प्रकारों का समर्थन किया जाना चाहिए, तो टाइप करें का उपयोग करें।&#x20;
9. मान {} कभी-कभी एक नक्शा होता है लेकिन कभी-कभी एक वस्तु। नक्शा बनाने के लिए tomap(...) का उपयोग करें क्योंकि कोई वस्तु बनाने का कोई तरीका नहीं है।

## उत्पादन

उत्पादन को उसके दायरे के बाहर संगत और समझने योग्य बनाएं (जब कोई उपयोगकर्ता मॉड्यूल का उपयोग कर रहा हो तो यह स्पष्ट होना चाहिए कि यह किस प्रकार और मूल्य का गुण लौटाता है)।

1. आउटपुट का नाम उस संपत्ति का वर्णन करना चाहिए जिसमें यह शामिल है और सामान्य रूप से जितना आप चाहते हैं उससे कम फ्री-फॉर्म होना चाहिए
2. आउटपुट के नाम के लिए अच्छी संरचना दिखती है `{name}_{type}_{attribute}` , जहां:
   1. `{name}` प्रदाता उपसर्ग के बिना संसाधन या डेटा स्रोत का नाम है। `{name}` for `aws_subnet` is `subnet`, for`aws_vpc` it is `vpc`.
   2. `{type}` संसाधन स्रोतों का एक प्रकार है
   3. `{attribute}` आउटपुट द्वारा लौटाई गई एक विशेषता है
   4. [See examples](naming.md#code-examples-of-output).
3. यदि आउटपुट प्रक्षेप कार्यों और कई संसाधनों के साथ एक मान लौटा रहा है, `{name}` and `{type}` जितना संभव हो उतना सामान्य होना चाहिए (`this` as prefix should be omitted). [See example](naming.md#code-examples-of-output).
4. यदि लौटाया गया मान एक सूची है तो उसका बहुवचन नाम होना चाहिए। [See example](naming.md#use-plural-name-if-the-returning-value-is-a-list).
5. हमेशा सभी आउटपुट के लिए विवरण  `description` शामिल करें भले ही आपको लगता है कि यह स्पष्ट है.
6. जब तक आप सभी मॉड्यूल में सभी जगहों पर इस आउटपुट के उपयोग को पूरी तरह से नियंत्रित नहीं करते तब तक संवेदनशील  `sensitive` तर्क सेट करने से बचें।
7. Prefer `try()` (available since Terraform 0.13) over `element(concat(...))` (legacy approach for the version before 0.13)

### कोड के उदाहरण `output`

सुरक्षा समूह की अधिकतम एक आईडी पर लौटें:

{% hint style="success" %}
{% code title="outputs.tf" %}
```hcl
output "security_group_id" {
  description = "The ID of the security group"
  value       = try(aws_security_group.this[0].id, aws_security_group.name_prefix[0].id, "")
}
```
{% endcode %}
{% endhint %}

एक ही प्रकार के कई संसाधन होने पर, इसे आउटपुट के नाम से हटा दिया जाना चाहिए:

{% hint style="danger" %}
{% code title="outputs.tf" %}
```hcl
output "this_security_group_id" {
  description = "The ID of the security group"
  value       = element(concat(coalescelist(aws_security_group.this.*.id, aws_security_group.web.*.id), [""]), 0)
}
```
{% endcode %}
{% endhint %}

### बहुवचन नाम का प्रयोग करें यदि रिटर्निंग मान एक सूची है

{% hint style="success" %}
{% code title="outputs.tf" %}
```hcl
output "rds_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = aws_rds_cluster_instance.this.*.endpoint
}
```
{% endcode %}
{% endhint %}
