# Terraform ile büyük ölçekli altyapı yönetimi

Kaynak: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/large-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/large-terraform)

Bu örnek, büyük boyutlu bir altyapı için Terraform konfigürasyonları yapılandırılmasına yönelik örnek kodları içerir.

* 2 AWS hesabı
* 2 bölge
* 2 ayrı ortam (tamamen birbirlerinden izole prod ve stage). Her ortam ayrı bir AWS hesabında bulunur ve kaynakları 2 bölge arasında dağıtır
* Her ortam, Terraform Registry kaynaklı hazır altyapı modülünün (alb) farklı bir sürümünü kullanır.
* Her ortam, dahili modüllerin aynı versiyonu kullanır.

{% hint style="info" %}
Burada açıklanan gibi büyük bir projede Terragrunt kullanmanın faydaları çok görünür hale gelir. [Terragrunt ile Kod Yapıları](../terragrunt.md) örneklerine gözatabilirsiniz.
{% endhint %}

{% hint style="success" %}
* Altyapının mantıksal olarak ayrıldığı projeler için mükemmel (ayrı AWS hesapları)
* AWS hesapları arasında paylaşılan kaynakları yönetmeye gerek olmadığında iyidir (bir ortam = bir AWS hesabı = bir durum dosyası)
* Ortamlar arasındaki değişikliklerin yönetilmesine gerek olmadığında iyi
* Altyapı kaynakları ortam başına farklı olduğunda ve genelleştirilemediğinde iyidir (örneğin, bazı kaynaklar bir ortamda veya bazı bölgelerde yoktur)
{% endhint %}

{% hint style="warning" %}
Proje büyüdükçe bu ortamları birbirleriyle güncel tutmak zorlaşacaktır. Tekrarlanabilir görevler(task) için altyapı modüllerini (kullanıma hazır veya dahili) kullanmayı düşünebilirsiniz.
{% endhint %}

##
