# Kod Yapısı

Terraform kod yapısıyla ilgili sorular, toplulukta açık ara en sık sorulan sorulardır. Herkes bir noktada proje için en iyi kod yapısını da düşündü.

## Terraform konfigürasyon yapısını nasıl kurmalıyım?

Bu, birçok çözümün bulunduğu ve genel bir tavsiye vermenin çok zor olduğu sorulardan biridir, o yüzden neyle uğraştığımızı anlamakla başlayalım.

* Projeniz ne kadar karışık?
  * Bağımlı olduğu kaynakların sayısı
  * Terraform sağlayıcılarının sayısı (Mantıksal ayraçlar hakkındaki not için aşağıya gözatınız)
* Altyapınız ne sıklıkla değişiyor?
  * Ayda/yılda/günde bir defadan
  * Sürekli değişen bir yapıya (Her committe güncellenen bir yapı)
* Kod değişikliği başlatıcıları? Yeni bir çıktı üretildiğinde CI aracınızın repoyu güncellemesine izin veriyor musunuz?
  * Altyapı reposunda sadece geliştiriciler kod değişikliği yapabilir.
  * Herkes, altyapı reposunda değişiklik için PR(Pull Request) açabilir (Buna CI aracı ve diğer botlar da dahil.)
* Hangi geliştirme platformunu veya dağıtım servisini kullanıyorsunuz?
  * AWS CodeDeploy, Kubernetes veya OpenShift için farklı farklı yaklaşımlar sergilemeniz gerekebilir.
* Hangi özelliğe göre gruplandırma yapıyorsunuz?
  * Ortam(environment), bölge(region), proje

{% hint style="info" %}
Mantıksal sağlayıcılar tamamen Terraform'un mantığı içinde çalışır ve çoğu zaman başka hizmetlerle etkileşime girmez, bu nedenle karmaşıklıklarını O(1) olarak düşünebiliriz. En yaygın mantıksal sağlayıcılar arasında rastgele([random](https://registry.terraform.io/providers/hashicorp/random/latest/docs)), yerel([local](https://registry.terraform.io/providers/hashicorp/local/latest/docs)), [terraform](https://www.terraform.io/docs/providers/terraform/index.html), [null](https://registry.terraform.io/providers/hashicorp/null/latest/docs), [time](https://registry.terraform.io/providers/hashicorp/time/latest) bulunur.
{% endhint %}

## Terraform konfigürasyonlarının yapılandırılmasına başlarken

Başlarken veya bir örnek kod yazarken tüm kodu `main.tf`'ye koymak iyi bir fikirdir. Diğer tüm durumlarda, aşağıdaki gibi mantıksal olarak bölünmüş birkaç dosyaya sahip olmak daha iyi olacaktır:

* `main.tf` - tüm kaynakları oluşturmak için modülleri, yerelleri ve veri kaynaklarını çağıran dosyadır.
* `variables.tf` - `main.tf`'de kullanılan değişkenlerin tanımlamalarını içerir.
* `outputs.tf` - `main.tf`'de oluşturulan kaynaklardan çıktıları içerir
* `versions.tf` - Terraform ve sağlayıcılar için sürüm gereksinimlerini içerir

