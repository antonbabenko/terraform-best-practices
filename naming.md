# Convention des noms

## Conventions générales

{% hint style="info" %}
Il ne devrait y avoir aucune raison de ne pas suivre au moins ces conventions :)
{% endhint %}

{% hint style="info" %}
Prenez notes que les ressources réelles dans le cloud ont souvent des restrictions dans les noms autorisés. Certaines ressources, par exemple, ne peuvent pas contenir de tirets, certaines doivent être en camel-case. Les conventions de ce livre font référence aux noms Terraform eux-mêmes.
{% endhint %}

1. Utilisez `_` (surligné) au lieu de `-` (tiret) partout (noms des ressources, noms des sources de données, noms des variables, sorties, etc.).
2. Préférez les lettres minuscules et les chiffres (même si UTF-8 est pris en charge).

## Arguments de ressource et de source de données

1.  Ne répétez pas le type de ressource dans le nom de la ressource (ni partiellement, ni complètement) :

    {% hint style="success" %}
    `resource "aws_route_table" "public" {}`
    {% endhint %}

    {% hint style="danger" %}
    `resource "aws_route_table" "public_route_table" {}`
    {% endhint %}

    {% hint style="danger" %}
    `resource "aws_route_table" "public_aws_route_table" {}`
    {% endhint %}
2. Le nom de la ressource doit être ainsi donné s'il n'y a plus de nom descriptif et général disponible, ou si le module de ressources crée une seule ressource de ce type (par exemple, dans [AWS VPC module](https://github.com/terraform-aws-modules/terraform-aws-vpc) il y a une seule ressource de type `aws_nat_gateway` et plusieurs ressources de type`aws_route_table`, donc `aws_nat_gateway` pourrait être nommé `this` et`aws_route_table` devrait avoir des noms plus descriptifs - comme `private`, `public`, `database`).
3. Toujours utilisez des noms au singulier.
4. Utiliser - à l'intérieur des valeurs des arguments et aux endroits où la valeur sera exposée à un humain (par exemple, à l'intérieur du nom DNS de l'instance RDS).
5. Inclure l'argument `count` / `for_each` à l'intérieur du bloc de ressource ou de source de données comme premier argument en haut et séparé par une nouvelle ligne après celui-ci.
6. Inclure l'argument `tags,`si pris en charge par ressource, comme dernier argument réel, suivi de `depends_on` et`lifecycle`, si necessaire. Tous ces éléments doivent être séparés par une seule ligne vide.
7. Lorsque vous utilisez des conditions dans un argument`count` / `for_each,` il est préférable d'employer les valeurs booléennes au lieu de`length` ou d'autres expressions.

## Exemples de  code de `ressource`

### Utilisation de `count` / `for_each`

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

### Emplacement de `tags`

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

### Conditions dans `count`

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

## Variables

1. Ne réinventez pas la roue dans les modules de ressources : utilisez le nom, la description et la valeur par défaut des variables telles que définies dans la section "Référence des arguments" pour la ressource avec laquelle vous travaillez.
2. La prise en charge de la validation dans les variables est plutôt limitée (par exemple, impossible d'accéder à d'autres variables ou de faire des recherches). Planifiez en conséquence car dans de nombreux cas, cette fonctionnalité est inutile.
3. Utilisez la forme plurielle dans un nom de variable lorsque type est `list(...)` ou `map(...)`.
4. Ordonner les clés dans un bloc variable comme ceci: `description` , `type`, `default`, `validation`.
5. Toujours inclure `description` sur toutes les variables même si vous pensez que c'est évident (vous en aurez besoin à l'avenir).
6. Préférez l'utilisation de types simples (`number`, `string`, `list(...)`, `map(...)`, `any`) plutôt qu'un type spécifique comme `object()` sauf si vous avez besoin d'avoir des contraintes strictes sur chaque clé.
7. Utilisez des types spécifiques comme `map(map(string))`si tous les éléments de la carte ont le même type (par exemple, `string`) ou peuvent être convertis en celui-ci (par exemple, le type de nombre peut être converti en `string`).
8. Utilisez type any pour désactiver la validation de type à partir d'une certaine profondeur ou lorsque plusieurs types doivent être pris en charge.
9. La Valeur `{}` est parfois un map mais quelques fois object. Utiliser `tomap(...)` pour créer une carte car il n'y a aucun moyen de créer un objet.

## Sorties

Faire les sorties cohérentes et compréhensibles en dehors de son champ d'application (lorsqu'un utilisateur utilise un module, le type et l'attribut de la valeur renvoyée doivent être évidents).

1. Le nom de la sortie doit décrire la propriété qu'il contient et être moins libre que vous ne le souhaiteriez normalement.
2. Une bonne structure pour le nom de la sortie ressemble à `{name}_{type}_{attribute}` , où:
   1. `{name} est le nom de la ressource ou de la source de données` sans le préfixe du fournisseur. `{name}` pour `aws_subnet` est sous-réseau, pour`aws_vpc` ce sera `vpc`.
   2. `{type}` est le type de ressource&#x20;
   3. `{attribute}` est l'attribut retourné par la sortie
   4. [Voir exemples](naming.md).
3. Si la sortie renvoie une valeur avec des fonctions d'interpolation et plusieurs ressources, `{name}` et `{type}` il devrait être aussi générique que possible (`this` comme préfixe être omis). [Voir exemple](naming.md#code-examples-of-output).
4. Si la valeur renvoyée est une liste, elle doit avoir un nom au pluriel. [Voir exemple](naming.md#use-plural-name-if-the-returning-value-is-a-list).
5. Incluez toujours une description pour toutes les sorties, même si vous pensez que c'est évident.
6. Évitez de définir un argument `sensible` à moins que vous ne contrôliez entièrement l'utilisation de cette sortie à tous les endroits de tous les modules
7. Préférez `try()` (disponible depuis Terraform 0.13) à `element(concat(...))` (approche héritée pour la version antérieure à 0.13)

### Exemples de Code de sortie (output)

Renvoie au plus un ID de groupe de sécurité :

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

Lorsque vous avez plusieurs ressources du même type, cela doit être omis dans le nom de la sortie:

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

### Utilisez un nom pluriel si la valeur retournée est une liste

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

