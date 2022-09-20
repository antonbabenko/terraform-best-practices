# Adlandırma Kuralları

## Genel Kurallar

{% hint style="info" %}
En azından bu kurallara uymamak için hiçbir sebep olmamalı :)
{% endhint %}

{% hint style="info" %}
Gerçek bulut kaynaklarının genellikle izin verilen adlarda kısıtlamalara sahip olduğuna dikkat edin. Örneğin, bazı kaynaklar tire içeremez, bazıları camelCased olmalıdır. Bu kitaptaki kurallar, Terraform adlarının kendilerine atıfta bulunur.
{% endhint %}

1. Her yerde `-` (tire) yerine `_` (alt çizgi) kullanın (kaynak adlarında, veri kaynağı adlarında, değişken adlarında, çıktılarda vb.).
2. Küçük harf ve rakam kullanmayı tercih edin (UTF-8 desteklense de).

## Kaynak ve veri kaynağı parametreleri

1. Kaynak adında kaynak türünü tekrar etmeyin (kısmen veya tamamen değil):

{% hint style="success" %}
```
`resource "aws_route_table" "public" {}`
```
{% endhint %}

{% hint style="danger" %}
```
`resource "aws_route_table" "public_route_table" {}`
```
{% endhint %}

{% hint style="danger" %}
```
`resource "aws_route_table" "public_aws_route_table" {}`
```
{% endhint %}

1. Daha fazla açıklayıcı ve genel ad yoksa veya kaynak modülü bu türde tek bir kaynak oluşturuyorsa (örneğin, AWS VPC modülünde `aws_nat_gateway` türünde tek bir kaynak varsa ve `typeaws_route_table` türünde birden çok kaynak varsa) kaynak adı bu şekilde adlandırılmalıdır: `aws_nat_gateway` bu şekilde adlandırılmalı ve `aws_route_table` daha açıklayıcı adlara sahip olmalıdır - private, public, database gibi).
2. Mutlaka tekli isimler kullanın.
3. `-` Çizgiyi parametre değerlerinin girildiği değişkenlerde kullanabilirsiniz.
4. '`count`' veya '`for_each`' kullanan bir parametre veya veri kaynağı bloğu ilk parametre olmalıdır ve yeni bir satırla ayrılarak en üstte konumlanmalıdır.
5. Mümkün olduğunca son parametrede `depends_on`, `lifecycle` gibi etiketleri(`tags`) kullanmaya çalışın.
6. '`count`' veya '`for_each`' kullanırken mümkün olduğunca boolean değerleri tercih edin. Length veya başka karşılaştırmaları ikinci plana atmanız iyi olacaktır.

## '`Kaynak(Resource)`' kod örneği

### `count/for_each` kullanımı

{% hint style="success" %}
{% code title="main.tf" %}
```hcl
resource "aws_route_table" "public" {
  count = 2

  vpc_id = "vpc-12345678"
  # ... remaining arguments omitted
}

resource "aws_route_table" "private" {
  for_each = toset(["one", "two"])

  vpc_id = "vpc-12345678"
  # ... remaining arguments omitted
}
```
{% endcode %}
{% endhint %}

{% hint style="danger" %}
{% code title="main.tf" %}
```hcl
resource "aws_route_table" "public" {
  vpc_id = "vpc-12345678"
  count  = 2

  # ... remaining arguments omitted
}
```
{% endcode %}
{% endhint %}

### Etiketlerin Kullanımı (`tags`)

{% hint style="success" %}
{% code title="main.tf" %}
```hcl
resource "aws_nat_gateway" "this" {
  count = 2

  allocation_id = "..."
  subnet_id     = "..."

  tags = {
    Name = "..."
  }

  depends_on = [aws_internet_gateway.this]

  lifecycle {
    create_before_destroy = true
  }
}   
```
{% endcode %}
{% endhint %}

{% hint style="danger" %}
{% code title="main.tf" %}
```hcl
resource "aws_nat_gateway" "this" {
  count = 2

  tags = "..."

  depends_on = [aws_internet_gateway.this]

  lifecycle {
    create_before_destroy = true
  }

  allocation_id = "..."
  subnet_id     = "..."
}
```
{% endcode %}
{% endhint %}

### `count` içerisindeki karşılaştırmalar

{% hint style="success" %}
{% code title="outputs.tf" %}
```hcl
resource "aws_nat_gateway" "that" {    # Best
  count = var.create_public_subnets ? 1 : 0
}

resource "aws_nat_gateway" "this" {    # Good
  count = length(var.public_subnets) > 0 ? 1 : 0
}
```
{% endcode %}
{% endhint %}

## Değişkenler

