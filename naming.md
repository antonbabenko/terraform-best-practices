# Kaidah Penamaan

## Kaidah umum

{% hint style="info" %}
Seharusnya tidak ada alasan untuk menolak mengikuti kaidah berikut :)
{% endhint %}

{% hint style="info" %}
Sadarilah bahwa sumber daya awan seringkali memiliki keterbatasan tersendiri dalam pemberian nama. Sebagai contoh beberapa sumber daya tidak bisa menggunakan tanda hubung, atau harus menggunakan aturan penulisan huruf unta (camel case). Kaidah yang dimaksud dalam buku ini dimaksudkan  untuk nama sumber daya Terraform itu sendiri.
{% endhint %}

1. Gunakan `_` (garis bawah) daripada `-` (tanda hubung) dimana saja (nama sumber daya, nama sumber data, nama variabel, keluaran, dan lain-lain)
2. Pilihlah penggunaan huruf kecil dan angka (walaupun ada dukungan UTF-8)

## Argumen sumber daya dan sumber data

1.  Hindari mengulang jenis sumber daya pada nama sumber daya (baik itu sebagian atau sepenuhnya):

    {% hint style="success" %}
    `resource "aws_route_table" "public" {}`
    {% endhint %}

    {% hint style="danger" %}
    `resource "aws_route_table" "public_route_table" {}`
    {% endhint %}

    {% hint style="danger" %}
    `resource "aws_route_table" "public_aws_route_table" {}`
    {% endhint %}
2. Sumber daya sebaiknya dinamakan `this` jika tidak tersedia nama lain yang lebih deskriptif dan umum, atau jika modul sumber daya menciptakan sumber daya tunggal dari tipe tersebut. Sebagai contoh pada [modul AWS VPC](https://github.com/terraform-aws-modules/terraform-aws-vpc) terdapat sebuah sumber daya dengan tipe `aws_nat_gateway` dan beberapa sumber daya dengan tipe `aws_route_table`. Maka dari itu sumber daya `aws_nat_gateway` sebaiknya dinamakan `this` dan `aws_route_table` diberi nama yang lebih deskriptif seperti `privat`, `publik`, `database`.
3. Selalu gunakan kata benda tunggal sebagai nama.
4. Gunakan `-` pada nilai argumen dan ditempat-tempat lain dimana nilai akan dipaparkan ke orang lain (Contoh di dalam nama DNS sebuah RDS).
5. Letakan argumen `count` / `for_each` pada baris pertama di dalam blok sumber daya atau sumber data dan tambahkan baris baru untuk memisahkan dengan argumen lainnya.
6. Letakan argumen `tags` (jika sumber daya mendukung hal tersebut) sebagai argumen terakhir, diikuti oleh `depends_on` dan `lifecycle` jika diperlukan. Semua argumen tersebut sebaiknya dipisahkan oleh satu baris kosong.
7. Ketika menggunakan argumen `count` / `for_each` sebagai pernyataan bersyarat, pilihlah nilai _boolean_ dibandingkan `length` atau ekspresi lainnya

## Contoh kode _resource_

### Penggunaan `count` / `for_each`

{% hint style="success" %}
{% code title="main.tf" %}
```hcl
resource "aws_route_table" "public" {
  count = 2

  vpc_id = "vpc-12345678"
  # ... sisa argumen sengaja dihilangkan
}

resource "aws_route_table" "private" {
  for_each = toset(["one", "two"])

  vpc_id = "vpc-12345678"
  # ... sisa argumen sengaja dihilangkan
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

  # ... sisa argumen sengaja dihilangkan
}
```
{% endcode %}
{% endhint %}

### Penempatan `tags`

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

### Pernyataan bersyarat `count`

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

## Variabel

1. Hindari membuat ulang secara mandiri (don't reinvent the wheel) pada modul sumber daya: gunakan `name`, `description`, dan nilai `default` untuk variabel seperti yang didefinisikan pada bagian "Referensi Argumen" untuk sumber daya yang Anda kerjakan.
2. Dukungan untuk validasi variabel bersifat terbatas (Contoh tidak bisa mengakses variabel lain atau melakukan pencarian). Buat perencanaan validasi dengan baik karena fitur ini tidak bisa digunakan pada beberapa kasus tertentu.
3. Gunakan bentuk jamak pada nama variabel dengan tipe `list(...)` atau `map(...)`.
4. Urutkan nama atribut di dalam blok variabel seperti berikut: `description`, `type`, `default`, `validation`
5. Selalu sertakan `description` disemua variabel walaupun menurut Anda hal tersebut sudah jelas (Anda akan membutuhkannya dimasa yang akan datang).
6. Pilihlah tipe-tipe sederhana (`number`, `string`, `list(...)`, `map(...)`, `any`) daripada tipe yang lebih spesifik seperti `object()` kecuali Anda memerlukan batasan ketat pada setiap atributnya.
7. Gunakan tipe spesifik seperti `map(map(string))` jika seluruh elemen dari `map` memiliki tipe yang sama (Contoh `string`) atau bisa dikonversikan menjadi tipe tersebut (Contoh tipe `number` bisa dikonversi menjadi `string`).
8. Gunakan tipe `any` untuk menonaktifkan validasi tipe mulai dari level tertentu atau ketika perlu mendukung berbagai tipe.
9. Nilai `{}` bisa bertipe `map` atau bisa juga bertipe `object`. Gunakan `tomap(...)` untuk konversi menjadi map karena tidak ada cara untuk mengubah menjadi `object`.

## Keluaran

Buat keluaran konsisten dan mudah dipahami diluar cakupan mereka (Tipe dan atribut dari nilai yang dikembalikan harus jelas bagi pengguna modul ketika menggunakan modul tersebut).

1. Nama keluaran sebaiknya menjelaskan properti yang dimiliki dan tidak terlalu menggunakan bentuk bebas yang biasa kita inginkan.
2. Struktur yang baik untuk nama keluaran berbentuk `{name}_{type}_{attribute}`, dimana:
   1. `{name}` adalah nama sumber daya atau sumber data tanpa awalan penyedia. Sebagai contoh `{name}` untuk `aws_subnet` adalah `subnet`, `{name}` untuk `aws_vpc` adalah `vpc`.
   2. `{type}` adalah tipe dari sumber daya
   3. `{attribute}` adalah atribut dari nilai keluaran
   4. Lihat [contoh](naming.md#code-examples-of-output)
3. Jika keluaran mengembalikan nilai dengan fungsi interpolasi dan banyak sumber daya maka `{name}` dan `{type}` sebaiknya dibuat seumum mungkin (`this` sebagai prefiks sebaiknya diabaikan saja). Lihat [contoh](naming.md#code-examples-of-output).
4. Jika nilai kembalian adalah sebuah daftar maka gunakan bentuk jamak sebagai nama. Lihat [contoh](naming.md#use-plural-name-if-the-returning-value-is-a-list).
5. Selalu sertakan `description` untuk semua keluaran walaupun hal itu dirasa sudah jelas.
6. Hindari argumen `sensitive` kecuali Anda mengontrol penuh penggunaan keluaran tersebut diseluruh tempat pada seluruh modul.

### Contoh kode `output`

Kembalikan paling banyak satu ID dari _security group_::

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

Ketika bekerja dengan banyak sumber daya berjenis sama, `this` sebaiknya diabaikan dari nama keluaran:

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

### Gunakan bentuk jamak jika mengembalikan nilai yang berupa daftar

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

