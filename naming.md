# قواعد التسمية

## القواعد العامة&#x20;

{% hint style="info" %}
يجب ألا يكون هناك سبب لعدم اتباع هذه القواعد على الأقل :)
{% endhint %}

{% hint style="info" %}
كن حذراً أن الموارد الحقيقية التي يتم تعريفها في Terraform غالباً ما يكون لها قيود على الأسماء المسموح بها. بعض الموارد كمثال لا تقبل الخطوط (dashes)، أو يجب أن يكون بعضها Camel-cased، القواعد في هذا الكتاب تشير إلى الأسماء المستخدمة في Terraform. &#x20;
{% endhint %}

1. استعمل \_ (underscore) بدلاً من - (dash) في كل مكان (أسماء الموراد، أسماء مصادر البيانات، أسماء المتحولات، أسماء المخرجات الخ..)
2. فضل استعمال الأحرف الصغيرة (lowercase) والأرقام فقط (حتى لو كان نظام UTF-8 مدعوماً)

## أسماء الموراد ومصادر البيانات&#x20;

1.  لا تكرر نوع المورد في اسم المورد (ليس جزئيًا أو كليًا):

    {% hint style="success" %}
    `resource "aws_route_table" "public" {}`
    {% endhint %}

    {% hint style="danger" %}
    `resource "aws_route_table" "public_route_table" {}`
    {% endhint %}

    {% hint style="danger" %}
    `resource "aws_route_table" "public_aws_route_table" {}`
    {% endhint %}
2. يجب تسمية المورد باسم`this`إذا لم يكن هناك اسم وصفي وعام متاح، أو إذا كانت وحدة الموارد تنشئ موردًا واحدًا من هذا النوع (كمثال في [AWS VPC module](https://github.com/terraform-aws-modules/terraform-aws-vpc) يوجد فقط مورد وحيد من النوع`aws_nat_gateway` وعدة موارد من النوع `aws_route_table` لذلك يجب تسمية المورد من نوع`aws_nat_gateway` باسم `this`ويجب أن  نستعمل أسماء وصفية اكثر من أجل موارد النوع `aws_route_table` مثل`private`, `public,` `database)`&#x20;
3. استخدم دائمًا الأسماء المفردة للتسمية.
4. استعمل - (dash) داخل قيم الوسيطات وفي الأماكن التي ستتعرض فيها القيمة للبشر (على سبيل المثال ، اسم DNS لخادم افتراضي RDS).&#x20;
5. استعمل الوسيطان `count` / `for_each` داخل المورد أو داخل مصدر البيانات كأول وسيط وقم بإضافة سطر فارغ بعده&#x20;
6. استعمل الوسيط`tags` إذا كان مدعوماً من قبل المورد كأخر وسيط متبوع بالوسيطات`depends_on, lifecycle`إذا احتجت إليها، كل منها مفصول عن الأخر بسطر فارغ.
7. عند استعمال شروط للوسيطان `count` / `for_each`ففضل استعمال القيم المنطقية عوضاً عن`length`أو أي تعابير أخرى&#x20;

## أمثلة كود لأسماء المصادر

### استعمال `count` / `for_each`في الكود

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

### وضعية `tags`في الكود

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

### &#x20;استعمال الشروط في `count`في الكود

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

## أسماء المتحولات

1. لا تعيد اختراع العجلة في وحدات الموارد: استخدم الاسم`name`والوصف`description`والقيمة الافتراضية `default`للمتحولات كما هو محدد في قسم "Argument Reference"  للمورد الذي تعمل معه.
2. عملية التحقق (Validation) من المتحولات محدود نوعًا ما (على سبيل المثال ، لا يمكن الوصول إلى متحولات أخرى أو إجراء عمليات بحث). خطط وفقًا لذلك لأنه في كثير من الحالات تكون هذه الميزة غير مجدية.
3. استخدم صيغة الجمع في اسم متحول  عند يكون نمطه`list`أو`map`.&#x20;
4. قم بترتيب الأقسام في المتحول كالتالي:`description`ثم`type`ثم`default`وأخيراً`validation`
5. دائماً قم بإضافة قسم`description` إلى كل المتحولات حتى لو كنت تظن أنه واضح (ستحتاجه في المستقبل)
6. فضل استعمال الأنواع البسيطة (`number`, `string`, `list(...)`, `map(...)`, `any`) على الأنواع الأخرى مثل`object،`إلا إذا كنت تحتاج قيود صارمة على كل key
7. استعمل الأنماط المحددة مثل`map(string)` في حال كانت كل العناصر الموجودة داخلها من نفس النمط أو كان يمكن تحويلها إلى هذا النمط (مثلاً النمط`number`ممكن تحويله إلى النمط`string)`&#x20;
8. استعمل النمط `any`لتعطيل التحقق من النوع بدءاً من عمق معين أو عندما يجب دعم أنواع متعددة
9. القيمة {} هي عبارة عن map في بعض الأحيان وobject في أحيان أخرى. استعمل ()tomap لجعلها من النمط map دائماً.

## أسماء المخرجات

اجعل المخرجات متسقة ومفهومة خارج سياقها ( عندما يتم استعمال وحدة من قبل مستخدم يجب على المخرجات أن تكون واضح ما هو نمط وما صفات القيمة التي ترجعها)

1. يجب على اسم الخرج أن يصف القيمة التي يرجعها وأن تكون أقل حرية مما تريد عادة.
2. الشكل الجيد لاسم الخرج يكون كالتالي `{attribute}_{type}_{name}` حيث:
   1. &#x20;إن `{name}` هو اسم المورد أو اسم مصدر البيانات بدون اسم الموفر. كمثال للمورد `aws_subnet` يكون الاسم هو`subnet`وللمورد`aws_vpc` يكون `vpc`
   2. &#x20;`إن {type}`هو نمط الخرج الئي نتعامل معه&#x20;
   3. إن`{attribute}`هو الصفة المخرجة&#x20;
   4. [انظر الأمثلة](naming.md#code-examples-of-output).
3. إذا كان الخرج يعيد قيمة مع استعمال interpolation functions  وعدة موارد فيجب على `{name} و{type}`  أن تكون معممة قدر الإمكان (`this يجب حذفها)`[انظر الأمثلة](naming.md#code-examples-of-output)&#x20;
4. إذا كانت قيمة الخرج عبارة عن list فإنه يجب أن نستعمل اسم جمع [انظر الأمثلة](naming.md#use-plural-name-if-the-returning-value-is-a-list)
5. دائماً قم بإضافة قسم`description` إلى كل المخرجات حتى لو كنت تظن أنه واضح
6. تجنب وضع وسيط `sensitive`إلا إذا كنت تملك تحكم كامل باستعمال هذا الخرج في كل الأماكن في كل الوحدات
7. فضل استعمال ()`try` (متوفرة منذ الإصدار 0.13) على استعمال `element(concat(...))`(التي كانت تستعمل قبل 0.13)&#x20;

### أمثلة كود لأسماء المخرجات

تعيد على  الأكثر Security group ID وحيد

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

عند وجود عدة مصادر من نفس النمط، يجب حذف`this`من الخرج:&#x20;

{% hint style="danger" %}
{% code title="outputs.tf" %}
```hcl
output "this_security_group_id" {
  description = "The ID of the security group"
  value       = element(concat(coalescelist(aws_security_group.this.*.id, aws_security_group.web.*.id), [""]), 0)
  
```
{% endcode %}
{% endhint %}

إذا كانت قيمة الخرج عبارة عن list فإنه يجب أن نستعمل اسم جمع :

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