`terraform.tfvars` [kompozisyon](key-concepts.md#composition) dışında hiçbir yerde kullanılmamalıdır.

## Terraform yapılandırma yapısı hakkında nasıl düşünülür?

{% hint style="info" %}
Aşağıdaki örneklerde kullanıldığı şekliyle kaynak modülü, altyapı modülü ve kompozisyon gibi temel kavramları anladığınızdan lütfen emin olun.
{% endhint %}

### Kod yapısı hakkında genel öneriler

* Daha az sayıda kaynakla çalışmak daha kolay ve hızlıdır
  * `terraform plan` ve `terraform apply`, kaynakların durumunu doğrulamak için bulut API istekleri yapar
  * Tüm altyapınız tek bir kompozisyondaysa bu biraz zaman alabilir.
* Patlama çapı (güvenlik ihlali durumunda) daha az kaynakla daha küçüktür
  * Birbiriyle ilgisi olmayan kaynakları ayrı bileşimlere yerleştirerek birbirinden yalıtmak, bir şeyler ters giderse oluşacak sorun riskini azaltır.
* Projenizdi endirekt durum kullanarak başlatın çünkü
  * Dizüstü bilgisayarınız, altyapınızın kaynaklarını barındırmak için için doğru bir yer değil.
  * Git'te bir `tfstate` dosyasını yönetmek kabustur.
  * Daha sonra altyapı katmanları birden çok yönde (bağımlılık veya kaynak sayısı) büyümeye başladığında, işleri kontrol altında tutmak daha kolay olacaktır.
* Tutarlı bir yapı ve [adlandırma](naming.md) kuralı uygulayın:
  * Prosedürel kod gibi, Terraform kodu da insanların okuyabilmesi için yazılmalıdır, bundan altı ay sonra değişiklikler olduğunda tutarlılık yardımcı olacaktır.
  * Kaynakları Terraform durum dosyasında taşımak mümkündür ancak tutarsız yapı ve adlandırmalarınız varsa bunu yapmak daha zor olabilir.
* Kaynak modüllerini olabildiğince sade tutun.
* Değişken olarak iletilebilecek veya veri kaynakları kullanılarak keşfedilebilecek değerleri sabit kodlamayın.
* Veri kaynaklarını ve `terraform_remote_state'i` özellikle kompozisyon içindeki altyapı modülleri arasında bir tutkal olarak kullanın

Bu kitapta, örnek projeler karmaşıklığa göre gruplandırılmıştır - küçük ölçekli yapılardan en büyüğene. Bu ayrım kesin çizgilerle ayrılmamıştır, bu nedenle diğer yapılara da göz gezdirmeniz iyi olacaktır.

### Altyapı modüllerinin ve kompozisyonlarının yönetimi

Küçük bir altyapıya sahip olmak, az sayıda bağımlılık ve az kaynak olduğu anlamına gelir. Proje büyüdükçe, Terraform konfigürasyonlarının büyümesi ve bağımlılıklarının artmasıyla, farklı altyapı modülleri birbirine bağlama ve bir kompozisyon içindeki değerleri geçirme ihtiyacı ortaya çıkması kaçınılmazdır.

Geliştiricilerin kullandığı en az 5 farklı düzenleme çözümünden söz edebiliriz:

1. Terraform. Çok basit, geliştiricilerin işi halletmek için yalnızca Terraform'u bilmesi gerekiyor.
2. Terragrunt. Tüm altyapıyı düzenlemek ve bağımlılıkları işlemek için kullanılabilen saf düzenleme aracı. Terragrunt, altyapı modülleri ve kompozisyonları ile kendi makinenizde çalışır, böylece kod tekrarını azaltır.
3. Şirket içi scriptler. Genellikle bu, düzenlemeye yönelik bir başlangıç noktası olarak ve Terragrunt'ı keşfetmeden önce olur.
4. Ansible veya benzeri genel amaçlı otomasyon aracı. Genellikle Ansible'dan sonra Terraform benimsendiğinde veya Ansible UI aktif olarak kullanıldığında kullanılır.
5. Crossplane ve Kubernetes'ten ilham alan diğer çözümler. Bazen, Terraform konfigürasyonlarınızın istenen durumunu elde etmek için Kubernetes ekosistemini kullanmak ve bir mutabakat döngüsü özelliği kullanmak mantıklıdır. Daha fazla bilgi için Crossplane vs Terraform videosunu izleyin.

Bunları akılda tutarak, bu kitap bu proje yapılarının ilk ikisini, sadece Terraform ve Terragrunt hakkında bilgi içermektedir.

Bir sonraki bölümde [Terraform](examples/terraform/) veya [Terragrunt](examples/terragrunt.md) için kod yapısı örneklerine gözatabilirsiniz.
