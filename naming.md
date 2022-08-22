# מוסכמות למתן שמות

## קונבנציות כלליות

{% hint style="info" %}
אין סיבה שלא לעקוב לפחות אחרי המוסכמות האלו :)
{% endhint %}

{% hint style="info" %}
היזהרו בעת מתן השמות למשאבי הענן עצמם, לעיתים קרובות יש מגבלות בשמות מותרים. יש משאבים לדוגמא שלא יכולים להכיל מקפים, חלקם מחוייבים בקונבציות אחרות. המוסכמות בספר זה מתייחסות למתן שמות לאובייקטי Terraform בלבד.
{% endhint %}

1. השתמש ב- \_ (מקף תחתון) במקום - (מקף) בכל מקום (בשמות משאבים, בשמות מקורות נתונים, בשמות משתנים, בפלט וכו').
2. עדיף להשתמש באותיות קטנות ובמספרים (למרות ש- UTF-8 נתמך).

## ארגומנטים של משאב ומקורות נתונים

1. אל תחזורו על סוג המשאב בשם המשאב (לא באופן חלקי או מלא):

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

1. שם משאב צריך להיקרא `this` אם אין שם תיאורי וכללי זמין, לחלופין, אם מודול המשאב יוצר משאב יחיד מסוג זה (לדוגמה, במודול [AWS VPC](https://github.com/terraform-aws-modules/terraform-aws-vpc) קיים משאב יחיד מסוג `aws_nat_gateway` ומשאבים מרובים של `aws_route_table`, לכן ל `aws_nat_gateway` להיקרא בשם `this` ו- `aws_route_table` לכלול שמות תיאוריים יותר - כגון `private`, `public`, `database`).
2. השתמשו תמיד בשמות עצם (יחיד) עבור שמות.
3. השתמש ב `-` בתוך ערכי ארגומנטים ובמקומות שבהם הערך ייחשף לבני אדם (לדוגמה, בתוך שם DNS של RDS).
4. הארגומנטיים `count` / `for_each` מומלץ שיבואו כארגומנטים ראשונים בתוך משאבים ויופרדו בשורה חדשה משאר ההגדרות.
5. האגומנט `tags` מומלץ שיבוא אחרון, מיד אחרי `lifecycles` ושיפורד בשורה ריקה בין שאר המשאבים
6. בעת שימוש בתנאים ב- argument`count` / `for_each`  עדיף להשתמש בערכים בוליאניים במקום להשתמש `length` או בביטויים אחרים.

## דוגמאות לקוד של משאב

### שימוש ב `count` / `for_each`

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

### מיקום של `tags`

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

### תנאים ב `count`

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

## משתנים

1. אל תמציא מחדש את הגלגל במודולי המשאבים: `name`, `description`, ו `default` עבור משתנים, כפי שמוגדר בסעיף "הפניה לארגומנט" עבור המשאב שאיתו אתה עובד.
2. התמיכה באימות במשתנים מוגבלת למדי (לדוגמה, אין אפשרות לגשת למשתנים אחרים או לבצע בדיקות מידע). תכנן בהתאם לכך משום שבמקרים רבים תכונה זו אינה שימושית.
3. השתמשו בצורת שם עצם רבים כאשר סוג המשתנה הוא `list(...)` או `map(...)`.
4. סדרו את ה `keys` בבלוק משתנה כך: `description` , `type`, `default`, `validation`.
5. כללו תמיד תיאור בכל המשתנים גם אם אתם סבורים שזה ברור מאליו (תזדקקו לו בעתיד).
6. העדפו שימוש בסוגים פשוטים (מספר, מחרוזת, רשימה(...), מפה(...), `any`) על-פני סוג ספציפי כגון אובייקט(), אלא אם כן עליכם לכלול אילוצים מחמירים על כל `key`.
7. השתמש בסוגים ספציפיים כגון `map(map(string))` אם לכל רכיבי המפה יש סוג זהה (לדוגמה מחרוזת) או ניתן להמיר אותה אליה (לדוגמה, מספר ניתן להמרה למחרוזת).
8. השתמשו בסוג `any` כדי לנטרל את אימות הסוג כאשר יש לתמוך בסוגים מרובים.
9. הערך {} הוא לעתים מפה, אך לעתים אובייקט. השתמשו ב- `tomap(...)` כדי ליצור מפה כיוון שאין דרך ליצור אובייקט.

## פלט

צרו פלט עקבי ומובן מחוץ לסקופ שלו (כאשר משתמש משתמש במודול, צריך להיות ברור איזה סוג ותכונה של הערך שהוא מחזיר).

1. שם הפלט צריך לתאר את המאפיין שהוא מכיל.
2. מבנה טוב לשם הפלט נראה כך `{name}_{type}_{attribute}`
   1. `{name}`הוא שם משאב או מקור נתונים ללא קידומת ספק. `{name}` של `aws_subnet` יהיה `subnet`, בשביל`aws_vpc` זה `vpc`.
   2. `{type}` הוא סוג המשאב
   3. `{attribute}` הוא תכונה המוחזרת על-ידי הפלט
   4. [דוגמאות](naming.md#code-examples-of-output)
3. אם הפלט מחזיר ערך בשימוש פונקצית אינטרפולציה ומשאבים מרובים, `{name}` ו `{type}` צריכים להיות גנרים כמה שיות. [דוגמאות](naming.md#code-examples-of-output).
4. אם הפלט מחזיר ערך עם פונקציות אינטרפולציה ומשאבים מרובים, {name} ו- {type} צריכים להיות כלליים ככל האפשר (יש להשמיט קידומת זו).
5. אם הערך המוחזר הוא רשימה, עליו להיות לו שם עצם רבים.
6. כלול תמיד תיאור עבור כל התוצרים גם אם אתה סבור שזה ברור מאליו.
7. הימנע מהגדרת ארגומנט `sensitive` אלא אם אתה שולט באופן מלא בשימוש בפלט זה בכל המקומות בכל המודולים.
8. העדיפו `try()` (זמין מאז terraform 0.13) על concat(...13)

### דוגמאות קוד `output`

החזר לכל היותר מזהה אחד של קבוצת אבטחה:

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

כאשר יש משאבים מרובים מאותו סוג, יש להשמיט `this` בשם הפלט:

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

### השתמש בשם עצם רבים אם הערך המוחזר הוא רשימה

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
