# Умови найменувань

## Загальні умови

{% hint style="info" %}
Не повинно бути ніяких причин не дотримуватися принаймні цих умов :)
{% endhint %}

{% hint style="info" %}
Майте на увазі, що реальні хмарні ресурси часто мають обмеження у дозволених іменах. Деякі ресурси, наприклад, не можуть містити тире, деякі мають бути у формі camel-cased. Умови в цій книзі посилаються на самі імена Terraform.
{% endhint %}

1. Використовуйте `_` (підкреслення) замість `-` (тире) всюди (імена ресурсів, імена джерел даних, імена змінних, вихідні дані тощо).
2. Віддавайте перевагу використанню малих літер і цифр (навіть якщо підтримується UTF-8).

## Аргументи ресурсів і джерел даних

1.  Не повторюйте тип ресурсу в назві ресурсу (ні частково, ні повністю):

    {% hint style="success" %}
    `resource "aws_route_table" "public" {}`
    {% endhint %}

    {% hint style="danger" %}
    `resource "aws_route_table" "public_route_table" {}`
    {% endhint %}

    {% hint style="danger" %}
    `resource "aws_route_table" "public_aws_route_table" {}`
    {% endhint %}
2. Ім'я ресурсу повинно називатись `this,` якщо немає більш описової та загальної назви, або якщо модуль ресурсів створює один ресурс цього типу (наприклад, у [AWS VPC module](https://github.com/terraform-aws-modules/terraform-aws-vpc) існує єдиний ресурс типу `aws_nat_gateway` і декілька типів ресурсів`aws_route_table`, так що `aws_nat_gateway` має бути названий `this` і `aws_route_table` повинен мати більш описову назву - наприклад приватний, публічний, база даних).
3. Завжди використовуйте іменники в однині для імен.
4. Використання - всередині значень аргументів і в місцях, де значення буде доступне для людини (наприклад, всередині імені DNS екземпляра RDS).
5. Включайте аргумент `count` / `for_each` всередині блоку ресурсу або джерела даних як перший аргумент угорі та розділяйте новим рядком після нього.
6. Включайте аргумент `tags,`якщо це підтримується ресурсом, як останній реальний аргумент, наступний за `depends_on` та `lifecycle`, якщо необхідно. Всі вони повинні бути розділені одним порожнім рядком.
7. При використанні умов в аргументі`count` / `for_each`віддавайте перевагу логічним значенням замість використання `length` або інших виразів.

## Приклади коду ресурсів

### Використання `count` / `for_each`

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

### Розміщення тегів

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

### Умови в`count`

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

## Змінні

1. Не винаходьте велосипед у ресурсних модулях: використовуйте `name`, `description і` `default` значення для змінних, як зазначено в розділі «Довідник аргументів» для ресурсу, з яким ви працюєте.
2. Підтримка перевірки змінних досить обмежена (наприклад, не можна отримати доступ до інших змінних або виконати пошук). Плануйте відповідно, тому що в багатьох випадках ця функція не корисна.
3. Використовуйте форму множини в імені змінної, якщо тип є `list(...)` або `map(...)`.
4. Упорядковуйте ключі у змінному блоці, як описано далі: `description` , `type`, `default`, `validation`.
5. Завжди включайте `description` для всіх змінних, навіть якщо ви думаєте, що це очевидно (це знадобиться вам у майбутньому).
6. Віддавайте перевагу використанню простих типів (`number`, `string`, `list(...)`, `map(...),` над спеціальними, як наприклад `object(),` якщо вам не потрібні жорсткі обмеження для кожного ключа.
7. Використовуйте спеціальні типи, наприклад `map(map(string))` якщо всі елементи у map мають одинаковий тип (наприклад, `string`) або можна конвертувати в нього (наприклад тип `number` можна конвертувати у `string`).
8. Використовуйте тип `any` щоб відключити перевірку типу, починаючи з певної глибини або коли має підтримуватися декілька типів.
9. Значенння `{}` це іноді map, а іноді - object. Використовуйте `tomap(...)` щоб зробити map, тому що немає можливості зробити об'єкт.

## Вихідні дані

Робіть вихідні дані узгодженими і зрозумілими за межами їх області (коли користувач використовує модуль, має бути очевидним, який тип і атрибут значення він повертає).

1. Ім’я виводу має описувати властивість, яке він містить, і бути менш вільною формою, ніж ви зазвичай хотіли б.
2. Хороша структура назви виводу виглядає так `{name}_{type}_{attribute}` , де:
   1. `{name}` це ім’я ресурсу або джерела даних без префікса постачальника. `{name}` для `aws_subnet` - це `subnet`, для`aws_vpc` - це `vpc`.
   2. `{type}` є різновидом джерела ресурсів
   3. `{attribute}` є атрибутом, який повертає вихідні дані
   4. [Перегляньте приклади](naming.md#code-examples-of-output).
3. Якщо вихідні дані повертають значення з функціями інтерполяції та кількома ресурсами, `{name}` і `{type},вони`мають бути якомога загальнішими (це як префікс слід пропустити). [Перегляньте приклади](naming.md#code-examples-of-output).
4. Якщо повертається значення у вигляді списка, воно повинно мати назву у множині. [Перегляньте приклади](naming.md#use-plural-name-if-the-returning-value-is-a-list).
5. Завжди включайте `description` для всіх результатів, навіть якщо ви думаєте, що це очевидно.
6. Уникайте налаштування `чутливих` аргументів, якщо ви повністю не контролюєте використання цього виводу в усіх місцях і у всіх модулях.
7. Віддавайте перевагу`try()` (доступний з Terraform 0.13) над `element(concat(...))` (застарілий підхід для версій до 0.13)

### Приклади коду вихідних даних

Повертає щонайбільше один ідентифікатор із групи безпеки:

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

Якщо є декілька ресурсів одного типу, це слід пропустити в назві виводу:

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

### Використовуйте назви у множині, якщо повернене значення є списком

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

