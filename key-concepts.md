# Anahtar Kavramlar

Resmi Terraform [dökümanında](https://www.terraform.io/language) tüm bakış açılarını ve konfigürasyonları detaylı bir şekilde bulabilirsiniz. Bölümün geri kalanını anlamak için belirtilen dökümanı okumanız yararlı olacaktır.

Bu bölüm kitap içerisinde yer alan anahtar kavramların açıklamalarını içermektedir.

## Kaynak (Resource)

`aws_vpc`, `aws_db_instance` kaynak örneği olarak verilebilir. Her bir kaynak bir sağlayıcıya(provider) aittir, argüman kabul eder, özelliklerini çıktı olarak oluşturur ve birer yaşam döngüsü vardır. Kaynaklar oluşturulabilir(create), geri alınabilir(retrieve), güncellenebilir(update) veya silinebilir(delete).

## Kaynak Modülü (Resource module)

Kaynak modülü, birlikte ortak eylemi gerçekleştiren bağlı kaynakların topluluğudur (Örnepin, [AWS VPC Terraform Module](https://github.com/terraform-aws-modules/terraform-aws-vpc/), VPN, sunet, NAT gateway gibi kaynaklar oluşturur). Bu durum kaynak modülünün içinde veya daha üst seviye bir yapıda (Altyapı Modülü) tanımlanan sağlayıcıdan sağlayıcıya göre değişiklik gösterebilir.

## Altyapı Modülü (Infrastructure module)

Kaynak moullerinin bir araya gelmesiyle altyapı modülü oluşur. Bunlar mantıksal olarak birbiriyle bağlantılı olmayabilir ama var olan projede veya kurulumda aynı amaca hizmet eder.Altyapı modülünde sağlayıcı(provider) için gerekli konfigürasyonlar belirlenir. Bu konfigürasyonlar kaynak modülüne ve kaynaklara geçecektir. Altyapı modülü genellikle her mantıksal ayraç (AWS Region, Google Project) için bir özellikle limitlenmektedir.

Örneğin, [terraform-aws-atlantils](https://github.com/terraform-aws-modules/terraform-aws-atlantis/) modülü [AWS Fargate](https://aws.amazon.com/fargate/) üzerinde çalışan [Atlantis'in](https://www.runatlantis.io/) altyapısını yönetmek için [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc/) ve [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group/) gibi çeşitli kaynak modüllerine ihtiyaç duyar.

Bir başka örnek ise [terraform-aws-cloudquery](https://github.com/cloudquery/terraform-aws-cloudquery) modülü ve[ terraform-aws-modules](https://github.com/terraform-aws-modules/) ün birtakım modülleri Docker kaynaklarının derlenmesi(build), ortak bir alana gönderilmesi (push) ve Docker imagelarının deploy edilmesi için kullanılır. Hepsi bir arada.

## Kompozisyon (Composition)

Kompozisyon çeşitli mantıksal olarak birbirlerinden ayrılan(AWS Regions, AWS Accounts) altyapı modüllerinin bir araya gelmesinden oluşur. Genellikle Kompozisyonlar bir organizasyondaki veya projedeki tüm altyapıyı tanımlamak için kullanılır.

Bir kompozisyon altyapı modüllerinden oluşur ki altyapı modülü de çeşitli kaynak modülleri ve kişisel olarak oluşturulan kaynaklardan oluşur.

![Simple infrastructure composition](.gitbook/assets/composition-1.png)

## Veri Kaynağı (Data source)

Veri kaynakları sadece okuma (read-only) modunda hizmet vermektedir ve sağlayıcının konfigürasyonlarına bağımlıdır. Veri kaynakları bir kaynak modülü veya altyapı modülü içerisinde kullanılabilir.

Veri kaynağı `terraform_remote_state` üst seviye modülleri ve kompozisyonları bir arada tutmak için tutkal vazifesi görür.

Harici ([external](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data\_source)) veri kaynağı, harici bir programın bir veri kaynağı olarak hareket etmesine ve Terraform konfigürasyonunda başka bir yerde kullanım için rasgele verileri açığa çıkarmasına izin verir. Burada, dosya adının harici bir Python betiği çağrılarak hesaplandığı terraform-aws-lambda modülünden bir örnek verilmiştir.

[http](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) veri kaynağı, verilen URL'ye bir HTTP GET isteği yapar ve yerel bir Terraform sağlayıcısının bulunmadığı uç noktalardan bilgi almak için genellikle yararlı olan yanıtla ilgili bilgileri dışa aktarır.

## Endirekt Durum (Remote state)

Infrastructure modules and compositions should persist their [Terraform state](https://www.terraform.io/docs/language/state/index.html) in a remote location where it can be retrieved by others in a controllable way (e.g., specify ACL, versioning, logging).

Altyapı modülleri ve kompozisyonları, Terraform durumlarını ([Terraform state](https://www.terraform.io/docs/language/state/index.html)) başkaları tarafından kontrol edilebilir bir şekilde alınabilecekleri uzak bir konumda sürdürmelidir (örneğin, versiyonlama, loglama).

## Sağlayıcı, Hükümcü vb.(Provider, provisioner, etc)

Sağlayıcı, hükümcü ve diğer birtakım terimler resmi dökümantasyonda çok güzel açıklanmış durumda ve bunları papağan gibi tekrarlamanın alemi yok. Bana göre bunları bilmenin iyi terraform modülleri yazmakla da çok alakası yok.

## Neden bu kadar zor?

Bireysel kaynaklar altyapıdaki atomlar gibiyken, kaynak modülleri (atomlardan oluşan) moleküllerdir. Modül, en küçük sürümlü ve paylaşılabilir birimdir. Tam bir argüman listesine sahiptir, böyle bir birimin gerekli işlevi yapması için temel mantığı uygular. Örneğin, [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group) modülü, girdiye dayalı olarak `aws_security_group` ve `aws_security_group_rule` kaynakları oluşturur. Bu kaynak modülü tek başına diğer modüllerle birlikte altyapı modülünü oluşturmak için kullanılabilir.

Moleküller arası (kaynak modülleri ve altyapı modülleri) verilere erişim, modüllerin çıktıları ve veri kaynakları kullanılarak gerçekleştirilir.

Kompozisyonlar arasındaki erişim, genellikle endirekt durum veri kaynakları kullanılarak gerçekleştirilir. [Konfigürasyonlar arasında veri paylaşmanın birden çok yolu](https://www.terraform.io/docs/language/state/remote-state-data.html#alternative-ways-to-share-data-between-configurations) vardır.

Yukarıda açıklanan kavramlar kabaca aşağıdaki şekilde görülebilir.

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
