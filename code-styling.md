# Стиль коду

{% hint style="info" %}
* Приклади та модулі Terraform повинні містити документацію, яка пояснює функції та як їх використовувати.
* Усі посилання у файлах README.md мають бути абсолютними, щоб веб-сайт Terraform Registry відображав їх правильно.
* Документація може включати схеми, створені за допомогою [mermaid](https://github.com/mermaid-js/mermaid) і креслення, створені за допомогою [cloudcraft.co](https://cloudcraft.co).
* Використовуйте [Terraform pre-commit hooks](https://github.com/antonbabenko/pre-commit-terraform) щоб переконатися, що код валідний, правильно відформатований і автоматично задокументований, перш ніж запушати його на git і надати для подальшого код рев'ю.
{% endhint %}

### Документація

### Автоматично згенерована документація

[pre-commit](https://pre-commit.com) - це фреймворк для керування та підтримки багатомовних pre-commit хуків. Він написаний на Python і є потужним інструментом для автоматичного виконання завдань на машині розробника до того, як код буде передано в репозиторій git. Зазвичай він використовується для запуску лінтерів і форматування коду (дивіться [підтримувані хуки](https://pre-commit.com/hooks.html)).

З конфігураціями Terraform `pre-commit` можна використовувати для форматування та перевірки коду, а також для оновлення документації.

Перегляньте [pre-commit-terraform repository](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md), щоб ознайомитися з ним та існуючими репозиторіями (наприклад, [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc)), де це вже використовується.

### terraform-docs

[terraform-docs](https://github.com/segmentio/terraform-docs) - це інструмент, який створює документацію з модулів Terraform у різних вихідних форматах. Ви можете запускати його вручну (без pre-commit хуків, або ж використовувати [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform), щоб документація оновлювалася автоматично).

@todo: Document module versions, release, GH actions

## Ресурси

1. [pre-commit framework homepage](https://pre-commit.com)
2. [Collection of git hooks for Terraform to be used with pre-commit framework](https://github.com/antonbabenko/pre-commit-terraform)
3. Блог пост від [Dean Wilson](https://github.com/deanwilson): [pre-commit hooks and terraform - a safety net for your repositories](https://www.unixdaemon.net/tools/terraform-precommit-hooks/)
