# Kodlama Tarzı

{% hint style="info" %}
* Örnekler ve Terraform modülleri, özellikleri ve bunların nasıl kullanılacağını açıklayan belgeler içermelidir.
* README.md dosyası içerisinde tüm linkler açıklayıcı bir şekilde mevcut olmalıdır.
* Dökümantasyon [mermaid](https://github.com/mermaid-js/mermaid) ile oluşturulan diagram, [cloudcraft.co](https://cloudcraft.co/) tarafından oluşturulan blueprint içerebilir.
* Terraform kodunuzun geçerli, düzgün biçimlendirilmiş ve otomatik olarak belgelendiğinden emin olmak için [Terraform pre-commit](https://github.com/antonbabenko/pre-commit-terraform) hooks kullanılabilir.
{% endhint %}

## Belgeleme

### Otomatik oluşturulan dökümantasyon

[pre-commit](https://pre-commit.com/) çoklu dil destekli pre-commit hooklarını kontrol etmeyi sağlayan bir frameworktur. Python ile yazılmıştır ve kod bir git reposuna işlenmeden önce geliştiricinin makinesinde otomatik olarak bir şeyler yapmak için güçlü bir araçtır. Normalde, linterleri çalıştırmak ve kodu biçimlendirmek için kullanılır ([desteklenen hooklara](https://pre-commit.com/hooks.html) gözatabilirsiniz).

Terraform konfigürasyonları ile `pre-commit`, kodu formatlamak, doğrulamak ve belgeleri güncellemek için kullanılabilir.

Kendinizi daha iyi tanımak için [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md) reposuna ve bunun zaten kullanıldığı mevcut repolara (örneğin, [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc)) gözatabilirsiniz.

### terraform-docs

[terraform-docs](https://github.com/segmentio/terraform-docs), Terraform modüllerinden çeşitli çıktı formatlarında dokümantasyon üreten bir araçtır. Belgeleri otomatik olarak güncellemek için manuel olarak çalıştırabilir ([pre-commit hookları](https://github.com/antonbabenko/pre-commit-terraform) olmadan) veya pre-commit-terraform hooklarını kullanabilirsiniz.

## Kaynaklar

1. [pre-commit framework homepage](https://pre-commit.com/)
2. [Collection of git hooks for Terraform to be used with pre-commit framework](https://github.com/antonbabenko/pre-commit-terraform)
3. Blog post by [Dean Wilson](https://github.com/deanwilson): [pre-commit hooks and terraform - a safety net for your repositories](https://www.unixdaemon.net/tools/terraform-precommit-hooks/)
