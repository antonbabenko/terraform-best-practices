# Konsep Dasar

Dokumentasi ofisial Terraform menjabarkan [seluruh aspek konfigurasi secara detail](https://www.terraform.io/docs/configuration/index.html). Bacalah secara seksama untuk memahami sisa dari bagian ini.

Bagian ini menjabarkan konsep-konsep dasar yang digunakan pada buku ini.

## Sumber daya (resource)

Contoh dari sumber daya pada Terraform adalah `aws_vpc`, `aws_db_instance`, dan lain sebagainya. Sumber daya merupakan bagian dari penyedia (provider), menerima argumen-argumen, mengeluarkan atribut-atribut, dan memiliki siklus hidup. Sumber daya dapat diciptakan, diambil, diperbarui, dan dihapus.

## Modul sumber daya

Modul sumber daya adalah sekumpulan sumber daya yang terhubung secara bersamaan untuk mencapai tujuan tertentu. Contohnya adalah [modul Terraform AWS VPC](https://github.com/terraform-aws-modules/terraform-aws-vpc/). Modul ini menciptakan VPC, subnet, dan pintu gerbang NAT (NAT gateway). Modul sumber daya bergantung pada konfigurasi penyedia yang bisa didefinisikan pada module itu sendiri atau pada struktur lain yang lebih tinggi levelnya.

## Modul infrastruktur

Modul infrastruktur adalah sekumpulan modul sumber daya yang mungkin saja tidak terhubung secara logis, tetapi memiliki fungsi yang sama pada situasi/proyek/susunan saat ini. Modul infrastruktur mendefinisikan konfigurasi penyedia-penyedia yang akan dialirkan ke modul-modul sumber daya dan sumber daya yang ada di hilir. Modul infrastruktur umumnya bekerja secara terbatas pada satu entitas yang terpisah secara logis. Contohnya wilayah AWS, atau proyek Google.

Kita ambil modul [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis/) sebagai contoh. Modul ini menggunakan modul-modul sumber daya lain seperti [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc/) dan [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group/) untuk mengelola infrastruktur yang dibutuhkan dalam menjalankan [Atlantis](https://www.runatlantis.io) pada [AWS Fargate](https://aws.amazon.com/fargate/).

Contoh lainnya adalah modul [terraform-aws-cloudquery](https://github.com/cloudquery/terraform-aws-cloudquery). Pada modul ini terdapat berbagai modul lain berasal dari [terraform-aws-modules](https://github.com/terraform-aws-modules/) yang digunakan secara bersamaan untuk mengelola infrastruktur. Selain itu module ini juga menggunakan sumber daya Docker untuk membangun, mendorong, dan mengelar gambar-gambar (image) Docker. Semuanya ada di dalam satu paket.

## Komposisi

Komposisi adalah sekumpulan modul infrastruktur yang mencakup berbagai area yang terpisah secara logis (Contoh wilayah AWS, beberapa akun AWS). Komposisi digunakan untuk menjabarkan secara penuh infrastruktur yang dibutuhkan oleh seluruh organisasi atau proyek.

Komposisi terdiri dari modul-modul infrastruktur yang di dalamnya berisi modul-modul sumber daya yang pada hakikatnya berisi sumber daya - sumber daya individu.

![Komposisi infrastruktur sederhana](.gitbook/assets/composition-1.png)

## Sumber data (data source)

Sumber data hanya melakukan operasi baca (read-only) dan bergantung pada konfigurasi penyedia. Sumber data digunakan oleh modul sumber daya dan modul infrastruktur.

Sumber data `terraform_remote_state` bertindak sebagai perekat untuk modul-modul dan komposisi-komposisi tingkat tinggi.

Sumber data [eksternal](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data\_source) memungkinkan program lain untuk bertindak sebagai sumber data, mengekspos data arbitrer untuk digunakan di tempat lain di dalam konfigurasi Terraform. Kita ambil contoh modul [terraform-aws-lambda](https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/258e82b50adc451f51544a2b57fd1f6f8f4a61e4/package.tf#L5-L7). Pada modul ini nama berkas dikomputasi dengan cara memanggil naskah Python eksternal.

Sumber data [http](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) mengirimkan permintaan HTTP GET ke target URL dan mengekspor informasi seputar respons dari permintaan tersebut. Sumber data ini berguna untuk mendapatkan informasi dari titik akhir ketika tidak tersedianya penyedia asli Terraform untuk berkomunikasi dengan titik akhir tersebut.

## Keadaan jarak jauh

Modul-modul infrastruktur dan komposisi-komposi sebaiknya menyimpan [keadaan Terraform](https://www.terraform.io/docs/language/state/index.html) di lokasi jarak jauh dimana keadaan tersebut bisa diambil oleh pihak lain secara terkontrol (Misal dengan adanya ACL, pembuatan versi, dan pembuatan catatan).

## Penyedia, pengada, dan lain-lain

Penyedia, pengada, dan beberapa istilah lainnya dijabarkan dengan baik pada dokumentasi resmi dan tidak ada gunanya dijabarkan ulang di sini. Menurut pendapat penulis, mereka tidak begitu berguna dalam kaitannya untuk menulis modul Terraform yang baik.

## Kok susah ya?

Ketika sumber daya - sumber daya individu diandaikan seperti atom di infrastruktur, maka modul sumber daya adalah molekul. Modul adalah unit terkecil yang dapat diversikan dan dibagikan. Modul memiliki daftar argumen yang tepat dan mengimplementasi logik dasar untuk unit tersebut sehingga dapat menjalankan fungsinya. Contohnya adalah modul [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group). Modul ini menciptakan sumber daya `aws_security_group` dan `aws_security_group_list` berdasarkan masukan yang diberikan. Modul sumber daya ini sendiri bisa digunakan bersamaan dengan modul-modul lain untuk menciptakan modul infrastruktur.

Akses terhadap data lintas molekul (modul sumber daya dan infrastruktur) dilakukan menggunakan keluaran modul dan sumber data.

Akses antar komposisi seringkali dilakukan menggunakan sumber data jarak jauh. Ada [beberapa cara untuk membagikan data antara konfigurasi](https://www.terraform.io/docs/language/state/remote-state-data.html#alternative-ways-to-share-data-between-configurations).

Berikut contoh penjabaran konsep di atas dalam hubungan semu:

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
