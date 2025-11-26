---
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/e1Mp2scOX6OnQbifCen3/writing-terraform-configurations
---

# Terraform конфигурацияларын жазу

## Ресурстар арасындағы нақты тәуелділіктерді көрсету үшін `locals` қолданыңыз

Бұл  Terraform конфигурацияларында тікелей тәуелділік болмаған кезде де, кейбір ресурстардың бұрынырақ жойылуы керектігі туралы Terraform-ға ишара берудің пайдалы жолы.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

### Terraform 0.12 - Міндетті және Қосымша аргументтер

1. Егер `index_document` websiteбос карта (map) болмаса,  `var.website` міндетті аргументі орнатылуы тиіс.
2. &#x20;`error_document` қосымша аргументін қалдырып кетуге болады.

{% code title="main.tf" %}
```hcl
variable "website" {
  type    = map(string)
  default = {}
}

resource "aws_s3_bucket" "this" {
  # omitted...

  dynamic "website" {
    for_each = length(keys(var.website)) == 0 ? [] : [var.website]

    content {
      index_document = website.value.index_document
      error_document = lookup(website.value, "error_document", null)
    }
  }
}
```
{% endcode %}

{% code title="terraform.tfvars" %}
```hcl
website = {
  index_document = "index.html"
}
```
{% endcode %}

#### Объектілердегі қосымша атрибуттар (Terraform 1.3+)

Міндетті емес өрістер үшін әдепкі мәндерді қамтамасыз ету мақсатында объектілердегі қосымша атрибуттарды қолданыңыз:

{% code title="variables.tf" %}
```hcl
variable "database_settings" {
  description = "Database configuration with optional parameters"
  type = object({
    name               = string
    engine             = string
    instance_class     = string
    backup_retention   = optional(number, 7)
    monitoring_enabled = optional(bool, true)
    tags               = optional(map(string), {})
  })
}
```
{% endcode %}

### Terraform-да құпия деректерді басқару

Құпия деректер -құпия сөздер мен шифрлау кілттерінен бастап API токендері мен қызмет сертификаттарына дейінгі кез келген сезімтал деректер болуы мүмкін. Олар әдетте бұлттық ресурстар үшін аутентификация мен авторизацияны орнату үшін қолданылады. Бұл сезімтал ресурстарды қорғау өте маңызды, себебі олардың жария болуы қауіпсіздіктің бұзылуына әкелуі мүмкін. Құпия деректерді Terraform конфигурациясында және күйінде сақтамауға қатаң кеңес беріледі, себебі нұсқаларды басқару жүйесіне рұқсаты бар кез келген адам оларға қол жеткізе алады. Оның орнына, орындау уақытында сыртқы көздерден құпияларды алу үшін сыртқы дереккөздерді пайдалануды қарастырыңыз. Мысалы, AWS Secrets Manager қолдансаңыз, құпия мәнге қол жеткізу үшін  `aws_secretsmanager_secret_version`  дереккөзін пайдалана аласыз. Келесі мысалда Terraform 1.11+ нұсқасында қолдау көрсетілетін және мәнді Terraform күйінен тыс сақтайтын тек жазуға арналған аргументтер қолданылады.

{% code title="main.tf" %}
```hcl
# Fetch the secret’s metadata
data "aws_secretsmanager_secret" "db_password" {
  name = "my-database-password"
}

# Get the latest secret value
data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = data.aws_secretsmanager_secret.db_password.id
}

# Use the secret without persisting it to state
resource "aws_db_instance" "example" {
  engine         = "mysql"
  instance_class = "db.t3.micro"
  name           = "exampledb"
  username       = "admin"

  # write-only: Terraform sends it to AWS then forgets it
  password_wo = data.aws_secretsmanager_secret_version.db_password.secret_string
```
{% endcode %}

### Айнымалыларды тексеру және кіріс деректерді өңдеу

{% hint style="info" %}
Айнымалыларды тексеру (валидация) қателерді ерте анықтауға көмектеседі, нақты кері байланыс береді және кіріс деректердің талаптарыңызға сәйкес келуін қамтамасыз етеді.
{% endhint %}

#### Айнымалыларды негізгі тексеру

Айнымалылардың нақты критерийлерге сәйкес келетініне көз жеткізу үшін валидация блоктарын қолданыңыз:

{% code title="variables.tf" %}
```hcl
variable "environment" {
  description = "Environment name for resource tagging"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}
```
{% endcode %}

#### Объект және тізім валидациясы

Күрделі деректер құрылымдарының күтілетін мәндерді қамтитынына көз жеткізу үшін оларды тексеріңіз:

{% code title="variables.tf" %}
```hcl
variable "database_config" {
  description = "Database configuration"
  type = object({
    engine            = string
    instance_class    = string
    allocated_storage = number
  })

  validation {
    condition     = contains(["mysql", "postgres"], var.database_config.engine)
    error_message = "Database engine must be either 'mysql' or 'postgres'."
  }
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access resources"
  type        = list(string)

  validation {
    condition = alltrue([
      for cidr in var.allowed_cidr_blocks : can(cidrhost(cidr, 0))
    ])
    error_message = "All CIDR blocks must be valid IPv4 CIDR notation."
  }
}
```
{% endcode %}
