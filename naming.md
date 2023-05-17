# ನೇಮಿಂಗ್ conventionಗಳು

## ಜನರಲ್ conventionಗಳು

{% hint style="info" %}
ಕನಿಷ್ಠ ಈ conventionಗಳನ್ನು ಅನುಸರಿಸದಿರಲು ಯಾವುದೇ ಕಾರಣವಿರುವುದಿಲ್ಲ :)
{% endhint %}

{% hint style="info" %}
ನಿಜವಾದ ಕ್ಲೌಡ್ ಸಂಪನ್ಮೂಲಗಳು ಸಾಮಾನ್ಯವಾಗಿ ಅನುಮತಿಸಲಾದ ಹೆಸರುಗಳಲ್ಲಿ ನಿರ್ಬಂಧಗಳನ್ನು ಹೊಂದಿರುತ್ತವೆ ಎಂದು ಎಚ್ಚರವಹಿಸಿ. ಕೆಲವು ಸಂಪನ್ಮೂಲಗಳು, ಉದಾಹರಣೆಗೆ, ಡ್ಯಾಶ್ ಗಳನ್ನು ಹೊಂದಿರಬಾರದು, ಕೆಲವು ಕ್ಯಾಮೆಲ್ -ಕೇಸ್ ಆಗಿರಬೇಕು. ಈ ಪುಸ್ತಕದಲ್ಲಿನ conventionಗಳು ಟೆರಾಫಾರ್ಮ್ ಹೆಸರುಗಳನ್ನು ಉಲ್ಲೇಖಿಸುತ್ತವೆ
{% endhint %}

1. ಎಲ್ಲೆಡೆ - (ಡ್ಯಾಶ್) ಬದಲಿಗೆ \_ (ಅಂಡರ್ಸ್ಕೋರ್) ಬಳಸಿ (ಸಂಪನ್ಮೂಲ ಹೆಸರುಗಳು, ಡೇಟಾ ಮೂಲ ಹೆಸರುಗಳು, ವೇರಿಯಬಲ್ ಹೆಸರುಗಳು, ಔಟ್ಪುಟ್ಗಳು, ಇತ್ಯಾದಿ).
2. Lowercase ಅಕ್ಷರಗಳು ಮತ್ತು ಸಂಖ್ಯೆಗಳನ್ನು ಬಳಸಲು ಆದ್ಯತೆ ನೀಡಿ (UTF-8 ಅನ್ನು ಬೆಂಬಲಿಸಿದರೂ ಸಹ).

## ಸಂಪನ್ಮೂಲ ಮತ್ತು ಡೇಟಾ ಮೂಲ ಅರ್ಗುಮೆಂಟ್ ಗಳು (arguments)

1. ಸಂಪನ್ಮೂಲದ ಹೆಸರಿನಲ್ಲಿ ಸಂಪನ್ಮೂಲ ಪ್ರಕಾರವನ್ನು ಪುನರಾವರ್ತಿಸಬೇಡಿ (ಭಾಗಶಃವಾಗಿಯೂ ಅಲ್ಲ ಅಥವಾ ಸಂಪೂರ್ಣವಾಗಿಯೂ ಅಲ್ಲ):

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

