# Напісанне канфігурацый Terraform

## Выкарыстоўвайце `locals` каб задаць дакладныя залежнасці паміж рэсурсамі

Карысны спосаб даць Terraform падказку, што некаторыя рэсурсы павінны быць выдаленыя, нават калі ў канфігурацыях Terraform няма прамой залежнасці.

[https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)

## Terraform 0.12 - абавязковыя і неабавязковыя аргументы

1. Абавязковы аргумент `index_document` павінен быць заданы, калі `var.website` ня ёсць пустой мапай.
2. Дадатковы аргумент `error_document` можна прапусціць.

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

## Кіраванне сакрэтамі ў Terraform

Сакрэты ёсць канфідэнцыйнай інфармацыя, якая можа ўключаць усё што заўгодна: ад пароляў і ключоў шыфравання да токенаў API і service certificates. Звычайна яны выкарыстоўваюцца для наладкі аўтэнтыфікацыі і аўтарызацыі cloud рэсурсаў. Абарона гэтых канфідэнцыйных рэсурсаў мае вырашальнае значэнне, бо іх раскрыццё можа прывесці да парушэнняў бяспекі. Настойліва рэкамендуецца пазбягаць захоўвання сакрэтных даных у канфігурацыі і стане Terraform, паколькі любы чалавек з доступам да сістэмы кантролю версій можа атрымаць да іх доступ. Замест гэтага разгледзьце магчымасць выкарыстання знешніх крыніц даных для атрымання сакрэтных даных з вонкавых крыніц падчас выканання. Напрыклад, калі вы выкарыстоўваеце AWS Secrets Manager, вы можаце выкарыстоўваць крыніцу дадзеных `aws_secretsmanager_secret_version`  для доступу да значэння сакрэта. У наступным прыкладзе выкарыстоўваюцца аргументы толькі для запісу, якія падтрымліваюцца ў Terraform 1.11+ і захоўваюць значэнне па-за станам Terraform.

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
