# Penataan Kode

{% hint style="info" %}
* Contoh dan modul Terraform sebaiknya disertai dengan dokumentasi yang menjelaskan fitur-fitur dan cara penggunaannya.
* Semua tautan pada berkas README.md sebaiknya menggunakan tautan absolut sehingga tautan akan ditampilkan dengan benar pada halaman Terraform Registry.
* Dokumentasi bisa diisi dengan diagram yang dibuat menggunakan [mermaid](https://github.com/mermaid-js/mermaid) dan cetak biru buatan [cloudcraft.co](https://cloudcraft.co).
* Gunakan [kait-kait pre-commit Terraform](https://github.com/antonbabenko/pre-commit-terraform) untuk memastikan kode valid, diformat dengan benar, dan terdokumentasi secara otomatis sebelum dikirim ke git dan ditinjau oleh orang lain.
{% endhint %}

## Dokumentasi

### Dokumentasi secara otomatis

[pre-commit](https://pre-commit.com) merupakan kerangka kerja untuk mengelola dan memelihara kait pre-commit multi bahasa. Pre-commit ditulis dalam bahasa Python dan merupakan alat ampuh untuk melakukan sesuatu secara otomatis pada mesin pengembang sebelum kode disimpan pada repositori git. Umumnya alat ini digunakan untuk menjalankan _linter_ dan memformat kode (Lihat [kait yang didukung](https://pre-commit.com/hooks.html)).

Kita bisa menggunakan `pre-commit` untuk memformat dan memvalidasi konfigurasi Terraform dan juga untuk memperbarui dokumentasi.

Periksa [repository pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md) untuk membiasakan diri Anda akan penggunaan pre-commit untuk Terraform. Beberapa repositori seperti [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc) sudah menggunakan pre-commit.

### terraform-docs

[terraform-docs](https://github.com/segmentio/terraform-docs) merupakan alat untuk menciptakan dokumentasi modul Terraform dalam berbagai format keluaran. Kita dapat menjalankan terraform-docs secara manual (tanpa kait pre-commit) atau via [kait pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform) untuk memperbarui dokumentasi secara otomatis.

@todo: Dokumentasikan versi modul, rilis, dan GH actions

## Sumber daya

1. [halaman depan kerangka kerja pre-commit](https://pre-commit.com)
2. [Kumpulan kait-kait git untuk Terraform menggunakan kerangka kerja pre-commit](https://github.com/antonbabenko/pre-commit-terraform)
3. Tulisan blog oleh [Dean Wilson](https://github.com/deanwilson): [pre-commit hooks and terraform - a safety net for your repositories](https://www.unixdaemon.net/tools/terraform-precommit-hooks/)
