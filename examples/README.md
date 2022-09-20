# Kod Yapısı Örnekleri

## Terraform Kod Yapıları

{% hint style="info" %}
Bu örnekler, AWS sağlayıcısını göstermektedir, ancak örneklerde gösterilen ilkelerin çoğu, diğer genel bulut sağlayıcılarının yanı sıra diğer sağlayıcı türlerine de (DNS, DB, İzleme, vb.) uygulanabilir.
{% endhint %}

| Tip                                                            | Açıklama                                                                                                                                            | Kullanılabilirlik     |
| -------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------- |
| [small](terraform/small-size-infrastructure.md)                | Az kaynak, dış bağımlılık yok. Tek AWS hesabı. Tek bölge. Tek ortam.                                                                                | Evet                  |
| [medium](terraform/medium-size-infrastructure.md)              | Birkaç AWS hesabı ve ortamı, Terraform kullanan hazır altyapı modülleri.                                                                            | Evet                  |
| [large](terraform/large-size-infrastructure-with-terraform.md) | Birçok AWS hesabı, birçok bölge, kopyala-yapıştır, özel altyapı modülleri, yoğun kompozisyon kullanımı azaltma acil ihtiyacı. Terraform'u kullanma. | Geliştirme Aşamasında |
| very-large                                                     | Birkaç sağlayıcı (AWS, GCP, Azure). Çoklu bulut dağıtımları. Terraform'u kullanma.                                                                  | Hayır                 |

## Terragrunt kod yapıları

| Tip        | Açıklama                                                                                                                                             | Kullanılabilirlik |
| ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- |
| medium     | Birkaç AWS hesabı ve ortamı, kullanıma hazır altyapı modülleri, Terragrunt kullanan kompozisyon kalıbı.                                              | Hayır             |
| large      | Birçok AWS hesabı, birçok bölge, kopyala-yapıştır, özel altyapı modülleri, yoğun kompozisyon kullanımı azaltma acil ihtiyacı. Terragrunt'u kullanma. | Hayır             |
| very-large | Birkaç sağlayıcı (AWS, GCP, Azure). Çoklu bulut dağıtımları. Terragrunt'u kullanma.                                                                  | Hayır             |
