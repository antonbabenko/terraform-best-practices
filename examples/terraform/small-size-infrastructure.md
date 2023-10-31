# ٹیرافارم (Terraform) کے ساتھ چھوٹے سائز کا انفراسٹرکچر

**ماخذ:** [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)\
**اس مثال میں  وہ کوڈ شامل ہے جو ایک چھوٹے سائز کی ٹیرا فارم کنفیگریشن کی ساخت کی مثال کے طور پر دیا گیا ہے، جہاں کوئی بیرونی دپندنکئیس**  `dependencies`**استعمال نہیں کیا گیا ہے۔**

{% hint style="success" %}
* **شروع کرنے اور جیسے جیسے آپ آگے بڑھیں ترمیم کرنے کے لیے بہترین ہے۔**
* **چھوٹے پیمانے کے انفراسٹرکچر کے ماڈیولز کے لیے بہترین ہے۔**
* &#x20;**چھوٹے اور لکیری انفراسٹرکچر ماڈیولز کے لیے اچھا ہے (مثال کے طور پر،** [**terraform-aws-**](https://github.com/terraform-aws-modules/terraform-aws-atlantis)[**atlantis**](https://github.com/terraform-aws-modules/terraform-aws-atlantis)**)**
* **چھوٹی تعداد میں** resources **کے لیے اچھا ہے (20-30 سے کم)**
{% endhint %}

{% hint style="warning" %}
\
تمام ریسورسز کے لئے ایک state فائل ٹیرافارم Terraform سے کام کرنے کے طریقے کو دھیما بنا سکتا ہ اگر  ریسورسز کی تعداد بڑھ رہی ہو ( ریسورسز کی تعداد کو محدود کرنے کے لئے ایک ارغومنٹ -target کا استعمال کرنے کو مد نظر میں رکھیں)
{% endhint %}
