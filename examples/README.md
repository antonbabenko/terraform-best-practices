# Exemple de structuri de cod

## Structuri de cod Terraform

{% hint style="info" %}
Exemplele următoare prezintă cazul în care AWS a fost ales ca furnizor, dar majoritatea principiilor descrise pot fi refolosite pentru ceilalți furnizori de cloud și de asemenea în cazul în care alegem alți furnizori în general (de DNS, baze de date, monitorizare, etc.).
{% endhint %}

| Tip                                                           | Descriere                                                                                                                                                                                                  | Disponibilitate |
| ------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
| [mică](terraform/small-size-infrastructure.md)                | Puține resurse, fără dependențe externe. Un singur cont AWS. O singura regiune. Un singur mediu.                                                                                                           | Da              |
| [medie](terraform/medium-size-infrastructure.md)              | Câteva conturi AWS și medii de lucru, module de infrastructură gata de folosire cu Terraform.                                                                                                              | Da              |
| [mare](terraform/large-size-infrastructure-with-terraform.md) | Mai multe conturi de AWS, mai multe regiuni, nevoie urgentă de a reduce folosirea metodei copy-paste, module de infrastructură personalizate, utilizare ridicata a compoziției de cod. Folosind Terraform. | În lucru        |
| foarte mare                                                   | Furnizori multiplii (AWS, GCP, Azure). Implementări multi-cloud. Folosind Terraform.                                                                                                                       | Nu              |

## Structuri de cod Terragrunt

| Tip         | Descriere                                                                                                                                                                                                               | Disponibilitate |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
| medie       | Mai multe conturi de AWS și medii de lucru, module de infrastructură gata de folosire, model de compoziție folosind Terragrunt.                                                                                         | Nu              |
| mare        | Mai multe conturi de AWS, multiple regiuni many regions, nevoie urgentă de a reduce folosirea metodei copy-paste, module de infrastructură personalizate, utilizare ridicata a compoziției de cod. Folosind Terragrunt. | Nu              |
| foarte mare | Furnizori multiplii (AWS, GCP, Azure). Implementări multi-cloud. Folosind Terragrunt.                                                                                                                                   | Nu              |
