# Convención del nombrado

### Convenciones generales

{% hint style="info" %}
No debería haber razón para no seguirlas.&#x20;
{% endhint %}

{% hint style="info" %}
Tenga en cuenta que los recursos reales de la nube a menudo tienen restricciones en los nombres permitidos. Algunos recursos, por ejemplo, no pueden contener guiones, algunos deben ser en una convención de mayúsculas y minúsculas conocido como _camel-case_. Las convenciones en este libro se refieren a los nombres propios de Terraform.
{% endhint %}

1. Utilizar _`_` _ (guión bajo) en lugar de `–` (guión) en todo: nombres de recursos, nombres de fuentes de datos -_data sources-_, nombres de variables, salidas -_outputs-_, etc.
2. &#x20;Utilizar preferentemente letras y números en letras pequeñas -_lowercased_- (incluso si UTF-8 es soportado).

### **Argumentos de recurso y fuente de datos**

&#x20;1\. No repetir el tipo de recurso en el nombre del recurso (ni de manera parcial, ni completa):

{% hint style="success" %}
`resource “aws_route_table” “public” {}`
{% endhint %}

{% hint style="danger" %}
`resource "aws_route_table" "public_route_table" {}`
{% endhint %}

{% hint style="danger" %}
`resource "aws_route_table" "public_aws_route_table" {}`
{% endhint %}

