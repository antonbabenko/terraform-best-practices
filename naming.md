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

## Приклади коду ресурсу

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

1. Don't reinvent the wheel in resource modules: use `name`, `description`, and `default` value for variables as defined in the "Argument Reference" section for the resource you are working with.
2. Support for validation in variables is rather limited (e.g. can't access other variables or do lookups). Plan accordingly because in many cases this feature is useless.
3. Use the plural form in a variable name when type is `list(...)` or `map(...)`.
4. Order keys in a variable block like this: `description` , `type`, `default`, `validation`.
5. Always include `description` on all variables even if you think it is obvious (you will need it in the future).
6. Prefer using simple types (`number`, `string`, `list(...)`, `map(...)`, `any`) over specific type like `object()` unless you need to have strict constraints on each key.
7. Use specific types like `map(map(string))` if all elements of the map have the same type (e.g. `string`) or can be converted to it (e.g. `number` type can be converted to `string`).
8. Use type `any` to disable type validation starting from a certain depth or when multiple types should be supported.
9. Value `{}` is sometimes a map but sometimes an object. Use `tomap(...)` to make a map because there is no way to make an object.

## Outputs

Make outputs consistent and understandable outside of its scope (when a user is using a module it should be obvious what type and attribute of the value it returns).

1. The name of output should describe the property it contains and be less free-form than you would normally want.
2. Good structure for the name of output looks like `{name}_{type}_{attribute}` , where:
   1. `{name}` is a resource or data source name without a provider prefix. `{name}` for `aws_subnet` is `subnet`, for`aws_vpc` it is `vpc`.
   2. `{type}` is a type of a resource sources
   3. `{attribute}` is an attribute returned by the output
   4. [See examples](naming.md#code-examples-of-output).
3. If the output is returning a value with interpolation functions and multiple resources, `{name}` and `{type}` there should be as generic as possible (`this` as prefix should be omitted). [See example](naming.md#code-examples-of-output).
4. If the returned value is a list it should have a plural name. [See example](naming.md#use-plural-name-if-the-returning-value-is-a-list).
5. Always include `description` for all outputs even if you think it is obvious.
6. Avoid setting `sensitive` argument unless you fully control usage of this output in all places in all modules.
7. Prefer `try()` (available since Terraform 0.13) over `element(concat(...))` (legacy approach for the version before 0.13)

### Code examples of `output`

Return at most one ID of security group:

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

When having multiple resources of the same type, `this` should be omitted in the name of output:

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

### Use plural name if the returning value is a list

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

