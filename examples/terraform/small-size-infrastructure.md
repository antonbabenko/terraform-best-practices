# Terraform ile küçük ölçekli altyapı yönetimi

Kaynak: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

Bu örnek, hiçbir harici bağımlılığın kullanılmadığı küçük boyutlu bir altyapı için Terraform konfigürasyonları yapılandırılmasına yönelik örnek kodları içerir.

{% hint style="success" %}
* Başlamak ve geriye yönelik güncelleme yapmak için mükemmel.
* Küçük kaynak modülleri için harika
* Küçük ve doğrusal altyapı modülleri için iyi (ör. terraform-aws-atlantis).
* Az sayıda kaynak için iyi (20-30'dan az)
{% endhint %}

{% hint style="warning" %}
Tüm kaynaklar için tek durum dosyası, kaynak sayısı artıyorsa Terraform ile çalışma sürecini yavaşlatabilir (kaynak sayısını sınırlamak için -target argümanını kullanmayı düşününebilirsiniz)
{% endhint %}
