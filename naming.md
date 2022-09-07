# Convenții de numire

## Convenții generale

{% hint style="info" %}
Nu există niciun motiv să nu se respecte măcar aceste convenții :)&#x20;
{% endhint %}

{% hint style="info" %}
Atenție că resursele din cloud în realitate au adesea restricții în numele permise. Unele resurse, de exemplu, nu pot conține cratimă, unele trebuie sa fie cu majuscule mediale (CamelCase). Convenția din aceasta carte se referă la numele din Terraform în sine.
{% endhint %}

1. Folosiți `_` (underscore) în loc de  `-` (cratimă) peste tot (numele resurselor, numele surselor de date, numele variabilelor, outputs, etc).
2. De preferat să utilizați litere mici și cifre (chiar dacă UTF-8 este acceptat).

## Argumentele resurselor și surselor de date

1.  Nu repetați tipul de resursă în numele resursei (nu parțial, nici complet):&#x20;

    {% hint style="success" %}
    `resource "aws_route_table" "public" {}`
    {% endhint %}

    {% hint style="danger" %}
    `resource "aws_route_table" "public_route_table" {}`
    {% endhint %}

    {% hint style="danger" %}
    `resource "aws_route_table" "public_aws_route_table" {}`
    {% endhint %}
2. &#x20;Numele resursei ar trebui să fie ales `this` dacă nu mai există un nume descriptiv și general disponibil sau dacă modulul de resurse creează o singură resursă de acest tip (ex.: în [AWS VPC module](https://github.com/terraform-aws-modules/terraform-aws-vpc) există o singură resursă de tip `aws_nat_gateway` ași resurse multiple de tip`aws_route_table`, așadar `aws_nat_gateway` ar trebui să primească numele `this` și `aws_route_table` ar trebui să primească nume mai descriptive - cum ar fi `private`, `public`, `database`).
3. Folosiți întotdeauna substantive la singular pentru nume.
4. Folosiți `-` în interiorul valorilor argumentelor și în locurile în care valoarea va fi expusă unui om (ex.: în interiorul numelui DNS al instanței RDS).
5. Includeți argumentul`count` / `for_each` în interiorul blocului de resurse sau sursă de date ca prim argument în partea de sus și separat prin linie nouă după acesta.
6. Includeți argumentul `tags,` dacă este suportat de resursă, ca ultimul argument real, urmat de `depends_on` și `lifecycle`, dacă este necesar. Toate acestea ar trebui separate printr-o singură linie goală.
7. Când folosiți condiții într-un argument`count` / `for_each` este de preferat să se folosească valori booleene în loc de `length` sau alte expresii.

## Exemple de cod pentru resurse (`resource)`

### Folosirea `count` / `for_each`

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

### Folosirea `tags`

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

### Condiții în `count`

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

## Variabile

1. Nu reinventați roata în modulele de resurse: folosiți `name`, `description`, și valoarea `default` pentru variabile cum sunt definite în  secțiunea "Argument Reference" (din documentația oficială Terraform) pentru resursa de care aveți nevoie.
2. Suportul pentru validarea variabilelor este destul de limitat (de exemplu, nu pot accesa alte variabile sau nu pot face căutări). Planificați în consecință, deoarece în multe cazuri această caracteristică este inutilă.
3. Utilizați forma de plural într-un nume de variabilă atunci când tipul este `list(...)` sau `map(...)`.
4. Ordonați cheile într-un bloc de variabilă astfel: `description` , `type`, `default`, `validation`.
5. Includeți întotdeauna `description` pentru toate variabilele chiar dacă vi se pare că este evident (veți avea nevoie de aceasta în viitor).
6. De preferință, alegeți folosirea unor tipuri simple (`number`, `string`, `list(...)`, `map(...)`, `any`) în loc de tipuri ca `object()` cu excepția cazului în care trebuie să aveți constrângeri stricte pentru fiecare cheie.
7. De preferință, alegeți folosirea tipurilor specifice, ca`map(map(string))` dacă toate elementele din map au același tip (ex.: `string`) sau pot fi convertite (ex.: tipul `number` poate fi convertit la tipul `string`).
8. Utilizați tipul `any` pentru a dezactiva validarea tipului începând de la o anumită adâncime sau atunci când mai multe tipuri ar trebui să fie acceptate.
9. Valoarea `{}` este uneori de tip map (hartă), dar alteori un obiect. Utilizați `tomap(...)` pentru a face o hartă pentru că nu există nicio modalitate de a face un obiect.

## Outputs

Faceți rezultatele (outputs) consistente și ușor de înțeles în afara domeniului de aplicare (atunci când un utilizator folosește un modul, ar trebui să fie evident care este tipul și atributul valorii returnate).

1. Numele rezultatului ar trebui să descrie proprietatea pe care o conține și să aibă o formă mai puțin liberă decât v-ați dori în mod normal
2. O structură bună pentru numele de ieșire arată ca `{name}_{type}_{attribute}` , unde:
   1. `{name}` este o resursă sau un nume de sursă de date fără prefix de furnizor. `{name}` pentru `aws_subnet` este `subnet`, pentru`aws_vpc` este `vpc`.
   2. `{type}` este un tip de sursă de resurse.
   3. `{attribute}` este un atribut returnat de rezultate (outputs).
   4. [Vezi exemple](naming.md#exemple-de-cod-pentru-output).
3. Dacă rezultatul returnează o valoare cu funcții de interpolare și resurse multiple, `{name}` și `{type}` ar trebui să fie cât mai generice (`this` ca prefix ar trebui să fie omis). [Vezi exemple](naming.md#exemple-de-cod-pentru-output).
4. Dacă valoarea returnată este o listă, aceasta ar trebui să aibă un nume la plural.[ Vezi exemplu](naming.md#folositi-numele-la-plural).
5. Includeți întotdeauna `description` pentru toate rezultatele (outputs) chiar dacă credeți că este ceva evident.
6. Evitați setarea `sensitive` pentru argumente cu excepția cazului în care controlați pe deplin utilizarea acestui rezultat în toate locurile din toate modulele.
7. De preferință, alegeți`try()` (disponibil începând cu Terraform 0.13) în loc de `element(concat(...))` (abordarea legacy folosită înainte de versiunea 0.13)

### Exemple de cod pentru `output` <a href="#exemple-de-cod-pentru-output" id="exemple-de-cod-pentru-output"></a>

Returnați cel mult un ID al grupului de securitate:

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

Când aveți mai multe resurse de același tip, `.this` ar trebui să fie omis în numele ieșirii:

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

### Folosiți numele la plural dacă valoarea returnată este o listă <a href="#folositi-numele-la-plural" id="folositi-numele-la-plural"></a>

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

