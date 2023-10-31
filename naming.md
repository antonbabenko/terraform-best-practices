# نامزدگی کے اصول

## **متفقہ اصول**

{% hint style="info" %}
کم از کم ان کنونشنز پر عمل نہ کرنے کی کوئی وجہ نہیں ہونی چاہیے۔
{% endhint %}

{% hint style="info" %}
یہ احتیاط کریں کہ حقیقی کلاؤڈ ریسورس کو مخصوص ناموں میں پابندیوں کی عادت ہوتی ہے۔ کچھ ریسورس میں ڈیشز شامل نہیں ہوسکتے ہیں، کچھ کو کیمل کیس کی ضرورت ہوتی ہے۔ اس کتاب میں روایات ٹیرافارم **ناموں کو اشارہ کرتی ہیں۔**
{% endhint %}

1. ہر جگہ - (ڈیش) کی بجائے \_ (انڈرسکور) کا استعمال کریں (ریسورس کے ناموں، ڈیٹا سورس کے ناموں، وہرہبلیس کے ناموں، outputs وغیرہ میں)
2. &#x20;بہتر ہے کہ چھوٹے حرف اور اعداد کا استعمال کریں (حتی کہ یو ٹی ایف-8 کا استعمال ہو)۔

## ریسورس (Resource) اور ڈیٹا سورس(data source) کے دلائل

1. ریسورس(Resource) کے نام میں ریسورس  (Resource) کی قسم کو دوہرانے سے بچیں (جزوی طور پر نہیں، مکمل طور پر نہیں)

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

1. اگر کوئی زیادہ وضاحتی اور عام نام دستیاب نہیں ہے، یا اگر ریسورس کا ماڈیول اس قسم کا ایک واحد ریسورس تخلیق کرتا ہے، تو ریسورس کا نام اس طرح رکھا جانا چاہیے۔ (مثال کے طور پر، AWS VPC ماڈیول میں aws\_nat\_gateway کی قسم کا ایک واحد ریسورس ہے اور aws\_route\_table کی قسم کے متعدد ریسورس ہیں، اس لیے aws\_nat\_gateway کا نام اس طرح رکھا جانا چاہیے اور aws\_route\_table کے پاس زیادہ وضاحتی نام ہونے چاہئیں - جیسے `private`، `public`، ڈیٹا بیس)۔
2. ناموں کے لیے ہمیشہ واحد اسم استعمال کریں
3. دلائل کو بیان کرتےوقت اور ان جگہوں پر - استعمال کریں جہاںvalue کسی انسان کے سامنے آئے گی (مثال کے طور پر، RDS مثال کے DNS نام کے اندر)۔
4. ریسورس یا ڈیٹا سورس بلاک کے اندر پہلی دلیل کے طور پر سب سے اوپر`count` / `for_each`  دلیل شامل کریں اور اس کے بعد نئی لائن کے ذریعے الگ کریں۔
5. **اگر**resource اجازت دے تو**، حقیقی دلیل کے طور `tags` دلیل شامل کریں، اس کے بعد depends\_on اور lifecycle،**اور **اگر ضروری ہو۔ ان سب کو ایک خالی لائن سے الگ کیا جانا چاہیے۔**
6. "جب ارگومنٹ `count / for_each` میں values استعمال کر رہے ہیں تو `length` یا دیگر اعبار کی بجائے بولین values کو ترجیح دیں۔"

## ریسورس`resource` **کی کوڈ مثالیں**

### **`count / for_each` کا استعمال**

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

### **ٹیگز**`tags` **کی جگہ**

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

### &#x20;کونٹ`count` **میں شرائط**&#x20;

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

## وہرہبلیس (Variables)