1. Kaynak modüllerinde tekerleği yeniden icat etmeyin: birlikte çalıştığınız kaynak için "Argüman Referansı" bölümünde tanımlandığı gibi değişkenler için `ad`, `açıklama` ve `varsayılan değeri` kullanın.
2. Değişkenlerde doğrulama desteği oldukça sınırlıdır (örneğin, diğer değişkenlere erişemez veya arama yapamaz). Buna göre plan yapın çünkü çoğu durumda bu özellik işe yaramaz.
3. Tür `list(...)` veya `map(...)` olduğunda, değişken adında çoğul formu kullanın.
4. 'Key'leri aşağıdaki sırada olacak şekilde bir değişken bloğunda muhafaza ediniz. Tanım(`Description`), tip(`type`), `default`(Fabrika Ayarı), doğrulama(`validation`)
5. Açık olduğunu düşünseniz bile her zaman tüm değişkenlere açıklama ekleyin (gelecekte buna ihtiyacınız olacak).
6. Her bir anahtar üzerinde katı kısıtlamalarınız olması gerekmedikçe, `object()` gibi belirli türler yerine basit türleri (`number`, `string`, `list(...)`, `map(...)`, herhangi biri) kullanmayı tercih edin.
7. `map'in` tüm öğeleri aynı türe sahipse (ör. `string`) veya buna dönüştürülebiliyorsa (ör. `number` türü stringe dönüştürülebilirse) `map(map(string))` gibi belirli türleri kullanın.
8. Belirli bir derinlikten başlayarak veya birden çok türün desteklenmesi gerektiğinde tür doğrulamasını devre dışı bırakmak için 'any' kullanın.
9. `{}` değeri bazen bir map, bazen de bir objedir. Map'e çevirmek için `tomap(...)` kullanın çünkü bir obje yapmanın yolu yoktur.

## Çıktılar

Çıktıları kapsamı dışında tutarlı ve anlaşılır hale getirin (bir kullanıcı bir modül kullanırken, döndürdüğü değerin türünü ve niteliğini açıkça belirtmelidir).

1. Çıktının adı, içerdiği özelliği tanımlamalı ve normalde istediğinizden daha az serbest biçimli olmalıdır.
2. Çıktı adı için iyi bir yapı `{name}_{type}_{attribute}`gibi görünür, burada:
   1. `{name}` bir kaynak veya veri kaynağı olabilir. Tabiki sağlayıcı prefixi olmadan. `aws_subnet` için `{name}` '`subnet'dir`, `foraws_vpc` '`vpc`'dir.
   2. `{type}` ise kaynağın tipini belirtmektedir.
   3. `{attribute}`, çıktı tarafından döndürülen bir niteliktir
   4. [Örnekleri inceleyebilirsiniz](naming.md#code-examples-of-output).
3. Eğer çıktılar interpolation fonksiyonlarını veya çoklu kaynak barındıran bir değer döndürüyorsa `{name}` ve `{type}` mümkün olduğunca genel olmalıdır. [Örneği inceleyebilirsiniz.](naming.md#code-examples-of-output)
4. Eğer döndürülen değer bir list ise çoğul bir isme sahip olmalıdır.
5. Çok açık olduğunu düşündüğünüz çıktılar dahil mutlaka tüm çıktılara tanım(`description`) ekleyiniz.
6. Tüm modüllerde bu çıktının kullanımını tamamen kontrol etmedikçe `sensetive` argüman kullanmaktan kaçının.
7. `element(concat(...))` yerine `try()`'ı (Terraform 0.13'ten beri mevcuttur) tercih edin (0.13'ten önceki sürüm için eski yaklaşım)

### Çıktı(`Output`) için kod örnekleri

En fazla güvenlik grubunun bir ID'sini döndürün:

{% hint style="success" %}
{% code title="outputs.tf" %}
```hcl
output "security_group_id" {
  description = "The ID of the security group"
  value       = try(aws_security_group.this[0].id, aws_security_group.name_prefix[0].id, "")
}
```
{% endcode %}
{% endhint %}

Aynı türden birden fazla kaynağa sahip olduğunda, çıktı adına bu kaçınılmalıdır:

{% hint style="danger" %}
{% code title="outputs.tf" %}
```hcl
output "this_security_group_id" {
  description = "The ID of the security group"
  value       = element(concat(coalescelist(aws_security_group.this.*.id, aws_security_group.web.*.id), [""]), 0)
}
```
{% endcode %}
{% endhint %}

### Eğer dönen değer list ise çoğul isim kullanımı

{% hint style="success" %}
{% code title="outputs.tf" %}
```hcl
output "rds_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = aws_rds_cluster_instance.this.*.endpoint
}
```
{% endcode %}
{% endhint %}
