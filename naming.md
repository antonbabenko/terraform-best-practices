# Convenções de nomenclatura

## Convenções gerais

{% hint style="info" %}
Não deve haver razão alguma para **não** seguir pelo menos essas convenções :)
{% endhint %}

{% hint style="info" %}
Esteja ciente de que os recursos reais da núvem geralmente têm restrições em nomes permitidos. Alguns recursos, por exemplo, não podem conter travessões, alguns devem ser em caixa de camelo (mais conhecido como [CamelCase](https://pt.wikipedia.org/wiki/CamelCase)). As convenções neste livro referem-se aos próprios nomes do Terraform.
{% endhint %}

1. Utilize `_` (subtraço) ao invés do `-` (traço) em todo o lugar (nomes de recursos, nomes de fontes de dados, nomes de variáveis, outputs, etc.).
2. Prefira usar letras minúsculas e números (mesmo que o UTF-8 seja suportado).

## Argumentos de recursos e fontes de dados

1.  Não repita a categoria de recurso no nome do recurso (não parcialmente, nem completamente):

    {% hint style="success" %}
    `resource "aws_route_table" "public" {}`
    {% endhint %}

    {% hint style="danger" %}
    `resource "aws_route_table" "public_route_table" {}`
    {% endhint %}

    {% hint style="danger" %}
    `resource "aws_route_table" "public_aws_route_table" {}`
    {% endhint %}
2. O nome do recurso deve ser nomeado `this` se não houver mais um nome descritivo e geral disponível ou se o módulo de recurso criar um único recurso desse tipo (por exemplo, no módulo [AWS VPC](https://github.com/terraform-aws-modules/terraform-aws-vpc) há um único recurso do tipo `aws_nat_gateway` e vários recursos do tupo`aws_route_table`, então `aws_nat_gateway`deve ser nomeado `this` e `aws_route_table` deve ter nomes mais descritivos - como `private`, `public`, `database`).
3. Sempre utilize substantivos singulares para nomes.
4. Utilize `-` em valores de argumentos e em locais onde o valor será exposto a um humano (por exemplo, no nome de DNS da instância RDS).
5. Inclua o(s) argumento(s) `count` / `for_each` no bloco de recurso ou fonte de dados como o primeiro argumento na parte superior e separe por uma nova linha depois dele.
6. Inclua o argumento `tags,` se suportadas pelo recurso, como o último argumento real, seguido por `depends_on` e `lifecycle`, se necessário. Estes devem ser separados por uma única linha vazia.
7. Ao utilizar condições em um argumento `count` / `for_each` , prefira valores boleanos (`true` / `false`) em vez de usar `length` ou outras expressões.

## Exemplos de código de `resource`

### Uso do `count` / `for_each`

{% hint style="success" %}
{% code title="main.tf" %}
```hcl
resource "aws_route_table" "public" {
  count = 2

  vpc_id = "vpc-12345678"
  # ... argumentos restantes omitidos
}

resource "aws_route_table" "private" {
  for_each = toset(["one", "two"])

  vpc_id = "vpc-12345678"
  # ... argumentos restantes omitidos
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

  # ... argumentos restantes omitidos
}
```
{% endcode %}
{% endhint %}

### Colocação das `tags`

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

### Condições com o `count`

{% hint style="success" %}
{% code title="outputs.tf" %}
```hcl
resource "aws_nat_gateway" "that" {    # Perfeito
  count = var.create_public_subnets ? 1 : 0
}

resource "aws_nat_gateway" "this" {    # Bom
  count = length(var.public_subnets) > 0 ? 1 : 0
}
```
{% endcode %}
{% endhint %}

## Variáveis

1. Não reinvente a roda em módulos de recursos: use `name`, `description`, e valor  `default` para variáveis conforme definido na seção “Referência de argumento” para o recurso com o qual você está trabalhando.
2. O suporte para validação em variáveis é bastante limitado (por exemplo, não pode acessar outras variáveis ou fazer pesquisas). Planeje de acordo porque em muitos casos esse recurso é inútil.
3. Use a forma plural em um nome de variável quando o tipo for `list(...)` ou `map(...)`.
4. Chaves de ordem em um bloco variável como: `description`, `type`, `default`, `validation`.
5. Sempre inclua `description` em todas as variáveis, mesmo que você julgue ser óbvio (você precisará disso, no futuro).
6. Prefira usar tipos simples (`number`, `string`, `list(...)`, `map(...)`, `any`) sobre tipos específicos como `object()`, a menos que você precise ter restrições estritas em cada chave.
7. Use tipos específicos como `map(map(string))` se todos os elementos do mapa tiverem o mesmo tipo (ex. `string`) ou podem ser convertidos para ele (ex. `number` pode ser convertido para `string`).
8. Use tipo `any` para desabilitar a validação de tipo a partir de uma determinada profundidade ou quando vários tipos devem ser suportados.
9. O valor `{}` às vezes é um mapa, mas às vezes é um objeto. Use `tomap(...)` para criar um mapa porque não há como criar um objeto.

## Outputs

Torne os outputs consistentes e compreensíveis fora de seu escopo (quando um usuário está usando um módulo, deve ser óbvio que tipo e atributo do valor ele retorna).

1. O nome do output deve descrever a propriedade que ela contém e ser menos livre do que você normalmente desejaria.
2. Uma boa estrutura para o nome do output parece com `{name}_{type}_{attribute}`, onde:
   1. `{name}`  um nome de recurso ou fonte de dados sem um prefixo de provedor. O `{name}` do `aws_subnet` é `subnet`, para o`aws_vpc` é `vpc`.
   2. `{type}` é um tipo de fontes de recursos.
   3. `{attribute}` é um atributo retornado pelo output.
   4. [Veja exemplos](naming.md#exemplos-de-codigo-do-output).
3. Se o output estiver retornando um valor com funções de interpolação e vários recursos, `{name}` e `{type}` devem ser o mais genéricos possível (`this` como prefixo deve ser omisso). [Veja exemplos](naming.md#exemplos-de-codigo-do-output).
4. Se o valor retornado for uma lista, deve ter um nome no plural. [Veja exemplos](naming.md#use-o-nome-no-plural-se-o-valor-de-retorno-for-uma-lista).
5. Sempre inclua `description` para todos os outputs mesmo que você julgue que ser óbvio.
6. Evite definir o argumento `sensitive`, a menos que você controle totalmente o uso desse output em todos os locais em todos os módulos.
7. Prefira `try()` (disponível desde o Terraform 0.13) ao invés de `element(concat(...))` (abordagem herdada para a versão anterior a 0.13).

### Exemplos de código do `output`

Retorne no máximo um ID do `security-group`:

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

Quando há vários recursos do mesmo tipo, `this` deve ser omisso no nome do output:

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

### Use o nome no plural se o valor de retorno for uma lista

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

