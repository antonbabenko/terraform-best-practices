# Przykłady kodu

## Struktura kodu Terraform

{% hint style="info" %}
Poniższe przykłady dotyczą AWS, ale większość zasad pokazanych w przykładach można zastosować do innych dostawców chmury publicznej, a także innych rodzajów dostawców (DNS, DB, Monitoring, itp.)
{% endhint %}

| Type                                                          | Description                                                                                                                                                                      | Gotowość |
| ------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [mała](terraform/small-size-infrastructure.md)                | Mało zasobów, żadnych zewnętrznych zależności. Pojedyncze konto AWS. Tylko jeden region. Jedno środowisko.                                                                       | Tak      |
| [średnia](terraform/medium-size-infrastructure.md)            | Kilka kont i środowisk AWS. Korzystanie z gotowych modułów infrastruktury Terraform. Wykorzystanie Terraform.                                                                    | Tak      |
| [duża](terraform/large-size-infrastructure-with-terraform.md) | Wiele kont AWS, wiele regionów, pilna potrzeba ograniczenia kopiowania i wklejania, niestandardowe moduły infrastruktury, intensywne użycie kompozycji. Wykorzystanie Terraform. | WIP      |
| bardzo duża                                                   | Kilku dostawców (AWS, GCP, Azure). Wdrożenia w wielu chmurach. Wykorzystanie Terraform.                                                                                          | Nie      |

## Struktura kodu Terragrunt

| Typ         | Opis                                                                                                                                                                              | Gotowość |
| ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| średnia     | Kilka kont i środowisk AWS. Korzystanie z gotowych modułów infrastruktury. Wykorzystanie Terragrunt.                                                                              | Nie      |
| duża        | Wiele kont AWS, wiele regionów, pilna potrzeba ograniczenia kopiowania i wklejania, niestandardowe moduły infrastruktury, intensywne użycie kompozycji. Wykorzystanie Terragrunt. | Nie      |
| bardzo duża | Kilku dostawców (AWS, GCP, Azure). Wdrożenia w wielu chmurach. Wykorzystanie Terragrunt.                                                                                          | Nie      |