2\. El nombre del recurso debería ser `this` si no hay un nombre más descriptivo o general disponible, o si el módulo del recurso crea un recurso único de este tipo (por ejemplo, en el [<mark style="color:purple;">módulo de VPC de AWS</mark>](https://github.com/terraform-aws-modules/terraform-aws-vpc) sólo hay un recurso del tipo `aws_nat_gateway` y multiples recursos del tipo `aws_route_table`, así que `aws_nat_gateway` __ debería ser llamado `this` __ y `aws_route_table` __ debería tener nombres más descriptivos como `private`, `public`, `database`).

3\. Siempre utilizar sustantivos singulares para los nombres.

4\. Utilizar `–` dentro de los valores de los argumentos y en lugares en donde el valor será expuesto a un ser humano (por ejemplo, dentro del nombre del DNS o de una instancia RDS).

5\. Incluir el argumento `count`_/_`for each` dentro del bloque de recursos como primer argumento en la parte superior y separarlo por una nueva línea después de este.&#x20;

6\. Incluir el argumento `tags` __ si es soportado por el recurso como el último argumento real, seguido por `depends_on` y `lifecycle`, si es necesario. Todo esto debería ser separado por una sola línea vacía.&#x20;

7\. Cuando se utiliza un condición en el argumento `count`/`for each`, utilizar un valor booleano si esto tiene sentido, de otra forma, utilizar `length` u otra expresión.&#x20;

### Ejemplos del código de `recurso`

#### Uso de `count` / `for each`

{% hint style="success" %}
main.tf

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
{% endhint %}

{% hint style="danger" %}
main.tf

```hcl
resource "aws_route_table" "public" {
  vpc_id = "vpc-12345678"
  count  = 2

  # ... remaining arguments omitted
}
```
{% endhint %}

#### Colocación de `tags` -_etiquetas_-

{% hint style="success" %}
main.tf

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
{% endhint %}

{% hint style="danger" %}
main.tf

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
{% endhint %}

#### Condicionales en `count`

{% hint style="success" %}
outputs.tf

```hcl
resource "aws_nat_gateway" "that" {    # Best
  count = var.create_public_subnets ? 1 : 0
}

resource "aws_nat_gateway" "this" {    # Good
  count = length(var.public_subnets) > 0 ? 1 : 0
}
```
{% endhint %}

### Variables

1\. No reinventar la rueda en los módulos de recursos: usar los valores de variables `name`, `description` y `default` como se define en la sección “Referencia de Argumentos” para el recurso en el que estás trabajando.

2\. El soporte para la validación en variables es bastante limitado (por ejemplo, no se puede acceder a otras variables o realizar búsquedas). Planificar en consecuencia de esto porque en muchos casos esta característica es inútil.

3\. Utilizar la forma plural en un nombre de variable cuando el tipo sea `list (...)` o  `map(...)`.

4\. Ordenar las claves en un bloque variable como este: `description`, `type`, `default`, `validation`.

5\. Incluir siempre una `description` de todas las variables, incluso si cree que es obvio (lo necesitará en el futuro).

6\. Procurar usar tipos simples (`number`, `string`, `list(...)`, `map(...)`, `any`) sobre tipos específicos como `object()`a menos que necesite tener restricciones estrictas en cada clave.

7\. Utilizar tipos específicos como mapa `map(map(string))` si todos los elementos del mapa tienen el mismo tipo (por ejemplo, `string`) o se pueden convertir a él (por ejemplo, el tipo de `number` se puede convertir en `string`).

8\. Utilizar el tipo `any` para deshabilitar la validación de tipos a partir de una cierta profundidad o cuando deban admitirse varios tipos.

9\. El valor `{}` a veces es un mapa, pero a veces un objeto. Usar `tomap (...)` para hacer un mapa porque no hay forma de hacer un objeto.

### Outputs -_salidas_-

Nombrar las salidas -_outputs_- es importante para hacerlas consistentes y comprensibles fuera de su alcance (cuando el usuario está utilizando un módulo siempre debería de ser obvio qué tipo y atributo del valor es regresado).

1\. El nombre de la salida debe describir la propiedad que contiene y ser menos libre de lo que normalmente desearía.&#x20;

2\. Una buena estructura para el nombre de la salida se parece a `{name}_{type}_{attribute}` o `{nombre}_{tipo}_{atributo}` donde:

1. &#x20;`{name}` es un recurso o fuente de datos -_data sorce-_ sin un prefijo de proveedor. `{name}`  para `aws_subnet` es `subnet`, para`aws_vpc` es `vpc`.
2. `{type}` es un tipo de fuente de recursos.
3. `{attribute}` es un atributo devuelto por la salida o _output_.&#x20;
4. <mark style="color:purple;"></mark>[<mark style="color:purple;">Ver ejemplos</mark>](naming.md#ejemplos-del-codigo-de-output-salida).&#x20;

3\. Si la salida devuelve un valor con funciones de interpolación y varios recursos, `{name}` y `{type}` deben ser lo más genéricos posible (`this` como prefijo debe omitirse). [<mark style="color:purple;">Ver ejemplo</mark>](naming.md#ejemplos-del-codigo-de-output-salida).

4\. Si el valor devuelto es una lista, debe tener un nombre en plural. [<mark style="color:purple;">Ver ejemplo</mark>](naming.md#utilizar-el-nombre-en-plural-si-el-valor-devuelto-es-una-lista).

5\. Incluir siempre la `description` de todos las salidas, incluso si se cree que esta es obvia.

6\. Evitar establecer argumentos sensibles (`sensitive`)a menos que controle completamente el uso de dicha salida en todos los lugares de todos los módulos.

7\. Preferir el uso de `try()` (disponible desde Terraform 0.13) sobre `element(concat(...))` (enfoque heredado de versiones anteriores a la 0.13).

### Ejemplos del código de `output` -_salida_-

Devuelve como máximo una ID del grupo de seguridad:

{% hint style="success" %}
outputs.tf

```hcl
output "security_group_id" {
  description = "The ID of the security group"
  value       = try(aws_security_group.this[0].id, aws_security_group.name_prefix[0].id, "")
}
```
{% endhint %}

Cuando tenga varios recursos del mismo tipo, `this` debe omitirse en el nombre de la salida:

{% hint style="danger" %}
outputs.tf

```hcl
output "this_security_group_id" {
  description = "The ID of the security group"
  value       = element(concat(coalescelist(aws_security_group.this.*.id, aws_security_group.web.*.id), [""]), 0)
}
```
{% endhint %}

### Utilizar el nombre en plural si el valor devuelto es una lista

{% hint style="success" %}
outputs.tf

```hcl
output "rds_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = aws_rds_cluster_instance.this.*.endpoint
}
```
{% endhint %}
