---
description: FTP (Frequent Terraform Problems)
---

# SSS

## Farkında olmam ve kullanmayı düşünmem gereken araçlar nelerdir?

* [**Terragrunt**](https://terragrunt.gruntwork.io/) - Yönetim aracı
* [**tflint**](https://github.com/terraform-linters/tflint) - Statik kod analiz aracı
* [**tfenv**](https://github.com/tfutils/tfenv) - Versiyon yönetimi
* [**Atlantis**](https://www.runatlantis.io/) - Pull Request otomasyonu
* [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) - pre-commit'lerde kullanılabilecek git hooklarının birleşimi olan bir framework.
* [**Infracost**](https://www.infracost.io) - Pull requestlerde Terraform için bulut maliyet tahminleri. Terragrunt, Atlantis ve pre-commit-terraform ile de çalışır.

## Önceki soruyu cevaplama şansınız oldu mu?

Evet, birkaç ay sonra nihayet cevabı bulduk. Ne yazık ki, Mike şu anda tatilde, bu yüzden korkarım bu noktada cevabı veremiyoruz.

## Modüllerle bağımlılık cehennemine (dependency hell) çözümler nelerdir?

Kaynak ve altyapı modüllerinin sürümleri belirtilmelidir. Sağlayıcılar, modüllerin dışında, ancak yalnızca bileşimde yapılandırılmalıdır. Sağlayıcıların sürümü ve Terraform da kilitlenebilir.

Ana bağımlılık yönetimi aracı yoktur, ancak bağımlılık belirtimlerini daha az sorunlu hale getirmek için bazı ipuçları vardır. Örneğin, [Dependabot](https://dependabot.com/), bağımlılık güncellemelerini otomatikleştirmek için kullanılabilir. Dependabot, bağımlılıklarınızı güvenli ve güncel tutmak için çekme istekleri oluşturur. Dependabot, Terraform konfigürasyonlarını destekler.
