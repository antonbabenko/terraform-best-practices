---
metaLinks:
  alternates:
    - https://app.gitbook.com/s/e1Mp2scOX6OnQbifCen3/code-styling
---

# Код стилі

{% hint style="info" %}
* Мысалдар мен Terraform модульдерінде мүмкіндіктерді және оларды қалай пайдалану керектігін түсіндіретін құжаттама болуы керек.
* Terraform Registry веб-сайтында дұрыс көрсетілуі үшін `README.md` файлдарындағы барлық сілтемелер абсолютті болуы тиіс.
* Құжаттама [\`mermaid\`](https://github.com/mermaid-js/mermaid) арқылы жасалған диаграммаларды және [\`cloudcraft.co\`](https://cloudcraft.co) арқылы жасалған сызбаларды (blueprints) қамтуы мүмкін.
* Кодтың Git-ке жіберілмес (push) және адамдар тексермес бұрын жарамды, дұрыс пішімделген және автоматты түрде құжатталған екеніне көз жеткізу үшін [Terraform pre-commit хуктарын](https://github.com/antonbabenko/pre-commit-terraform) қолданыңыз.
{% endhint %}

### Пішімдеу

Terraform-ның \`terraform fmt\` пәрмені конфигурация файлдары үшін канондық стильді мәжбүрлеп орындайды.\
&#x20;Бұл құрал әдейі қатаң ережелі (opinionated) және бапталмайтын етіп жасалған, бұл код базаларында бірыңғай пішімді қамтамасыз етеді, осылайша тексерушілер стильге емес, мазмұнға назар аудара алады. Код нұсқаны басқару жүйесіне (version control) түспес бұрын оны автоматты түрде тексеру және пішімдеу үшін оны [Terraform pre-commit хуктарымен](https://github.com/antonbabenko/pre-commit-terraform) біріктіріңіз.

Мысалы:

```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/antonbabenko/pre-commit-terraform
    rev: v1.99.4
    hooks:
      - id: terraform_fmt
```

CI пайплайндарында сәйкестікті тексеру үшін terraform fmt -check қолданыңыз. Барлық файлдар дұрыс пішімделген болса, ол 0 мәртебесімен аяқталады; әйтпесе, нөлдік емес код қайтарады және қате файлдарды тізімдейді. Пішімдеуді осылайша орталықтандыру біріктіру (merge) кезіндегі қиындықтарды жояды және командалар арасында бірыңғай стандартты сақтайды.

### Редактор конфигурациясы

* &#x20;**`.editorconfig`** файлын қолдану: [EditorConfig](https://editorconfig.org/) әртүрлі редакторлар мен IDE-лерде бір жобада жұмыс істейтін бірнеше әзірлеушілер үшін бірыңғай кодтау стильдерін сақтауға көмектеседі.  Бос орындар мен шегіністерді бірізді сақтау үшін репозиторийлеріңізге .editorconfig файлын қосыңыз.

Yлгісі **`.editorconfig`:**

```editorconfig
[*]
indent_style = space
indent_size = 2
trim_trailing_whitespace = true

[*.{tf,tfvars}]
indent_style = space
indent_size = 2

[Makefile]
indent_style = tab
```

### Құжаттама

#### Автоматты түрде жасалған құжаттама

[pre-commit](https://pre-commit.com/) көптілді pre-commit хуктарын басқаруға және сүйемелдеуге арналған фреймворк. Ол Python тілінде жазылған және код git репозиторийіне жіберілмес (commit) бұрын әзірлеушінің компьютерінде қандай да бір әрекетті автоматты түрде орындауға арналған қуатты құрал. Әдетте, ол линтерлерді іске қосу және кодты пішімдеу үшін қолданылады ([қолдау көрсетілетін хуктарды](https://pre-commit.com/hooks.html) қараңыз).

Terraform конфигурацияларымен `pre-commit`-ті кодты пішімдеу және тексеру, сондай-ақ құжаттаманы жаңарту үшін пайдалануға болады.

Онымен және осы әдіс қолданылып жүрген бар репозиторийлермен (мысалы, [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc)) танысу үшін [pre-commit-terraform репозиторийін](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md) қарап шығыңыз.

### terraform-docs

[terraform-docs](https://github.com/segmentio/terraform-docs) Terraform модульдерінен әртүрлі шығыс пішімдерінде құжаттама жасайтын құрал.  Сіз оны қолмен іске қоса аласыз (pre-commit хуктарынсыз) немесе құжаттаманы автоматты түрде жаңарту үшін [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform) хуктарын пайдалана аласыз.

#### Пікір жазу стилі

Пікірлер үшін `#` қолданыңыз.   `//` блоктық пікірлерден аулақ болыңыз.

**Мысалы:**

```hcl
# This is a comment explaining the resource
resource "aws_instance" "this" {
# ...
}
```

**Бөлім тақырыптары:** Анықтық үшін кодтағы бөлім тақырыптарын `# -----` немесе `######` арқылы бөліңіз.

**Мысалы:**

```hcl
# --------------------------------------------------
# AWS EC2 Instance Configuration
# --------------------------------------------------

resource "aws_instance" "this" {
# ...
}
```

@todo: Модуль нұсқаларын, релизді, GH actions құжаттау

### Ресурстар

1. [pre-commit framework homepage](https://pre-commit.com/)
2. [Collection of git hooks for Terraform to be used with pre-commit framework](https://github.com/antonbabenko/pre-commit-terraform)
3. Блог жазбасы: [Dean Wilson](https://github.com/deanwilson): [pre-commit hooks and terraform - a safety net for your repositories](https://www.unixdaemon.net/tools/terraform-precommit-hooks/)