1. ಹೆಚ್ಚಿನ ವಿವರಣಾತ್ಮಕ ಮತ್ತು ಸಾಮಾನ್ಯ ಹೆಸರು ಲಭ್ಯವಿಲ್ಲದಿದ್ದರೆ ಅಥವಾ ಸಂಪನ್ಮೂಲ ಮಾಡ್ಯೂಲ್ ಈ ಪ್ರಕಾರದ ಒಂದೇ ಸಂಪನ್ಮೂಲವನ್ನು ರಚಿಸಿದರೆ ಸಂಪನ್ಮೂಲ ಹೆಸರನ್ನುthis ಎಂದು ಹೆಸರಿಸಬೇಕು. (ಉದಾ, [AWS VPC](https://github.com/terraform-aws-modules/terraform-aws-vpc) ಮಾಡ್ಯೂಲ್‌ನಲ್ಲಿ `aws_nat_gateway` ಪ್ರಕಾರದ ಒಂದೇ ಸಂಪನ್ಮೂಲವಿದೆ ಮತ್ತು type `aws_route_table` ನ ಬಹು ಸಂಪನ್ಮೂಲಗಳು ಇವೆ . ಆದ್ದರಿಂದ `aws_nat_gateway` ಅನ್ನು this ಎಂದು ಹೆಸರಿಸಬೇಕು ಮತ್ತು `aws_route_table` ಹೆಚ್ಚು ವಿವರಣಾತ್ಮಕ ಹೆಸರುಗಳನ್ನು ಹೊಂದಿರಬೇಕು -(`private`, `public`, `database`).
2. ಹೆಸರುಗಳಿಗೆ ಯಾವಾಗಲೂ ಏಕವಚನ ನಾಮಪದಗಳನ್ನು ಬಳಸಿ.
3. ಬಳಕೆ: ಆರ್ಗ್ಯುಮೆಂಟ್‌ valueಗಳ ಒಳಗೆ.  value ಮಾನವನಿಗೆ ಕಾಣುವ ಸ್ಥಳಗಳಲ್ಲಿಇರಬೇಕು(ಉದಾ, RDS ನಿದರ್ಶನದ DNS ಹೆಸರಿನ ಒಳಗೆ).
4. ಆರ್ಗ್ಯುಮೆಂಟ್ `count` / `for_each`ನ ಇನ್‌ಸೈಡ್ ರಿಸೋರ್ಸ್ ಅಥವಾ ಡೇಟಾ ಸೋರ್ಸ್ ಬ್ಲಾಕ್ ಅನ್ನು ಮೇಲ್ಭಾಗದಲ್ಲಿ ಮೊದಲ ಆರ್ಗ್ಯುಮೆಂಟ್ ಆಗಿ ಸೇರಿಸಿ, ಮತ್ತು ಅದರ ನಂತರ ಹೊಸ ಸಾಲಿನ ಮೂಲಕ ಪ್ರತ್ಯೇಕಿಸಿ.
5. ಆರ್ಗ್ಯುಮೆಂಟ್ `tags`ಗಳನ್ನು ಸೇರಿಸಿ, ಸಂಪನ್ಮೂಲದಿಂದ ಬೆಂಬಲಿಸಿದರೆ, ಕೊನೆಯ ನೈಜ ಆರ್ಗ್ಯುಮೆಂಟ್ ಆಗಿ, ಅವಶ್ಯವಿದ್ದಲ್ಲಿ `depends_on` ಮತ್ತು `lifecycle` ಅನ್ನು ಅನುಸರಿಸಿ. ಇವೆಲ್ಲವನ್ನೂ ಒಂದೇ ಖಾಲಿ ಲೈನ್ ನಿಂದ ಬೇರ್ಪಡಿಸಬೇಕು.
6. `count` / `for_each` ಆರ್ಗ್ಯುಮೆಂಟ್‌ನಲ್ಲಿ ಷರತ್ತುಗಳನ್ನು ಬಳಸುವಾಗ `length` ಅಥವಾ ಇತರ ಅಭಿವ್ಯಕ್ತಿಗಳನ್ನು ಬಳಸುವ ಬದಲು, ಬೂಲಿಯನ್ ಮೌಲ್ಯಗಳಿಗೆ ಆದ್ಯತೆ ನೀಡಿ.

## `resource` ಕೋಡ್ ಉದಾಹರಣೆಗಳು

### `count` / `for_each`ನ ಬಳಕೆ

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

### `tags`ನಿಯೋಜನೆ

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

### &#x20;`count`ಅಲ್ಲಿ ಷರತ್ತುಗಳು

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

## ವೇರಿಯೇಬಲ್‌ಗಳು (Variables)

1. ಸಂಪನ್ಮೂಲ ಮಾಡ್ಯೂಲ್‌ಗಳಲ್ಲಿ ಬಹಳ ವಿಷಯಗಳನ್ನು ಮರು ಉಪಯೋಗಿಸಬಹುದು: ನೀವು ಕೆಲಸ ಮಾಡುತ್ತಿರುವ ಸಂಪನ್ಮೂಲಕ್ಕಾಗಿ"Argument Reference" ವಿಭಾಗದಲ್ಲಿ ವ್ಯಾಖ್ಯಾನಿಸಲಾದ `name`, `description`, ಮತ್ತು `default` ವೇರಿಯೇಬಲ್ ಗಳನ್ನು ಉಪಯೋಗಿಸಿರಿ.
2. ವೇರಿಯೇಬಲ್‌ಗಳಲ್ಲಿ ವ್ಯಾಲಿಡೇಷನ್ ಬೆಂಬಲವು ಸೀಮಿತವಾಗಿದೆ (ಉದಾ. ಇತರ ವೇರಿಯೇಬಲ್‌ಗಳನ್ನು ಆಕ್ಸೆಸ್ ಅಥವಾ ಲುಕಪ್‌ಗಳನ್ನು ಮಾಡಲು ಸಾಧ್ಯವಿಲ್ಲ). ಅನೇಕ ಸಂದರ್ಭಗಳಲ್ಲಿ ಈ ವೈಶಿಷ್ಟ್ಯವು ನಿಷ್ಪ್ರಯೋಜಕವಾಗಿರುವುದರಿಂದ ಅದಕ್ಕೆ ಅನುಗುಣವಾಗಿ ಯೋಜಿಸಿ.
3. ಟೈಪ್ ಗಳು `list(...)` ಅಥವ `map(...)`ಆದಾಗ ವೇರಿಯಬಲ್ ಹೆಸರಿನಲ್ಲಿ ಬಹುವಚನ ರೂಪವನ್ನು ಬಳಸಿ.
4. ವೇರಿಯೇಬಲ್ ಬ್ಲಾಕ್ ಗಳಲ್ಲಿ ಕೀ ಗಳನ್ನು ಈ ರೀತಿಯಾಗಿ ಒಂದಾದ ಮೇಲೆ ಇನ್ನೊಂದರಂತೆ ವ್ಯವಸ್ತಿತಗೊಳಿಸಿ: `description` , `type`, `default`, `validation`.
5. ವೇರಿಯೇಬಲ್ ಗಳಲ್ಲಿ `description` ತಪ್ಪದೇ ಹಾಕಿರಿ, ಅದು ಸ್ಪಷ್ಟವಾಗಿದ್ದರೂ ಸಹ (ನಿಮಗೆ ಮುಂದೆ ಬೇಕಾಗುತ್ತದೆ).
6. ಪ್ರತಿ ಕೀಯಲ್ಲಿ ನೀವು ಕಟ್ಟುನಿಟ್ಟಾದ constraint ಗಳನ್ನು ಹೊಂದಿರಬೇಕಿಲ್ಲದಿದ್ದರೆ, ನಿರ್ದಿಷ್ಟ ಪ್ರಕಾರಕ್ಕಿಂತ (`object())` ಸರಳ ಪ್ರಕಾರಗಳನ್ನು (`number`, `string`, `list(...)`, `map(...)`, `any`) ಬಳಸಲು ಆದ್ಯತೆ ನೀಡಿ.
7. ಮ್ಯಾಪ್ ನ ಎಲ್ಲಾ ಅಂಶಗಳು ಒಂದೇ ಟೈಪ್ ನವು (ಉದಾ:`string`) ಆಗಿದ್ದಲ್ಲಿ ಅಥವಾ ಪರಿವರ್ತಿಸಬಹುದಾಗಿದ್ದಲ್ಲಿ (ಉದಾ:`number` type can be converted to `string)` ನಿರ್ದಿಷ್ಟ ಟೈಪ್ ಗಳನ್ನು ಬಳಸಿ.
8. ನಿರ್ದಿಷ್ಟ ಆಳದಿಂದ ಪ್ರಾರಂಭವಾಗುವ ಟೈಪ್ ನ ವ್ಯಾಲಿಡೇಷನ್ ಅನ್ನು ನಿಷ್ಕ್ರಿಯಗೊಳಿಸಲು ಅಥವ ಬಹು ಟೈಪ್ ಗಳನ್ನು ಬೆಂಬಲಿಸಬೇಕಾದಾಗ `any` ಪ್ರಕಾರವನ್ನು ಬಳಸಿ
9. `{}`ಎನ್ನುವುದು ಕೆಲವೊಂದು ಸಲ ಮ್ಯಾಪ್ ಆಗಿರಬಹುದು ಅಥವ ಆಬ್ಜೆಕ್ಟ್ ಆಗಿರಬಹುದು. ಈ ತರಹ ಇದ್ದಲ್ಲಿ ಆಬ್ಜೆಕ್ಟ್ ಅನ್ನು`tomap(...)` ಬಳಸಿ ಮ್ಯಾಪ್ ಆಗಿ ಪರಿವರ್ತಿಸಿ, ಏಕೆಂದರೆ ಆಬ್ಜೆಕ್ಟ್ ಮಾಡಲು ಆಗುವುದಿಲ್ಲ.

## ಔಟ್‌ಪುಟ್‌ಗಳು

ಔಟ್‌ಪುಟ್‌ಗಳನ್ನು ಅದರ ವ್ಯಾಪ್ತಿಯ ಹೊರಗೆ ಸ್ಥಿರವಾಗಿ ಮತ್ತು ಅರ್ಥವಾಗುವಂತೆ ಮಾಡಿ (ಒಬ್ಬ ಬಳಕೆದಾರರು ಮಾಡ್ಯೂಲ್ ಅನ್ನು ಬಳಸುತ್ತಿರುವಾಗ ಅದು ಯಾವ ಟೈಪ್ ಮತ್ತು ಅಟ್ರಿಬ್ಯೂಟ್ ಅನ್ನು ಹಿಂದಿರುಗಿಸುತ್ತದೆ ಎಂಬುದು ಸ್ಪಷ್ಟವಾಗಿರಬೇಕು).

1. ಔಟ್‌ಪುಟ್‌ನ ಹೆಸರು ಅದು ಹೊಂದಿರುವ ಆಸ್ತಿಯನ್ನು ವಿವರಿಸಬೇಕು ಮತ್ತು ನೀವು ಸಾಮಾನ್ಯವಾಗಿ ಬಯಸುವುದಕ್ಕಿಂತ ಕಡಿಮೆ ಮುಕ್ತ-ರೂಪವಾಗಿರಬೇಕು.
2. ಔಟ್ಪುಟ್ ಹೆಸರಿನ ಉತ್ತಮ ರಚನೆಯು`{name}_{type}_{attribute}` ರೀತಿಯಲ್ಲಿ ಇರುತ್ತದೆ . ಇದರಲ್ಲಿ:
   1. `{name}`ಪೂರೈಕೆದಾರರ prefix ಇಲ್ಲದ ಸಂಪನ್ಮೂಲ ಅಥವಾ ಡೇಟಾ ಮೂಲದ ಹೆಸರು.`aws_subnet`ಗೆ  `{name} subnet`, `ws_vpc`ಗೆ ಅದು `vpc`.
   2. `{type}`ಒಂದು ರೀತಿಯ ಸಂಪನ್ಮೂಲ ಮೂಲವಾಗಿದೆ
   3. `{attribute}`ಔಟ್ಪುಟ್ ಮೂಲಕ ಹಿಂತಿರುಗಿಸಿದ ಅಟ್ರಿಬ್ಯೂಟ್ ಆಗಿದೆ
   4. &#x20;[ಉದಾ. ನೋಡಿ](naming.md#code-examples-of-output)
3. ಔಟ್‌ಪುಟ್ ಇಂಟರ್‌ಪೋಲೇಷನ್ ಫಂಕ್ಷನ್‌ಗಳ ಮತ್ತು ಬಹು ಸಂಪನ್ಮೂಲಗಳ ಮೂಲಕ value ವನ್ನು ಹಿಂತಿರುಗಿಸುತ್ತಿದ್ದರೆ,`{name}` ಮತ್ತು `{type}` ಸಾಧ್ಯವಾದಷ್ಟು generic ಆಗಿರಬೇಕು (`this` ಅನ್ನು prefix ಆಗಿ ಬಿಟ್ಟುಬಿಡಬೇಕು) [ಉದಾ. ನೋಡಿ](naming.md#code-examples-of-output)
4. ಹಿಂತಿರುಗಿಸಿದ value ಲಿಸ್ಟ್ ಆಗಿದ್ದರೆ ಅದು ಬಹುವಚನ ಹೆಸರನ್ನು ಹೊಂದಿರಬೇಕು. [ಉದಾ. ನೋಡಿ](naming.md#use-plural-name-if-the-returning-value-is-a-list).
5. ಔಟ್‌ಪುಟ್‌ಗಳಲ್ಲಿ `description` ತಪ್ಪದೇ ಹಾಕಿರಿ, ಅದು ಸ್ಪಷ್ಟವಾಗಿದ್ದರೂ ಸಹ (ನಿಮಗೆ ಮುಂದೆ ಬೇಕಾಗುತ್ತದೆ).
6. ಎಲ್ಲಾ ಮಾಡ್ಯೂಲ್‌ಗಳಲ್ಲಿ ಎಲ್ಲಾ ಸ್ಥಳಗಳಲ್ಲಿ ಈ ಔಟ್‌ಪುಟ್‌ನ ಬಳಕೆಯನ್ನು ನಿಮಗೆ ಸಂಪೂರ್ಣವಾಗಿ ನಿಯಂತ್ರಿಸಲು ಸಾಧ್ಯವಿಲ್ಲದಿದ್ದಲ್ಲಿ `sensitive` ಆರ್ಗ್ಯುಮೆಂಟ್ ಗಳ ಬಳಕೆಯನ್ನು ತಪ್ಪಿಸಿ.
7. `element(concat(...))`(0.13ಗಿಂತ ಹಿಂದಿನ ಆವೃತ್ತಿಗಳಿಗೆ) ಬದಲು `try()`ಗೆ ಆದ್ಯತೆ (ಟೆರಾಫಾರ್ಮ್ 0.13 ರಿಂದ ಲಭ್ಯವಿದೆ). &#x20;

### `output`ಕೋಡ್ ಉದಾಹರಣೆಗಳು

ಹೆಚ್ಚೆಂದರೆ ಭದ್ರತಾ ಗುಂಪಿನ ಒಂದು ID ಮಾತ್ರ ಹಿಂತಿರುಗಿಸಿ :

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

ಒಂದೇ ರೀತಿಯ ಬಹು ಸಂಪನ್ಮೂಲಗಳನ್ನು ಹೊಂದಿರುವಾಗ,`this` ಅನ್ನು ಔಟ್‌ಪುಟ್ ಹೆಸರಿನಲ್ಲಿ ಬಿಟ್ಟುಬಿಡಬೇಕು:

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

### ಹಿಂತಿರುಗಿಸುವ value, ಲಿಸ್ಟ್ ಆಗಿದ್ದರೆ, ಬಹುವಚನ ಹೆಸರನ್ನು ಬಳಸಿ

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
