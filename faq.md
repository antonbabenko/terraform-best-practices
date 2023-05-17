---
description: FTP (Frequent Terraform Problems)
---

# ხშირად დასმული კითხვები

## რომელი ხელსაწყოები უნდა ვიცოდეთ და გამოვიყენოთ?&#x20;

* [**Terragrunt**](https://terragrunt.gruntwork.io/) - ორკესტრაციის ხელსაწყო
* [**tflint**](https://github.com/terraform-linters/tflint) - Code linter
* [**tfenv**](https://github.com/tfutils/tfenv) - ვერსიების მენეჯერი
* [**Atlantis**](https://www.runatlantis.io/) - Pull Request-ების ავტომატიზაცია
* [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) - git hook-ების კოლექცია Terraform-ისთვის
* [**Infracost**](https://www.infracost.io) - ქლაუდის ხარჯის განსაზღვრა Terraform-ის pull request-ში. მუშაობს Terragrunt, Atlantis და pre-commit-terraform-თან.

## რა გამოსავალია მოდულების [dependency hell](https://en.wikipedia.org/wiki/Dependency\_hell) -თან მიმართებით?

რესურსების და ინფრასტრუქტურის მოდულების ვერსიები უნდა იყოს განსაზღვრული. პროვაიდერების კონფიგურაცია უნდა განისაზღვროს მოდულებს გარეთ, მაგრამ სტრუქტურულად. პროვაიდერების და Terraform-ის ვერსიები ასევე შეიძლება განისაზღვროს მკაცრად.

არ არსებობს დამოკიდებულების(dependency) სამართავი ხელსაწყო, მაგრამ გარკვეული რჩევები როგორ ავირიდოთ თავიდან მსგავსი პრობლემები. მაგალითად, [Dependabot](https://dependabot.com/) შეგიძლიათ გამოიყენოთ დამოკიდებულებების განახლების ავტომატიზაციისთვის. Dependabot ქმნის pull requests რათა შეინარჩუნოს დამოკიდებულებები უსაფრთხოს და განახლებულ მდგომარეობაში. Dependabot -ს გააჩნია Terraform კონფიგურაციების მხარდაჭერა.
