# Convenzioni sui nomi

## Convenzioni generali&#x20;

{% hint style="info" %}
Non ci dovrebbero essere ragioni per non seguire queste convenzioni  :)
{% endhint %}

{% hint style="info" %}
Presta attenzione che le risorse cloud hanno spesso restrizioni sui nomi consentiti. Alcune risorse, per esempio, non possono contenere il trattino "-", alcune devono essere camel-cased. Le convenzioni nel libro si riferiscono ai nomi Terraform.&#x20;
{% endhint %}

1. Usa `_` (trattino basso) invece del `-` (trattino) ovunque (nomi sul tipo resourse, nomi sul tipo data, nomi di variabili, outputs, ecc).
2. Preferisci l'uso di lettere minuscole e numero (perfino dove é supportato UTF-8).

## Argomenti di resource and data source

1.  Non ripetere il tipo di risorsa nel nome della risorsa (ne parzialmente ne interamente):

    {% hint style="success" %}
    `resource "aws_route_table" "public" {}`
    {% endhint %}

    {% hint style="danger" %}
    `resource "aws_route_table" "public_route_table" {}`
    {% endhint %}

    {% hint style="danger" %}
    `resource "aws_route_table" "public_aws_route_table" {}`
    {% endhint %}
2. Il nome delle risorse dovrebbe essere chiamato`this` se non c'è disponibile un nome più descrittivo e generale, o se il modulo di risorsa crea una singola risorsa di questo tipo (per esempio, in [AWS VPC module](https://github.com/terraform-aws-modules/terraform-aws-vpc) c'è una singola risorsa di tipo `aws_nat_gateway` e risorse multiple di tipo `aws_route_table`, quindi `aws_nat_gateway` dovrebbe essere chiamato `this` e `aws_route_table` dovrebbe avere un nomi più descrittivi come per esempio `private`, `public`, `database`).
3. Usare sempre nomi al singolare.
4. Usa`-` (il trattino )dentro i valori degli argomenti interni e in posti dove i valori sono esposti agli essere umani (per esempio, dentro i nomi DNS o le istanze RDS).
5. Includi l'argomento `count` / `for_each` dentro la risorsa o il blocco di data source come primo argomento in cima separalo da una nuova linea dopo di lui.
6. Includi argomenti di tipo `tags,` se supportati dalla risorsa, come ultimo argomento, seguito dal `depends_on` e `lifecycle`, se necessario. Tutti questi dovrebbero essere separati da una singola linea vuota.&#x20;
7. Quando si usano le condizioni in un argomento `count` / `for_each` preferisci valori boleani invece di usare `length` o un'altra espressione.

## Esempi di codice di `resource`

### Uso di `count` / `for_each`

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

### Posizionamento di `tags`

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

### Condizioni in `count`

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

## Variabili

1. Non reinventare la ruota in moduli risorsa: usa `name`, `description`, e il valore di`default` per le variabili come sono definitie nella sezione "Argument Reference" per le risorse con cui stai lavorando.
2. Il supporto per la validazione nelle variabili è piuttosto limitato (per esempio non è possibile accedere a altre variabili o fare lookups). Bisogna tenerne conto perchè in molti casi questa feature è inutile.&#x20;
3. Usare la forma plurale nel nome delle variabili quando il tipo è `list(...)` o `map(...)`.
4. Ordina le chiavi in un blocco per le variabil in questo modo: `description` , `type`, `default`, `validation`.
5. Includere sempre la descrizione `description` su tutte le variabili perfino se pensi che è ovvio  (potresti averne bisogno in futuro).
6. Usa se è possibile tipi semplici (`number`, `string`, `list(...)`, `map(...)`, `any`) invece di tipi specifici come `object()` a meno che hai bisogno di fare costrizioni specifiche su ogni chiave.&#x20;
7. Usa tipi specifici come `map(map(string))` se tutti gli elementi della mappa hanno lo stesso tipo (per esempio `string`) o possono essere convertiti (per esempio il tipo `number` può essere convertito in una `string`).
8. Usa il tipo `any`, la validazione sul tipo iniziando da una certa profondità o quando tipo multipli dovrebbero essere supportati.
9. Value `{}` alcune volte è una map ma altre volte un object. Usa `tomap(...)` per creare una map in questo modo sei sicuro di non fare un oggetto.&#x20;

## Outputs

Fai in modo che gli  outputs siano consistenti e comprensibilit fuori dal loro raggio d'azione (quando un utente sta usando un modulo dovrebbe essere ovvio cosa un tipo o il valore di un attributo restituiscono).

1. Il nome di un output dovrebbe descrivere la proprietà che contiene ed essere meno libero della forma che normalmente vorresti.&#x20;
2. Una buona struttura per il nome di un output apparirà in questa maniera `{name}_{type}_{attribute}` , dove:
   1. `{name}` è una risorsa o un data source senza il prefisso del provider. `{name}` per `aws_subnet` è `subnet`, per`aws_vpc` è`vpc`.
   2. `{type}` è un tipo di una  risorsa sorgente
   3. `{attribute}` è un attributo restituito da un output
   4. [Vedi gli esempi](naming.md#code-examples-of-output).
3. Se l'output sta restituendo un valore con funzioni di interpolazione e risorse multiple, `{name}` e `{type}` dovrebbero essere quanto più generici possibile  (`this` è un prefisso e dovrebbe essere omesso). [Vedi gli esempi](naming.md#code-examples-of-output).
4. Se il valore restituito è una lista dovrebbe avere un nome plurale. [Vedi gli esempi](naming.md#use-plural-name-if-the-returning-value-is-a-list).
5. Includere sempre la descrizione`description` per tutti gli output anche se pensi che sia ovvio.
6. Evita di settare argomenti `sensitive` a meno che hai il controllo totale su tutti gli output in tutti i punti dei moduli.&#x20;
7. Preferisci l'uso di `try()` (disponibile da Terraform 0.13) invece di `element(concat(...))` (approccio legacy per le versioni prima della 0.13)

### Esempi di codice di `output`

Restituire al massimo un security group ID:

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

Quando abbiamo risorse multiple dello stesso tipo, `this` dovrebbe essere omesso nel nome dell'output:

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

### Usare un nome pluralre se il valore restituito e' una lista

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

