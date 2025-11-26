---
metaLinks:
  alternates:
    - https://app.gitbook.com/s/e1Mp2scOX6OnQbifCen3/naming
---

# Атау келісімдері

## Жалпы келісімдер

{% hint style="info" %}
Ең болмағанда осы келісімдерді сақтамауға ешқандай себеп жоқ :)
{% endhint %}

{% hint style="info" %}
Нақты бұлттық ресурстардың рұқсат етілген атауларында жиі шектеулер болатынын ескеріңіз. Мысалы, кейбір ресурстарда дефистер болмауы керек, кейбіреулері camel-case (ТүйеӨркеш) стилінде болуы керек. Бұл кітаптағы келісімдер Terraform атауларының өздеріне қатысты.
{% endhint %}

1. Барлық жерде (ресурс атауларында, дереккөз атауларында, айнымалылар атауларында, шығыстарда және т.б.) `-` (дефис) орнына  `_` (астын сызу белгісін) қолданыңыз.
2. Кіші әріптер мен сандарды қолдануды жөн көріңіз (UTF-8 қолдау көрсетілсе де).

## Ресурс және дереккөз аргументтері&#x20;

1. Ресурс атауында ресурс түрін қайталамаңыз (жартылай да, толықтай да):



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

2. Егер анағұрлым сипаттамалық және жалпы атау болмаса немесе ресурс модулі осы түрдегі жалғыз ресурсты жасаса, ресурс атауы `this` деп аталуы керек (мысалы, [AWS VPC модулінде](https://github.com/terraform-aws-modules/terraform-aws-vpc) `aws_nat_gateway` түріндегі бір ресурс және `aws_route_table` түріндегі бірнеше ресурстар бар, сондықтан `aws_nat_gateway` `this` деп аталуы керек, ал `aws_route_table` анағұрлым сипаттамалық атауларға ие болуы керек — мысалы, `private`, `public`, `database`).
3. Атаулар үшін әрқашан зат есімнің жекеше түрін қолданыңыз.
4. Аргумент мәндерінде және мән адамға көрсетілетін жерлерде (мысалы, RDS данасының DNS атауында) `-` қолданыңыз.
5. `count` / `for_each` аргументін ресурс немесе дереккөз блогының ішіне ең бірінші аргумент ретінде жоғарғы жағына қосыңыз және одан кейін жаңа жолмен бөліңіз.
6. Егер ресурс қолдаса, `tags` аргументін соңғы нақты аргумент ретінде, қажет болса `depends_on` және `lifecycle` аргументтерінің алдына қосыңыз. Бұлардың барлығы бір бос жолмен бөлінуі керек.
7. `count` / `for_each` аргументінде шарттарды қолданған кезде `length` немесе басқа өрнектердің орнына логикалық (boolean) мәндерді жөн көріңіз.

## &#x20;`resource`кодының мысалдары

### &#x20;`count` / `for_each`      қолданылуы

{% hint style="success" %}
{% code title="main.tf" %}
```hcl
resource "aws_route_table" "public" {
  count = 2

  vpc_id = "vpc-12345678"
  # ... қалған аргументтер өткізіп жіберілді
}

resource "aws_route_table" "private" {
  for_each = toset(["one", "two"])

  vpc_id = "vpc-12345678"
  # ... қалған аргументтер өткізіп жіберілді
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

  # ... қалған аргументтер өткізіп жіберілді
}
```
{% endcode %}
{% endhint %}

### Орналасуы `tags`

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

### &#x20;`count` ішіндегі шарттар

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

## Айнымалылар

1.  Ресурс модульдерінде велосипед ойлап таппаңыз: сіз жұмыс істеп жатқан ресурс үшін «Аргумент анықтамалығы» (Argument Reference) бөлімінде анықталғандай айнымалылар үшін

    &#x20;`name`, `description`, және `default` мәндерін қолданыңыз.
2. Айнымалыларда валидацияны қолдау айтарлықтай шектеулі (мысалы, басқа айнымалыларға қол жеткізе алмайды немесе Terraform`1.9`-ға дейінгі нұсқаны қолдансаңыз, іздеулер жасай алмайды). Жоспарды сәйкесінше құрыңыз, өйткені көп жағдайда бұл мүмкіндік пайдасыз болып қалады.
3. Түрі `list(...)` немесе `map(...)`болған кезде айнымалы атауында көпше түрді қолданыңыз.&#x20;
4. Айнымалы блогындағы кілттерді мына ретпен орналастырыңыз: `description` , `type`, `default`, `validation`.
5. Айнымалылардың барлығына, тіпті айтпаса да түсінікті деп ойласаңыз да, әрқашан  `description` қосыңыз (бұл сізге болашақта қажет болады). Мүмкін болса, ресми құжаттамадағыдай тұжырымдаманы қолданыңыз.
6. Әр кілтте қатаң шектеулер болуы қажет болмаса, `object()`сияқты нақты түрден гөрі қарапайым түрлерді (`number`, `string`, `list(...)`, `map(...)`, `any`), қолданған дұрыс.
7. Егер картаның  `map` барлық элементтері бірдей түрде болса (мысалы, `string`) немесе оған түрлендіруге болатын болса (мысалы, `number` түрін `string` түріне түрлендіруге болады),  `map(map(string))`сияқты нақты түрлерді қолданыңыз.&#x20;
8. Белгілі бір тереңдіктен бастап түрді тексеруді өшіру үшін немесе бірнеше түрлерге қолдау көрсету керек болғанда `any` түрін қолданыңыз.
9. &#x20;`{}`мәні кейде карта, кейде объект болып табылады. Карта жасау үшін `tomap(...)` қолданыңыз, себебі объект жасаудың жолы жоқ.
10. Қос терістеуден аулақ болыңыз: шатасуды болдырмау үшін оң айнымалы атауларын қолданыңыз. Мысалы, `encryption_enabled` орнына `encryption_disabled`.
11. For variables that should never be `null`, set `nullable = false`. This ensures that passing `null` uses the default value instead of `null`. If `null` is an acceptable value, you can omit nullable or set it to `true`.
12. Ешқашан `null`болмауы керек айнымалылар үшін `nullable = false`деп орнатыңыз. Бұл `null`мәні берілгенде null-дың орнына әдепкі мәннің қолданылуын қамтамасыз етеді. Егер `null`қабылданатын мән болса, nullable параметрін қалдырып кетуге немесе `true`деп орнатуға болады. &#x20;

## Шығыстар

Шығыстарды бірізді және оның ауқымынан тыс түсінікті етіңіз (пайдаланушы модульді қолданғанда, оның қандай түрді және қандай атрибутты қайтаратыны анық болуы керек).

1. Шығыс атауы ондағы қасиетті сипаттауы керек және әдетте қалағаныңыздан гөрі еркін пішінде болмауы керек.
2. Шығыс атауының жақсы құрылымы `{name}_{type}_{attribute}` сияқты болады, мұнда:
   1. `{name}` ресурс немесе дереккөз атауы.
      * `{name}` үшін  `data "aws_subnet" "private"` бұл `private`
      * `{name}` үшін `resource "aws_vpc_endpoint_policy" "test"` бұл `test`
   2. `{type}`провайдер префиксінсіз ресурс немесе дереккөз түрі.
      * `{type}` үшін `data "aws_subnet" "private"` бұл `subnet`
      * `{type}` үшін `resource "aws_vpc_endpoint_policy" "test"` бұл `vpc_endpoint_policy`
   3. `{attribute}` шығыс қайтаратын атрибут.
   4. [ Мысалдарды қараңыз](naming.md#code-examples-of-output).&#x20;
3. Егер шығыс интерполяция функцияларымен және бірнеше ресурстармен мән қайтарса, ондағы `{name}` және `{type}` мүмкіндігінше жалпылама болуы керек (префикс ретіндегі `this` aалынып тасталуы керек).[Мысалды қараңыз](naming.md#code-examples-of-output)&#x20;
4. Егер қайтарылатын мән тізім болса, оның атауы көпше түрде болуы керек.[ Мысалды қараңыз ](naming.md#eger-aitarylatyn-m-n-tizim-bolsa-k-pshe-ataudy-oldany-yz).
5. Барлық шығыстарға, тіпті айтпаса да түсінікті деп ойласаңыз да, әрқашан `description` қосыңыз.
6. Бұл шығыстың барлық модульдердегі барлық жерде қолданылуын толық бақыламасаңыз, `sensitive` аргументін орнатудан аулақ болыңыз.
7. &#x20;`try()` (Terraform 0.13 нұсқасынан бастап қолжетімді) функциясын `element(concat(...))` (0.13 нұсқасына дейінгі ескірген әдіс) орнына қолданған дұрыс.

### &#x20;`output`  кодының мысалдары &#x20;

Қауіпсіздік тобының ең көбі бір идентификаторын қайтару:

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

Бір түрдегі бірнеше ресурс болған кезде, шығыс атауында `this` алынып тасталуы керек:

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

### Егер қайтарылатын мән тізім болса, көпше атауды қолданыңыз

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
