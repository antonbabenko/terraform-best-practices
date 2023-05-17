# დასახელების კონვენცია

## ზოგადი კონვენცია

{% hint style="info" %}
არ არსებობს მიზეზი იმისა თუ რატომ არ უნდა გაყვეთ ამ დასახელების კონვენციას :)
{% endhint %}

{% hint style="info" %}
გაითვალისწინეთ რომ ღრუბლოვან რესურსებს (cloud resources) ხშირად აქვთ აკრძალვები დაშვებულ სახელებში. ზოგიერთი რესურსს მაგალითად არ შეუძლია შეიცავდეს - ს. ამ წიგნში მოყვანილი კონვენციები თავისთავად ეხება Terraform სახელებს.&#x20;
{% endhint %}

1. გამოიყენეთ `_` (underscore) `-` (dash) მაგიერ ყველგან (რესურსების დასახელებაში, მონაცემთა წყაროს სახელებში, ცვლადების სახელეში და ა.შ.).
2. უკეთესია გამოიყენოთ lowercase ასოები და ციფრები (მიუხედავად UTF-8 მხარდაჭერისა).

## რესურსისა და მონახემთა წყაროების არგუმენტები

1. ნუ გამოიყენებთ რესურსის ტიპს რესურსის სახელში (ნაწილობრივ თუ სრულად):

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

1. რესურსის სახელს უნდა ერქვას `this` იმ შემთხვევაში თუ არ არის მეტი აღწერითი და ზოგადი სახელი ხელმისაწვდომი, ან თუ რესურსის მოდული ქმნის მხოლოდ ერთ ასეთი ტიპის რესურსს (მაგალითად, [AWS VPC module](https://github.com/terraform-aws-modules/terraform-aws-vpc) -ში არის მხოლოდ ერთი  `aws_nat_gateway` ტიპის რესურსი და რამოდენიმე  type`aws_route_table` ტიპის რესურსი, ამიტომ `aws_nat_gateway` -ს უნდა დაერქვას `this` და `aws_route_table` -ს უნდა ჰქონდეს მეტი აღწერითი სახელები - როგორიცაა `private`, `public`, `database`).
2. დასახელებებში ყოველთვის გამოიყენეთ მხოლობითი არსებითი სახელები.
3. გამოიყენეთ `-` არგუმენტების მნიშვნელობებსა და იმ ადგილებში სადაც ეს მნიშვნელობები იქნება გამოტანილი საჯაროდ (მაგალითად, RDS instance-ის  DNS სახელში).
4. გამოიყენე არგუმენტი nclude argument `count` / `for_each` რესურსში ან მონაცემთა წყაროს ბლოკში პირველ არგუმენტად დასაწყისში და გამოყავით ახალი ხაზით.&#x20;
5. გამოიყენეთ არგუმენტი `tags,` თუ რესურსს აქვს ამის მხარდაჭერა, `depends_on` და `lifecycle` ბლოკებამდე, თუ არსებობს ამის საჭიროება. ყველა ბლოკი უნდა გამოიყოს ცარიელი ხაზით.&#x20;
6. `count` / `for_each` არგუმენტებში კონდიციების გამოყენებისას, უპირატესობა მიანიჭეთ boolean მნიშვნელობს ვიდრე `length` ან სხვა ტიპის expression-ებს.

## რესურსის(`resource`) კოდის მაგალითები

### `count` / `for_each`U-ის გამოყენება

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

### ტეგების (`tags`) განთავსება

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

### კონდიციები `count`-ში

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

## ცვლადები

1. ნუ გამოიგონებთ ველოსიპედს რესურსის მოდულებში, გამოიყენეთ:  `name`, `description`, და `default` მნიშვნელობები ცვლადებისთვის ისე როგორც  "Argument Reference" სექციაში არის განსაზღვრული.
2. ცვლადებში ვალიდაციის მხარდაჭერა არის საკმაოდ შეზღუდული (მაგალითად არ აქვს წვდომა სხვა ცვლადებზე). ძირითად შემთხვევბში მიზანშეწონილია  გამოიყენოთ Plan-ი, რადგაც ვალიდაციის ოფცია ხშირ შემთხვევაში არის უშედეგო.
3. ცვლადის სახელებში გამოიყენეთ მრავლობითი ფორმა როდესაც მისი ტიპი არის `list(...)` ან `map(...)`.
4. ცვლადის ბლოკში დაიცავით ელემენტების შემდეგი მიმდევრობა: `description` , `type`, `default`, `validation`.
5. ყოველთვის გამოიყენეთ `description` ყველა ცვლადზე (სამომავლოდ აუცილებლად გამოგადგებათ)
6. უმჯობესია გამოიყენოთ მარტივი ცვლადის ტიპები  (`number`, `string`, `list(...)`, `map(...)`, `any`) ვიდრე სპეციფიური ტიპები როგორიცაა `object()` იმ შემთხვევაში თუ არ გჭირდებათ მკაცრი შეზღუდვები key-ებზე.
7. გამოიყენეთ სპეციფიური ცვლადის ტიპები როგორიცაა `map(map(string))` იმ შემთხვევაში თუ ყველა ელემენტს map-ზე ერთი და იგივე ცვლადის ტიპი (მაგალითად `string`) ან შესაძლოა დაკონვერტირდეს მასში (მაგალითად  `number` შესაძლოა დაკონვერტირდეს `string`-ში).
8. გამოიყენეთ ცვლადის ტიპი `any` რათა გამოტოვოთ ვალიდაცია როდესაც კონკრეტულ შრეზე ან როდესაც რამოდენიმე ცვლადის ტიპი უნდა იქნას მხარდაჭერილი.
9. მნიშვნელობა(Value) `{}` ზოგჯერ არის map ტიპისა მაგრამ ხანდახან არის  object ტიპის. გამოიყენეთ `tomap(...)` რათა შექმნა map იმ შემთხვევაში თუ შეზღუდულია object-ის შექმნა.

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

### `output`კოდის მაგალითი

დააბრუნეთ security group მხოლოდ ერთი ID:

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

ერთი და იმავე ტიპის მრავალი რესურსის არსებობისას, `this` უნდა იყოს გამოტოვებული Output სახელით:

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

### გამოიყენეთ მრავლობითი სახელი, თუ დაბრუნებული მნიშვნელობა არის სია

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
