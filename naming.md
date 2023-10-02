# 명명 규칙

## 일반적인 규칙 <a href="#general-conventions" id="general-conventions"></a>

{% hint style="info" %}
이 규칙을 따르지 않을 이유가 없죠 :)
{% endhint %}

{% hint style="info" %}
실제 클라우드 리소스에는 허용되는 이름에 제한이 있는 경우가 많습니다. 예를 들어 일부 리소스에는 대시를 포함할 수 없으며 일부 리소스는 낙타 표기법(CamelCase)으로 표기해야 합니다. 이 책의 규칙은 Terraform 이름 자체를 나타냅니다.
{% endhint %}

1. 리소스 이름, 데이터 소스 이름, 변수 이름, 출력 등 모든 곳에서 `-`(대시, dash) 대신 `_`(밑줄)을 사용합니다.
2. (UTF-8이 지원되더라도) 소문자와 숫자를 사용하는 것이 좋습니다.

## 리소스 및 데이터 소스 인수 <a href="#undefined" id="undefined"></a>

1. (이름 일부 또는 전체를 포함해) 리소스 이름에 리소스 유형을 반복하지 마세요.

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

1. 보다 더 설명적이고 일반적인 이름을 사용할 수 없거나 리소스 모듈이 해당 유형에 대해 단 한 개의 리소스를 생성하는 경우(예: [AWS VPC module](https://github.com/terraform-aws-modules/terraform-aws-vpc)에는 `aws_nat_gateway` 유형의 리소스 한 개와 `aws_route_table` 유형의 리소스가 여러 개 있는 경우에 `aws_nat_gateway`는 `this`로, `aws_route_table`은 `private`, `public`, `database`와 같이 더 설명적인 이름을 지어줘야 합니다.
2. 이름에는 항상 단수 명사를 사용하세요.
3. 인수 값 내부와 값이 사람에게 노출되는 곳(예: RDS 인스턴스의 DNS 이름 내부)에는 `-`를 사용합니다.
4. 리소스 또는 데이터 소스 블록 내부에 인수 `count` / `for_each`를 맨 위의 첫 번째 인수로 포함하고 그 뒤는 줄바꿈으로 구분합니다.
5. 리소스에서 지원하는 경우 인수 `tags`를 마지막 실제 인수로 포함하고 필요한 경우 `depends_on` 및 `lifecycle`을 포함합니다. 이들 모두는 하나의 빈 줄로 구분되어야 합니다.&#x20;
6. 인수 `count` / `for_each`에 조건을 사용할 때는 `length`나 다른 표현식을 사용하는 대신 불(bool) 값을 쓰는 것이 좋습니다.

## `resource` 코드 예제

### `count` / `for_each`의 사용

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

### `tags`의 배치

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

### `count`의 조건

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

## 변수

1. 리소스 모듈의 바퀴를 다시 만들지 마세요(역주: Don't reinvent the wheel! 이미 만들어져서 잘 쓰이고 있는 것을 두고 굳이 비슷한 수준의 것을 새로 만드는 데 에너지를 쏟는 것을 피하라는 말). 작업 중인 리소스에 대한 "인수 참조" 섹션에 정의된 대로 변수에 대한 `name`, `description`, 및 `default`값을 사용하세요.
2. 변수의 유효성 검사에 대한 지원은 다소 제한적입니다(예: 다른 변수에 액세스하거나 조회를 수행할 수 없음). 대부분의 경우 이 기능은 쓸모가 없으므로 상황에 맞춰 계획하세요.
3. &#x20;유형이 `list(...)` 또는 `map(...)`인 경우 변수 이름에 복수형을 사용합니다.
4. 변수 블록의 키 순서를 다음과 같이 지정하세요: `description` , `type`, `default`, `validation`
5. 분명하다고 생각되더라도 항상 모든 변수에 대한 `description`(설명)을 포함하세요(향후 필요할 것입니다).
6. 각 키에 엄격한 제약을 적용할 필요가 없는 한 `object()`와 같은 특정 유형보다는 간단한 유형 (`number`, `string`, `list(...)`, `map(...)`, `any`)을 사용하는 것이 좋습니다.
7. 지도의 모든 요소가 동일한 유형(예: `string`문자열)이거나 해당 유형으로 변환될 수 있는 경우(예: `number` 숫자 유형을 `string` 문자열로 변환할 수 있는 경우) `map(map(string))`과 같은 특정 유형을 사용합니다.
8. 특정 깊이에서 시작하거나 여러 유형을 지원해야 하는 경우에 유형 유효성 검사를 비활성화하려면 `any` 유형을 사용하세요.
9. 값 `{}`은 지도일 때도 있고 객체일 때도 있습니다. 객체를 만들 수 있는 방법이 없기 때문에 지도를 만들려면 `tomap(...)`을 사용하세요.

## 출력(outputs)

모듈의 범위 밖에서도 출력을 일관되고 이해하기 쉽게 만드세요(사용자가 모듈을 사용할 때 반환되는 값의 유형과 속성이 무엇인지 명확해야 합니다).

1. 출력 이름은 자신이 포함하는 속성을 설명해야 하며 일반적으로 우리가원하는 것보다는 형식이 덜 자유롭습니다.
2. 출력 이름에 적합한 구조는 `{name}_{type}_{attribute}`이며 다음을 참고하세요.
   1. `{name}`은 프로바이더 접두사가 없는 리소스 또는 데이터 소스 이름입니다. `aws_subnet`의 `{name}`은 `subnet`이고, `aws_vpc`의 경우 `vpc`입니다.
   2. `{type}`은 리소스 소스의 유형입니다.
   3. `{attribute}`는 출력이 반환하는 속성입니다.
   4. [예제 보기](naming.md#code-examples-of-output).
3. 출력이 보간 함수 및 여러 리소스가 포함된 값을 반환하는 경우 `{name}` 및 `{type}`은 가능한 한 일반적이어야 합니다(접두사로 `this`는 생략해야 함). [예를 참조하세요](naming.md#code-examples-of-output).&#x20;
4. 반환된 값이 리스트인 경우 복수형 이름을 가져야 합니다. [예를 참조하세요](naming.md#.).&#x20;
5. 분명하다고 생각되더라도 항상 모든 변수에 대한 `description`(설명)을 포함하세요.
6. 모든 모듈의 모든 위치에서 이 출력의 사용을 완전히 제어할 수 있는 게 아니라면 `sensitive` 인수를 설정하지 마세요.
7. `element(concat(...))`(0.13 이전 버전의 레거시 접근 방식)보다 `try()`(Terraform 0.13부터 사용 가능)를 쓰는 것이 좋습니다.

### `output`  코드 예제 <a href="#code-examples-of-output" id="code-examples-of-output"></a>

보안 그룹의 ID를 최대 1개 반환합니다

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

동일한 유형의 리소스가 여러 개 있는 경우 출력 이름에서 `this`를 생략해야 합니다.

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

### 반환 값이 리스트인 경우 복수형 이름을 사용하세요.

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
