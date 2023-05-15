# 命名约定

## 一般约定

{% hint style="info" %}
至少应该没有理由不遵循这些约定 :)
{% endhint %}

{% hint style="info" %}
请注意，实际的云资源通常对允许的名称有限制。 例如，有些资源不能包含破折号，有些资源必须采用驼峰式大小写。 本书中的约定指的是 Terraform 名称本身。
{% endhint %}

1. 在任何地方（资源名称、数据源名称、变量名称、输出等）使用 `_` (下划线) 而不是 `-` (破折号)。&#x20;
2. 非常适合使用小写字母和数字（即使支持 UTF-8）。

## 资源和数据源参数

1.  不要在资源名称中重复资源类型（既不要部分，更不要完全）：

    {% hint style="success" %}
    `resource "aws_route_table" "public" {}`
    {% endhint %}

    {% hint style="danger" %}
    `resource "aws_route_table" "public_route_table" {}`
    {% endhint %}

    {% hint style="danger" %}
    `resource "aws_route_table" "public_aws_route_table" {}`
    {% endhint %}
2. 如果没有更多的描述性和通用名称可用，或者如果资源模块创建这种类型的单个资源，资源名称应该被命名为`this`（例如，在[AWS VPC module](https://github.com/terraform-aws-modules/terraform-aws-vpc) 中有一个类型为 `aws_nat_gateway`的资源和多个类型为`aws_route_table`的资源，所以 `aws_nat_gateway` 应该命名为`this`，并且`aws_route_table` 应该有更具描述性的名称——比如`private`, `public`, `database）`。
3. 始终使用单数名词作为名称。
4. 在参数值内部和值将显示给人类的地方，使用`-`（例如，在 RDS 实例的 DNS 名称内部）。
5. 将参数`count` / `for_each` 包含在资源或数据源块中作为顶部的第一个参数，并在其后用换行符分隔。
6. 包括参数`tags,`如果资源支持，作为最后一个真正的参数，如果需要，后面是 `depends_on`和`lifecycle`。所有这些都应该用一个空行分隔。
7. `在参数count` / `for_each`中使用条件时，首选布尔值而不是使用 `length`或其他表达式。

## `resource`（资源）代码示例

### `count` / `for_each`的使用

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

### `tags`（标签）的放置

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

### `count`（计数）条件

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

## Variables（变量）

1. 不要在资源模块中重新造轮子：使用你正在使用的资源的“参数参考”部分中定义的变量 `name，description`和 `default`。
2. 对变量验证的支持相当有限（例如，无法访问其他变量或进行查找）。 相应地计划，因为在许多情况下此功能是无用的。
3. 当type是`list(...)` 或 `map(...)`，在变量名中使用复数形式。&#x20;
4. 在变量块中排序键，比如：`description`，`type`，`default`，`validation`。&#x20;
5. 始终包括对所有变量的`description`，即使你认为它很明显（将来你会需要它）。
6. 优先使用简单类型（`number`，`string`，`list(...)`，`map(...)`， `any`) 而不是像`object()`这样的特定类型，除非您需要对每个键都有严格的约束。
7. 如果map的所有元素都具有相同的类型（例如`string`）或可以转换为它（例如`number`类型可以转换为`string`），则使用特定类型，如`map(map(string))`。
8. 使用类型`any`来禁用从某个深度开始或者在支持多个类型时的类型验证。
9. 值`{}`有时是一个map，有时是一个对象。使用`tomap(...)` 制作map，因为没有办法制作对象。

## Outputs（输出）

使输出在其范围之外保持一致且易于理解（当用户使用模块时，它返回的值的类型和属性应该很明显）。

1. 输出的名称应该描述它包含的属性，并且不像你通常想要的那样自由。
2. 输出名称的良好结构类似于`{name}_{type}_{attribute}`，其中：
   1. `{name}`是没有提供者前缀的资源或数据源名称。`aws_subnet` 的`{name}是subnet`，`aws_vpc` 的`{name}`是`vpc`
   2. `{type}` 是一种资源来源
   3. `{attribute}`是输出返回的属性
   4. &#x20;参见示例 [See examples](naming.md#code-examples-of-output).
3. 如果输出返回一个带有插值函数和多个资源的值，`{name}` 和 `{type}` 应该尽可能通用（`this` 作为前缀应该省略）， 参见示例 [See example](naming.md#code-examples-of-output)。&#x20;
4. 如果返回值是一个列表，它应该有一个复数名称。 参见示例 [See example](naming.md#use-plural-name-if-the-returning-value-is-a-list)。&#x20;
5. 始终包括所有输出的`description`，即使你认为它很明显。&#x20;
6. 避免设置`sensitive`参数， 除非您完全控制此输出在所有模块的所有位置的使用。
7. 更喜欢`try()`（自 Terraform 0.13 起可用）而不是 `element(concat(...))`（0.13 之前版本的旧方法）。

### `output`（输出）代码示例

最多返回一个安全组ID：

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

当有多个相同类型的资源时，`this` 在输出名称中应省略：

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

### 如果返回值是列表，则使用复数名称

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