1. ریسورس کے ماڈیولز میں چیزوں کو دوبارہ  نہ بنائیں: وہرہبلیس (Variables) کے لیے نام، تفصیل، اور پہلے سے طے شدہ value استعمال کریں جیسا کہ ریسورس کے لیے "Argument Reference" **سیکشن میں بیان کیا گیا ہے جس کے ساتھ آپ کام کر رہے ہیں۔**
2. وہرہبلیس (Variables) **میں توثیق کے لیے تعاون کافی محدود ہے (مثال کے طور پر** آپ **دوسرے** وہرہبلیس (Variables) **تک رسائی حاصل نہیں کر سکتے یا تلاش نہیں کر سکتے)۔ اس کے مطابق منصوبہ بندی کریں کیونکہ بہت سے معاملات میں یہ خصوصیت بیکار ہے۔**
3. جب قسم list(...) یا map(...) ہو تو وہرہبلیس (Variables) کے نام میں جمع فارم استعمال کریں۔
4. وہرہبلیس (Variables) بلاک میں کلیدیں اس طرح ترتیب دیں: تفصیل، قسم، پہلے سے طے شدہ، توثیق۔
5. ہمیشہ تمام وہرہبلیس (Variables) **پر تفصیل شامل کریں یہاں تک کہ اگر آپ کو لگتا ہے کہ یہ واضح ہے (آپ کو مستقبل میں اس کی ضرورت ہوگی)۔**
6. جب تک کہ آپ کو ہر کلید پر سخت پابندیوں کی ضرورت نہ ہو، مخصوص قسم جیسے object() کے مقابلے میں سادہ اقسام (number، string، list(...)، map(...)، any) استعمال کرنے کو ترجیح دیں۔
7. اگر map کے تمام عناصر ایک ہی قسم کے ہیں (مثال کے طور پر `string`) یا اس میں تبدیل کیے جا سکتے ہیں (مثال کے طور پر `number` کی قسم کو `string` میں تبدیل کیا جا سکتا ہے) تو `map(map(string))` جیسے مخصوص اقسام کا  استعمال کریں۔
8. ایک خاص گہرائی سے شروع ہونے والی قسم کی جانچنا کو غیر فعال کرنے کے لیے یا جب متعدد اقسام کی حمایت کی جانی چاہیے تو `any` کا استعمال کریں۔
9. والیو Value**`{}` کبھی کبھی** map **ہوتی ہے لیکن کبھی کبھی ایک** object **ہوتی ہے۔** map **بنانے کے لیے `tomap(...)` استعمال کریں کیونکہ کوئی**object **بنانے کا کوئی طریقہ نہیں ہے۔**

## آؤٹ پٹس  (Outputs)

آؤٹ پٹسOutputs کو اس کے دائرہ کار سے باہر مستقل اور قابل فہم بنائیں (جب کوئی صارف کسی ماڈیول کا استعمال کر رہا ہو تو یہ واضح ہونا چاہیے کہ یہ کس قسم اور والیو Value **کی خصوصیت واپس کرتا ہے)۔**

1. آؤٹ پٹ کا نام اس میں موجود پراپرٹی کو بیان کرنا چاہیے اور عام طور پر آپ کی خواہش سے کم آزاد شکل کا ہونا چاہیے۔
2. آؤٹ پٹ کے نام کے لیے اچھی ساخت `{name}_{type}_{attribute}` کی طرح نظر آتی ہے، جہاں:
   1. نام `{name}`ریسورس یا ڈیٹا کے سورسہ کے نام کے بغیر provider کے سابقہ کے بغیر استعمال کریں `aws_subnet` کے لیے `{name}` `subnet`ہے، `aws_vpc` کے لیے یہ `vpc` ہے۔
   2. ٹائپ`{type}` ریسورسسورسہ   کی قسم ہے۔
   3. {attribute} آؤٹ پٹ کے واپس کرنے کی ایک صفت ہے
   4. [See examples](naming.md#code-examples-of-output).
3. "اگرآؤٹ پٹ  وسیع تعریفی تفصیلات، انٹرپولیشن فنکشنز، اور مختلف ریسورس کی value واپس دے رہا ہے، تو `{name}` اور `{type}` کو جتنا ممکن ہو، عام اور عمومی رکھنا چاہئے (`this` کا پریفکس نہیں ہونا چاہئے). [مثال دیکھیں](naming.md#code-examples-of-output)."
4. اگر واپس آنے والی value فہرست ہے تو اس کا جمع کا نام ہونا چاہیے۔ [مثال دیکھیں۔](naming.md#use-plural-name-if-the-returning-value-is-a-list)
5. ہمیشہ تمام آؤٹ پٹس کے لیے تفصیل `description` **شامل کریں یہاں تک کہ اگر آپ کو لگتا ہے کہ یہ واضح ہے۔**
6. &#x20;حساس دلیل کو ترتیب دینے سے گریز کریں۔جب تک آپ تمام ماڈیولز میں تمام جگہوں پر اس آؤٹ پٹ کے استعمال کو مکمل طور پر کنٹرول نہیں کرتے،&#x20;
7.  &#x20;ٹیرافارم (Terraform) کی شروعات سے دستیاب `try()` کو (جو بعد از Terraform 0.13 کے ورژنز کے لئے چھوڑ دی گئی)`element(concat(...))` (قدیم طریقہ کار) کے بجائے ترجیح دیں"



### آؤٹ پٹ`output` کوڈ کی مثالیں&#x20;

زیادہ سے زیادہ ایک سیکورٹی گروپ کی ID واپس کریں:

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

جب ایک ہی قسم کے متعدد ریسورسز ہوں، تو`this` آؤٹ پٹ کے نام سے حذف کر دینے چاہیے:

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

**اگر واپس آنے والی** value **فہرست ہے تو جمع کا نام استعمال کریں۔**

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
