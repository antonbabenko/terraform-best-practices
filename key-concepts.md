# Ключові концепції

Офіційна документація Terraform описує [всі аспекти конфігурації в деталях](https://www.terraform.io/docs/configuration/index.html). Уважно прочитайте її, щоб зрозуміти решту цього розділу.

У цьому розділі описуються ключові поняття, які використовуються в книзі.

## Resource

Resource - це `aws_vpc`, `aws_db_instance і т.д.` Resource належить провайдеру, включаючи arguments, outputs , і він має lifecycles. Resource можна створювати, отримувати, оновлювати та видаляти.

## Resource module

Resource module - це колекція підключених ресурсів, які разом виконують спільну дію (наприклад, [AWS VPC Terraform module](https://github.com/terraform-aws-modules/terraform-aws-vpc/) створює VPC, сабнети, NAT gateway і т.д.). Він залежить від конфігурації провайдера, яка може бути визначена в ньому, або в структурах вищого рівня (наприклад, в модулі інфраструктури).

## Infrastructure module

Infrastructure module - це колекція resource modules, які можуть бути логічно не підключені, але в поточній ситуації/проекті/налаштуваннях служать тій самій меті. Він визначає конфігурацію для providers, які передаються до downstream resource modules і до resources. Зазвичай він обмежується роботою в одній сутності на один логічний роздільник (наприклад, AWS Region, Google Project).

Наприклад, [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis/) модуль використовує resource modules, такі як [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc/) та [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group/) щоб керувати інфраструктурою, необхідною для роботи [Atlantis](https://www.runatlantis.io) на [AWS Fargate](https://aws.amazon.com/fargate/).

Інший приклад - [terraform-aws-cloudquery](https://github.com/cloudquery/terraform-aws-cloudquery), де численні модулі використовуються разом в [terraform-aws-modules](https://github.com/terraform-aws-modules/) для керування інфраструктурою, а також для використання ресурсів Docker щоб створювати, пушати та розгортати образи Docker. Все в одному наборі.

## Composition

Composition - це колекція інфраструктурних модулів, які можуть охоплювати декілька логічно відокремлених областей (наприклад, AWS Регіонів, декілька AWS акаунтів). Composition використовується для опису повної інфраструктури, необхідної для всієї організації або проекту.

Composition складається з infrastructure modules, які, в свою чергу, складаються з resources modules, які потім реалізують індивідуальні ресурси.

![Simple infrastructure composition](.gitbook/assets/composition-1.png)

## Data source

Data source виконує лише read-only операції та залежить від конфігурації постачальника, використовується в resource module і в infrastructure module.

Data source `terraform_remote_state` діє як з'єднувальник для модулів і композицій вищого рівня.

[Зовнішній](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data\_source) data source дозволяє зовнішній програмі діяти як джерело даних, відкриваючи довільні дані для використання в інших місцях конфігурації Terraform. Ось приклад із [terraform-aws-lambda module](https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/258e82b50adc451f51544a2b57fd1f6f8f4a61e4/package.tf#L5-L7), де ім'я файлу обчислюється шляхом виклику зовнішнього Python скрипта.

Інший приклад - [http](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) data source робить HTTP GET запит на заданий URL і експортує інформацію про відповідь, яка часто корисна для отримання інформації з кінцевих точок, де рідний Terraform провайдер не існує.

## Remote state

Infrastructure modules та compositions повинні зберігати свої [Terraform state](https://www.terraform.io/docs/language/state/index.html) у віддаленому місці, де їх можуть отримати інші керованим способом (наприклад через ACL, версії, журналювання).

## Provider, provisioner і т.д.

Providers, provisioners, і деякі інші терміни дуже добре описані в офіційній документації, тому немає сенсу повторювати їх тут. На мою думку, вони мають мало спільного з написанням якісних Terraform модулів.

## Чому так важко?

У той час як окремі ресурси – це атоми в інфраструктурі, resource modules - це молекули. Модуль — це найменший версійний блок, який можна спільно використовувати. Він має точний список аргументів, реалізує базову логіку, щоб виконувати потрібну функцію. Наприклад, [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group) модуль створює `aws_security_group` і `aws_security_group_rule` ресурси на основі вхідних даних. Цей ресурсний модуль сам по собі можна використовувати разом з іншими модулями для створення модуля інфраструктури.

Доступ до даних між молекулами (resource modules та infrastructure modules) здійснюється за допомогою модульних outputs та data sources.

Доступ між compositions часто виконується використовуючи remote state data sources. Існує [багато способів обмінюватися даними між конфігураціями](https://www.terraform.io/docs/language/state/remote-state-data.html#alternative-ways-to-share-data-between-configurations).

Якщо спробувати описати вище зазначені поняття у псевдовідношеннях, це може виглядати так:

```
composition-1 {
  infrastructure-module-1 {
    data-source-1 => d1

    resource-module-1 {
      data-source-2 => d2
      resource-1 (d1, d2)
      resource-2 (d2)
    }

    resource-module-2 {
      data-source-3 => d3
      resource-3 (d1, d3)
      resource-4 (d3)
    }
  }

}
```
