# Канвенцыя наймення

## Агульныя пагадненні

{% hint style="info" %}
Не павінна быць прычын не прытрымлівацца хаця б гэтых канвенцый :)
{% endhint %}

{% hint style="info" %}
Звярніце ўвагу, што рэальныя воблачныя рэсурсы часта маюць абмежаванні на дазволеныя назвы. Некаторыя рэсурсы, напрыклад не могуць утрымліваць працяжнікі, а некаторыя павінны быць напісаны ў camel-case. Пагадненні ў гэтай кнізе адносяцца да саміх назваў Terraform.
{% endhint %}

1. Выкарыстоўвайце `_` (падкрэсліванне) замест `-` (дэфіса) паўсюль (у назвах рэсурсаў, назвах крыніц даных, назвах пераменных, outputs і г.д.).
2. Аддавайце перавагу малым літарам і лічбам (хоць UTF-8 і падтрымліваецца).

## Аргументы рэсурсаў і крыніц дадзеных

1. Не паўтарайце тып рэсурсу ў назве рэсурсу (ні часткова, ні цалкам):

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

2. Назва рэсурсу павінна быць `this` калі няма больш дакладнай і агульнай назвы, або калі модуль рэсурсаў стварае адзіны рэсурс гэтага тыпу (напрыклад, у [AWS VPC модулі](https://github.com/terraform-aws-modules/terraform-aws-vpc) ёсць адзін рэсурс тыпу `aws_nat_gateway` and  і некалькі рэсурсаў тыпу `aws_route_table`, таму `aws_nat_gateway` павінен называцца `this` а `aws_route_table` павінны мець больш дакладныя назвы — напрыклад `private`, `public`, `database`).
3. Заўсёды выкарыстоўвайце назоўнікі ў адзіночным ліку для назваў.
4. Выкарыстоўвайце `-` у значэннях аргументаў і ў месцах, дзе значэнне будзе бачна чалавеку (напрыклад, у DNS імёнах альбо RDS экзэмпляры).
5. Уключайце колькасць аргументаў `count` / `for_each` у блоку рэсурса або крыніцы даных у якасці першага аргумента ўверсе і аддзяляйце ад яго адзіным радком.
6. Уключайце аргумент `tags` калі яны падтрымліваюцца рэсурсам, у якасці апошняга рэальнага аргумента, пасля `depends_on` і `lifecycle`, калі гэта неабходна. Усе яны павінны быць аддзеленыя адзіным пустым радком.
7. Пры выкарыстанні ўмоў у аргуменце `count` / `for_each` аддавайце перавагу лагічным значэнням замест выкарыстання `length` альбо іншых выразаў.

## Прыклады кода `resource`

### Выкарыстанне `count` / `for_each`

{% hint style="success" %}
{% code title="main.tf" %}
```hcl
resource "aws_route_table" "public" {
  count = 2

  vpc_id = "vpc-12345678"
  # ... астатнія аргументы прапушчаны
}

resource "aws_route_table" "private" {
  for_each = toset(["one", "two"])

  vpc_id = "vpc-12345678"
  # ... астатнія аргументы прапушчаны
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

  # ... астатнія аргументы прапушчаны
}
```
{% endcode %}
{% endhint %}

### Размяшчэнне `tags`

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

### Умовы ў `count`

{% hint style="success" %}
{% code title="outputs.tf" %}
```hcl
resource "aws_nat_gateway" "that" {    # найлепш
  count = var.create_public_subnets ? 1 : 0
}

resource "aws_nat_gateway" "this" {    # добра
  count = length(var.public_subnets) > 0 ? 1 : 0
}
```
{% endcode %}
{% endhint %}

## Пераменныя

1. Не вынаходзьце ровар у модулях рэсурсаў: выкарыстоўвайце `name`, `description`, і `default` для зменных, як гэта вызначана ў раздзеле «Спасылка на аргументы» для рэсурса, з якім вы працуеце.
2. адтрымка валідацыі для зменных даволі абмежаваная (напрыклад немагчыма атрымаць доступ да іншых пераменных або выконваць пошук, калі выкарыстоўваецца версія да Terraform `1.9`). Плануйце адпаведна, бо ў многіх выпадках гэтая функцыя бескарысная.
3. Выкарыстоўвайце форму множага ліку ў назве пераменнай калі тып — `list(...)` або `map(...)`.
4. Размяшчайце ключы ў блоку зменных у такім парадку: `description` , `type`, `default`, `validation`.
5. Заўсёды дадавайце `description` да ўсіх пераменных, нават калі вам здаецца, што яно відавочнае (яно спатрэбіцца ў будучыні). Выкарыстоўвайце тую ж тэрміналогію, што і ў зыходнай дакументацыі, калі гэта магчыма.
6. Аддавайце перавагу выкарыстанню простых тыпаў (`number`, `string`, `list(...)`, `map(...)`, `any`) перад спецыфічнымі, такімі як `object()` калі толькі вам не патрэбны строгія абмежаванні для кожнага ключа.
7. Выкарыстоўвайце такія спецыфічныя тыпы, як `map(map(string))` калі ўсе элементы мапы маюць аднолькавы тып (напрыклад `string`) або могуць быць пераўтвораны ў яго (напрыклад `number` можна пераўтварыць у `string`).
8. Выкарыстоўвайце тып `any` каб адключыць праверку тыпаў пачынаючы з пэўнай глыбіні або калі неабходна падтрымліваць некалькі тыпаў.
9. Значэнне `{}` часам з'яўляецца мапай, а часам — аб'ектам. Выкарыстоўвайце `tomap(...)` каб стварыць мапу, бо няма спосабу стварыць аб'ект.
10. Пазбягайце падвойных адмоў: выкарыстоўвайце станоўчыя назвы зменных, каб пазбегнуць блытаніны. Напрыклад, выкарыстоўвайце `encryption_enabled` замест `encryption_disabled`.
11. Для пераменных, якія ніколі не павінны быць `null`, усталюйце `nullable = false`. Гэта гарантуе, што пры перадачы `null` будзе выкарыстоўвацца значэнне па змаўчанні замест `null`. Калі `null` з'яўляецца прымальным значэннем, вы можаце прапусціць nullable або ўсталяваць яго значэнне на `true`.

## Outputs

Рабіце outputs паслядоўнымі і зразумелымі па-за межамі яго сферы прымянення (калі карыстальнік працуе з модулем, павінна быць відавочна, які тып і атрыбут мае вяртаемыя ім значэнне).

1. Назва output павінна апісваць уласцівасць, якую яна змяшчае, і быць менш свабоднай формы, чым звычайна хацелася б.
2. Добрая структура для назвы output выглядае так `{name}_{type}_{attribute}` , дзе:
   1. `{name}` ёсць назвай рэсурсу або крыніцы дадзеных
      * `{name}` для `data "aws_subnet" "private"` ёсць `private`
      * `{name}` для `resource "aws_vpc_endpoint_policy" "test"` ёсць `test`
   2. `{type}` з'яўляецца тыпам рэсурсу або крыніцы дадзеных без прэфікса пастаўшчыка
      * `{type}` для `data "aws_subnet" "private"` ёсць `subnet`
      * `{type}` для `resource "aws_vpc_endpoint_policy" "test"` ёсць `vpc_endpoint_policy`
   3. `{attribute}` з'яўляецца атрыбутам, які вяртаецца output
   4. [Глядзі прыклад](naming.md#code-examples-of-output).
3. Калі output вяртае значэнне з інтэрпаляцыйнымі функцыямі і некалькімі рэсурсамі, `{name}` і `{type}` павінны быць максімальна агульнымі (прэфікс `this` варта выключыць). [Глядзі прыклад](naming.md#code-examples-of-output).
4. Калі вернутае значэнне ёсць спісам, яго назва павінна быць у множным ліку. [Глядзі прыклад](naming.md#use-plural-name-if-the-returning-value-is-a-list).
5. Заўсёды дадавайце `description` для ўсіх outputs нават калі вам здаецца, што яно відавочнае.
6. Пазбягайце вызначаць `sensitive` аргумент, калі вы не кантралюеце цалкам выкарыстанне гэтага вываду ва ўсіх месцах ва ўсіх модулях.
7. Аддавайце перавагу `try()` (даступна з Terraform 0.13) перад `element(concat(...))` (стары падыход для версій да 0.13)

### Прыклады кода `output`

Вяртайце максімум адзін ID групы бяспекі:

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

Калі ёсць некалькі рэсурсаў аднаго тыпу, `this` трэба выключыць з назвы output:

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

### Выкарыстоўвайце імя ў множным ліку, калі вяртанае значэнне ёсць спісам

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
