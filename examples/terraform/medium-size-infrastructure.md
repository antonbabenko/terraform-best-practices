# Terraform ile orta ölçekli altyapı yönetimi

Kaynak: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform)

Bu örnek, aşağıdakileri kullanan orta ölçekli bir altyapı için Terraform konfigürasyonlarının yapılandırılmasına örnek kodları içerir:

* 2 AWS hesabı
* 2 ayrı ortam (tamamen birbirlerinden izole `prod` ve `stage`). Her ortam ayrı bir AWS hesabında yaşar
* Her ortam, Terraform Registry kaynaklı hazır altyapı modülünün (alb) farklı bir sürümünü kullanır.
* Her ortam, dahili modüllerin aynı versiyonu kullanır.

{% hint style="success" %}
* Altyapının mantıksal olarak ayrıldığı projeler için mükemmel (ayrı AWS hesapları)
* AWS hesapları arasında paylaşılan kaynakları değiştirmeye gerek olmadığında iyidir (bir ortam = bir AWS hesabı = bir durum dosyası)
* Ortamlar arasındaki değişikliklerin yönetilmesine gerek olmadığında iyidir
* Altyapı kaynakları ortam başına farklı olduğunda ve genelleştirilemediğinde iyidir (örneğin, bazı kaynaklar bir ortamda veya bazı bölgelerde yoktur)
{% endhint %}

{% hint style="warning" %}
Proje büyüdükçe bu ortamları birbirleriyle güncel tutmak zorlaşacaktır. Tekrarlanabilir görevler(task) için altyapı modüllerini (kullanıma hazır veya dahili) kullanmayı düşünün.
{% endhint %}

##
