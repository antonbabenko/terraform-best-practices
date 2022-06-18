# Namenskonventionen

## Allgemeine Konventionen

{% hint style="info" %}
Es sollte keinen Grund geben, nicht wenigstens diese Konventionen zu befolgen :)
{% endhint %}

{% hint style="info" %}
Beachten Sie, dass die tatsächlichen Cloud-Ressourcen oft Einschränkungen bei den zulässigen Namen haben. Einige Ressourcen dürfen zum Beispiel keine Bindestriche enthalten, andere müssen in Kamelschreibweise geschrieben werden. Die Konventionen in diesem Buch beziehen sich auf die Terraform-Namen selbst.
{% endhint %}

1. Verwenden Sie überall `_` (Unterstrich) anstelle von `-` (Bindestrich) (Ressourcennamen, Datenquellennamen, Variablennamen, Ausgaben usw.).
2. Verwenden Sie vorzugsweise Kleinbuchstaben und Zahlen (auch wenn UTF-8 unterstützt wird).

## Argumente für Ressourcen und Datenquellen

1.  Wiederholen Sie den Ressourcentyp nicht im Ressourcennamen (weder teilweise noch vollständig):

    {% hint style="success" %}
    `resource "aws_route_table" "public" {}`
    {% endhint %}

    {% hint style="danger" %}
    `resource "aws_route_table" "public_route_table" {}`
    {% endhint %}

    {% hint style="danger" %}
    `resource "aws_route_table" "public_aws_route_table" {}`
    {% endhint %}
2. Der Ressourcenname sollte `this` benannt werden, wenn kein beschreibender und allgemeiner Name verfügbar ist, oder wenn das Ressourcenmodul eine einzelne Ressource dieses Typs erstellt (z. B. gibt es im [AWS VPC-Modul](https://github.com/terraform-aws-modules/terraform-aws-vpc) eine einzelne Ressource des Typs `aws_nat_gateway` und mehrere Ressourcen des Typs `aws_route_table`, daher sollte `aws_nat_gateway` `this` benannt werden und `aws_route_table` sollte beschreibendere Namen haben - wie `private`, `public` oder `database`).
3. Verwenden Sie bei Namen immer die Einzahl.
4. Verwenden Sie `-` innerhalb von Argumenten und an Stellen, an denen der Wert für einen Menschen sichtbar ist (z. B. innerhalb des DNS-Namens der RDS-Instanz).
5. Fügen Sie das Argument `count` / `for_each` innerhalb des Ressourcen- oder Datenquellenblocks als erstes Argument oben ein und trennen Sie es danach durch einen Zeilenumbruch.
6. Fügen Sie das Argument `tags`, falls von der Ressource unterstützt, als letztes echtes Argument ein, gefolgt von `depends_on` und `lifecycle`, falls erforderlich. Alle diese Argumente sollten durch eine einzelne Leerzeile getrennt werden.
7. Bei der Verwendung von Bedingungen in einem `count` / `for_each` Argument sind boolesche Werte zu bevorzugen, anstatt `length` oder andere Ausdrücke zu verwenden.

## Code-Beispiele für `resource`

### Verwendung von `count` / `for_each`

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

### Platzierung von `tags`

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

### Bedingungen in `count`

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

## Variablen

1. Erfinden Sie das Rad in Ressourcenmodulen nicht neu: Verwenden Sie den Namen, die Beschreibung und den Standardwert für Variablen, wie sie im Abschnitt "Argumentreferenz" für die Ressource, mit der Sie arbeiten, definiert sind.
2. Die Unterstützung für die Validierung von Variablen ist ziemlich begrenzt (z.B. kann nicht auf andere Variablen zugegriffen werden oder Lookups durchgeführt werden). Planen Sie entsprechend, denn in vielen Fällen ist diese Funktion nutzlos.
3. Verwenden Sie die Pluralform in einem Variablennamen, wenn der Typ `list(...)` oder `map(...)` ist.
4. Ordnen Sie die Schlüssel in einem Variablenblock wie folgt an: `description` , `type`, `default`, `validation`
5. Fügen Sie immer eine `description` allen Variablen hinzu, auch wenn Sie denken, dass es offensichtlich ist (Sie werden es in Zukunft brauchen).
6. Verwenden Sie lieber einfache Typen (`number`, `string`, `list(...)`, `map(...),` `any`) als spezifische Typen wie `object()`, es sei denn, Sie müssen strenge Einschränkungen für jeden Schlüssel haben.
7. Verwenden Sie spezifische Typen wie `map(map(string))`, wenn alle Elemente der Map denselben Typ haben (z. B. `string`) oder in diesen umgewandelt werden können (z. B. kann der Typ `number` in `string` umgewandelt werden).
8. Verwenden Sie type `any`, um die Typüberprüfung ab einer bestimmten Tiefe zu deaktivieren oder wenn mehrere Typen unterstützt werden sollen.
9. Der Wert `{}` ist manchmal eine `map()` und manchmal ein `object()`. Verwenden Sie `tomap(...)`, um eine `map()` zu erstellen, da es keine Möglichkeit gibt, ein `object()` zu erstellen.

## Ausgaben

Machen Sie Ausgaben konsistent und verständlich außerhalb des Moduls (wenn ein Benutzer ein Modul verwendet, sollte es offensichtlich sein, welchen Typ und welches Attribut der Wert hat, den es zurückgibt).

1. Der Name der Ausgabe sollte die darin enthaltene Eigenschaft beschreiben und weniger frei formuliert sein, als Sie es normalerweise wünschen würden.
2. Eine gute Struktur für den Namen der Ausgabe sieht aus wie `{name}_{type}_{attribute}` , wobei:&#x20;
   1. `{name}` ein Ressourcen- oder Datenquellenname ohne Provider-Präfix ist. `{name}` für `aws_subnet` ist `subnet`, für `aws_vpc` ist es `vpc`.&#x20;
   2. `{type}` ist ein Typ einer Ressourcenquelle
   3. `{attribute}` ist ein Attribut, das von der Ausgabe zurückgegeben wird.
   4. [Siehe Beispiele](naming.md#code-examples-of-output).
3. Wenn die Ausgabe einen Wert mit Interpolationsfunktionen und mehreren Ressourcen zurückgibt, sollten `{name}` und `{type}` dort so allgemein wie möglich sein (`this` sollte als Präfix weggelassen werden). [Siehe Beispiel](naming.md#code-examples-of-output).
4. Wenn der zurückgegebene Wert eine Liste ist, sollte er einen Pluralnamen haben. [Siehe Beispiel](naming.md#code-examples-of-output).
5. Geben Sie immer eine `description` für alle Ausgaben an, auch wenn Sie denken, dass es offensichtlich ist.
6. Vermeiden Sie es, `sensitive` Argumente zu setzen, es sei denn, Sie kontrollieren die Verwendung dieser Ausgabe an allen Stellen in allen Modulen vollständig.
7. Bevorzugen Sie `try()` (verfügbar seit Terraform 0.13) gegenüber `element(concat(...))` (Legacy-Ansatz für die Version vor 0.13)

### Code-Beispiele für `output`

Höchstens eine ID einer Security-Gruppe ausgeben:

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

Wenn mehrere Ressourcen desselben Typs vorhanden sind, sollte `this` im Namen der Ausgabe weggelassen werden:

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

Pluralname verwenden, wenn der Rückgabewert eine Liste ist:

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

