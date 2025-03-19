# 命名規則

## 一般的な規則

{% hint style="info" %}
少なくともこれらの規則には従うべきですよ :)
{% endhint %}

{% hint style="info" %}
クラウドリソースの実際の名前には、多くの場合、使用可能な名前に制限があることに注意してください。例えば、一部のリソースではダッシュ（-）を含めることができなかったり、キャメルケースでなければならなかったりします。本書で説明する規則は、Terraform自体の名前に関するものです。
{% endhint %}

1. リソース名、データソース名、変数名、出力など、すべての場所で `-`（ダッシュ）の代わりに `_`（アンダースコア）を使用してください。
2. UTF-8がサポートされていても、小文字とアルファベットを使用することを推奨します。

リソースとデータソースの引数

1. リソース名にリソースタイプを（部分的にも、完全にも）繰り返さないでください：

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

2. より説明的で一般的な名前が利用できない場合、またはリソースモジュールがこのタイプのリソースを1つだけ作成する場合（例えば、[AWS VPCモジュール](https://github.com/terraform-aws-modules/terraform-aws-vpc)では `aws_nat_gateway` タイプのリソースは1つだけで、`aws_route_table` タイプのリソースは複数あるため、`aws_nat_gateway` は `this` という名前にし、`aws_route_table` には `private`、`public`、`database` のようなより説明的な名前をつけるべき）、リソース名は `this` にすべきです。
3. 名前には常に単数名詞を使用してください。
4. 引数の値の中や、人が目にする場所（例：RDSインスタンスのDNS名）では、`-`（ハイフン）を使用してください。
5. リソースまたはデータソースのブロック内で、`count`/`for_each`引数を最初の引数として一番上に記述し、その後に改行を入れて区切ってください。
6. リソースでサポートされている場合は`tags`引数を実質的な最後の引数として記述し、必要に応じてその後に`depends_on`と`lifecycle`を続けてください。これらはすべて空行1行で区切ってください。
7. `count`/`for_each`引数で条件を使用する場合は、`length`やその他の式を使用するのではなく、ブール値を使用することを推奨します。

## `resource`のコード例

### `count`と`for_each`の使用方法

{% hint style="success" %}
{% code title="main.tf" %}
```hcl
resource "aws_route_table" "public" {
  count = 2

  vpc_id = "vpc-12345678"
  # ... 残りの引数は省略
}

resource "aws_route_table" "private" {
  for_each = toset(["one", "two"])

  vpc_id = "vpc-12345678"
  # ... 残りの引数は省略
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

  # ... 残りの引数は省略
}
```
{% endcode %}
{% endhint %}

### `tags` の配置

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

### `count`内の条件

{% hint style="success" %}
{% code title="outputs.tf" %}
```hcl
resource "aws_nat_gateway" "that" {    # 最適
  count = var.create_public_subnets ? 1 : 0
}

resource "aws_nat_gateway" "this" {    # 良い
  count = length(var.public_subnets) > 0 ? 1 : 0
}
```
{% endcode %}
{% endhint %}

## 変数

1. リソースモジュールで車輪の再発明をしないでください：作業しているリソースの "Argument Reference" セクションで定義されている通りに、変数の`name`、`description`、`default`値を使用してください。
2. 変数のバリデーションサポートはかなり限定的です（例：他の変数へのアクセスや参照ができません）。多くの場合この機能は役に立たないので、それを考慮して計画してください。
3. 型が`list(...)`または`map(...)`の場合は、変数名に複数形を使用してください。
4. &#x20;変数ブロック内のキーは次の順序で並べてください：description、type、default、validation
5. 明白だと思える場合でも、将来必要になるので、すべての変数に必ずdescriptionを含めてください。
6. 各キーに厳密な制約が必要な場合を除き、`object()`のような特定の型よりも、シンプルな型（`number`、`string`、`list(...)`、`map(...)`、`any`）の使用を推奨します。
7. マップのすべての要素が同じ型（例：`string`）を持つ場合、または変換可能な場合（例：`number`型は`string`に変換可能）は、`map(map(string))`のような特定の型を使用してください。
8. 特定の深さから型バリデーションを無効にする場合や、複数の型をサポートする必要がある場合は、`any`型を使用してください。
9. 値`{}`は時にマップであり、時にオブジェクトです。オブジェクトを作成する方法がないため、マップを作成するには`tomap(...)`を使用してください。

## 出力

出力はスコープ外でも一貫性があり理解しやすいものにしてください（モジュールを使用するユーザーにとって、返される値の型と属性が明らかであるべきです）。

1. 出力名は、含まれるプロパティを説明するものであり、通常望むよりも自由度は低くすべきです。
2. 出力名の良い構造は`{name}_{type}_{attribute}`のようになります。ここで：
   1. `{name}`はリソースまたはデータソース名です
      * `data "aws_subnet" "private"`の`{name}`は`private`です
      * `resource "aws_vpc_endpoint_policy" "test"`の`{name}`は`test`です
   2. `{type}`はプロバイダーのプレフィックスを除いたリソースまたはデータソースの型です
      * `data "aws_subnet" "private"`の`{type}`は`subnet`です
      * `resource "aws_vpc_endpoint_policy" "test"`の`{type}`は`vpc_endpoint_policy`です
   3. `{attribute}`は出力によって返される属性です
   4. [例](naming.md#code-examples-of-output)を参照してください。
3. 出力が補間関数と複数のリソースを使用した値を返す場合、`{name}`と`{type}`はできるだけ一般的にすべきです（プレフィックスとしての`this`は省略すべき）。[例](naming.md#code-examples-of-output)を参照してください。
4. 返される値がリストの場合は、複数形の名前にすべきです。[例](naming.md#code-examples-of-output)を参照してください。
5. 明白だと思える場合でも、すべての出力に必ず`description`を含めてください。
6. すべてのモジュールのすべての場所でその出力の使用を完全に制御できない限り、`sensitive`引数の設定は避けてください。
7. （0.13以前のバージョンでの従来のアプローチである）`element(concat(...))`よりも（Terraform 0.13以降で利用可能な）`try()`を推奨します。

### `output`のコード例

セキュリティグループのIDを最大1つ返す場合：

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

同じタイプの複数のリソースがある場合、出力名では`this`を省略すべきです：

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

### 返される値がリストの場合は、複数形の名前を使用してください

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
