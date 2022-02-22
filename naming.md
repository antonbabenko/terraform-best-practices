# Konwencje nazewnictwa

## Podstawowe zasady

{% hint style="info" %}
Nie ma powodu, aby nie przestrzegać przynajmniej poniższych zasad :)
{% endhint %}

{% hint style="info" %}
Pamiętaj, że rzeczywiste zasoby często mają ograniczenia w dopuszczalnym nazewnictwie. Niektóre zasoby, na przykład nie mogą zawierać myślników. Inne zaś muszą być napisane z wykorzystaniem camelCase. Konwencje zawarte w tej książce odnoszą się tylko do samych nazw Terraform.
{% endhint %}

1. Wszędzie używaj `_` (podkreślenia) zamiast `-` (myślnika) (nazwy zasobów, nazwy źródeł danych, nazwy zmiennych, dane wyjściowe itp.).
2. Staraj się używać małych liter i cyfr (nawet jeśli obsługiwany jest kod UTF-8).

## Zasoby i źródła danych

1.  Nie powtarzaj typu zasobu w nazwie zasobu (ani częściowo, ani całkowicie):

    {% hint style="success" %}
    `resource "aws_route_table" "public" {}`
    {% endhint %}

    {% hint style="danger" %}
    `resource "aws_route_table" "public_route_table" {}`
    {% endhint %}

    {% hint style="danger" %}
    `resource "aws_route_table" "public_aws_route_table" {}`
    {% endhint %}
2. Nazwa zasobu powinna nazywać się `this`, jeśli nie ma bardziej opisowej i ogólnej nazwy, lub jeśli moduł zasobów tworzy pojedynczy zasób tego typu (np. w module [AWS VPC](https://github.com/terraform-aws-modules/terraform-aws-vpc) jest pojedynczy zasób typu `aws_nat_gateway` i wiele zasobów typu `aws_route_table`, więc `aws_nat_gateway` powinien nazywać się `this`, a `aws_route_table` powinny być nazwane opisowe - jak `private`, `public`, `database`.
3. Nazwy zawsze powinny być rzeczownikami w liczbie pojedynczej.
4. Używaj `-` wewnątrz wartości argumentów oraz w miejscach, w których wartość będą odczytywane przez człowiekowa (np. wewnątrz nazwy DNS instancji RDS).
5. Argumenty `count` lub `for_each` umieszczaj wewnątrz bloku zasobu lub źródła danych jako pierwszy argument u góry i oddzielaj go znakiem nowej linii.
6. Argument `tags`, jeśli jest obsługiwany przez zasób, umieszczaj jako ostatni , po którym następuje `depend_on` i `lifecycle`, jeśli to konieczne. Wszystkie te elementy powinny być oddzielone pojedynczym pustym wierszem.
7. Używając warunków logicznych przy argumencie `count` lub `for_each` stosuj wartości logiczne zamiast porównywania długości ciągu czy innych wyrażeń.

## Przykładowy kod zasobu (`resource`)

### Użycie `count` / `for_each`

{% hint style="success" %}
{% code title="main.tf" %}
```hcl
resource "aws_route_table" "public" {
  count = 2

  vpc_id = "vpc-12345678"
  # ... w celu uproszczenia pomijamy pozostałe argumenty
}

resource "aws_route_table" "private" {
  for_each = toset(["one", "two"])

  vpc_id = "vpc-12345678"
  # ... w celu uproszczenia pomijamy pozostałe argumenty
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

  # ... w celu uproszczenia pomijamy pozostałe argumenty
}
```
{% endcode %}
{% endhint %}

### Umiejscowienie `tags`

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

### Warunki w `count`

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

## Zmienne

1. Nie próbuj na nowo wymyślać koła w modułach zasobów: użyj nazwy (`name`), opisu (`description`) i wartości domyślnej (`default`) dla zmiennych zgodnie z definicją w sekcji „Odniesienie do argumentów” ("Argument Reference") dla zasobu, z którym pracujesz.
2. Obsługa walidacji w zmiennych jest raczej ograniczona (np. brak dostępu do innych zmiennych lub wyszukiwania). Zawczasu planuj odpowiednie użycie, ponieważ w wielu przypadkach funkcja walidacji jest bezużyteczna.
3. Używaj liczby mnogiej w nazwie zmiennej, gdy jest ona listą (`list(...)`) lub mapą (`map(...)`) .
4. Uporządkuj klucze w bloku zmiennych w następujący sposób: opis (`description`), typ (`type`), wartość domyślna (`default`), walidacja (`validation`).
5. Zawsze dołączaj opis (`description`) do wszystkich zmiennych, nawet jeśli uważasz, że jest to oczywiste (przyda się w przyszłości).
6. Używaj prostych typów (`number`, `string`, `list(...)`, `map(...)`, `any`) zamiast określonego typu, takiego jak `object()`, chyba że musisz mieć ścisłą kontrolę nad każdym elementem.
7. Użyj określonych typów, np. `map(map(string))` jeśli wszystkie elementy mapy mają ten sam typ (np. `string` ) lub mogą być na niego przekonwertowane (np. typ `number` można przekonwertować na `string`).
8. Użyj `any`, aby ominąć walidację typu, gdy chcesz obsłużyć różne typy..
9. Wartość `{}` to czasami mapa, a czasami obiekt. Użyj `tomap(...)`, aby stworzyć mapę, ponieważ nie ma możliwości stworzenia obiektu.

## Dane wyjściowe

Spraw, aby dane wyjściowe były spójne i zrozumiałe poza zakresem użycia (scope) (gdy użytkownik korzysta z modułu, powinno być oczywiste, jaki jest typ i atrybut zwracanej wartości).

1. Nazwa danych wyjściowych powinna opisywać właściwość, którą zawiera, i być bardziej ścisła niż standardowo.
2. Dobra struktura nazwy wyjścia wygląda tak: `{name}_{type}_{attribute}` , gdzie:
   1. `{name}` to nazwa zasobu lub źródła danych bez prefiksu dostawcy. `{name}` dla `aws_subnet` to `subnet`, a dla `aws_vpc` to `vpc`.
   2. `{type}` to rodzaj źródła zasobów.
   3. `{attribute}` to zwracany atrybut
   4. [Zobacz przykłady](naming.md#code-examples-of-output).
3. Jeśli zwracana jest wartość z funkcjami interpolacji i wieloma zasobami, `{name}` i `{type}` powinny być jak najbardziej ogólne (należy unikać prefiksu `this`). [Zobacz przykłady](naming.md#code-examples-of-output).
4. Jeśli zwracana wartość jest listą, powinna mieć nazwę w liczbie mnogiej. [Zobacz przykłady](naming.md#use-plural-name-if-the-returning-value-is-a-list).
5. Zawsze dołączaj opis (`description`) danych wyjściowych, nawet jeśli uważasz, że jest to oczywiste.
6. Unikaj użycia `sensitive`, chyba że w pełni kontrolujesz użycie tego wyjścia (danych wyjściowych) we wszystkich miejscach i we wszystkich modułach.
7. Stosuj `try()` (dostępne od Terraform 0.13) zamiast `element(concat(...))` (podejście starsze dla wersji przed 0.13)

### Przykłady poprawnego `output`

Zwróć co najwyżej jeden identyfikator `security_group`:

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

W przypadku posiadania wielu zasobów tego samego typu, należy unikać `this` w nazwie wyjścia:

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

### Użyj nazwy w liczbie mnogiej, jeśli wartością zwracaną jest lista

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

