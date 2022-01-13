# Struktur Kode

Pertanyaan-pertanyaan mengenai struktur kode Terraform sejauh ini merupakan hal yang paling sering ditemukan di dalam komunitas. Semua orang akan berpikir mengenai struktur kode terbaik untuk proyek mereka pada satu titik.

## Bagaimana sebaiknya menstrukturkan konfigurasi Terraform?



Banyak jawaban yang tersedia untuk pertanyaan di atas dan sangat sulit untuk memberikan saran yang bersifat universal. Maka dari itu mari kita mulai dengan pemahaman terhadap apa yang sedang kita hadapi.

* Bagaimana tingkat kompleksitas dari proyek Anda?
  * Jumlah dari sumber daya yang terhubung
  * Jumlah dari penyedia Terraform (Lihat catatan di bawah mengenai penyedia-penyedia logis)
* Seberapa sering infrastruktur Anda berubah?
  * Dari sekali sebulan/seminggu/sehari
  * Sampai secara terus-menerus (setiap kali ada _commit_ baru)
* Inisiator perubahan kode? Apakah Anda memperbolehkan server CI memperbarui repositori ketika artifak baru dibangun?
  * Hanya para pengembang yang boleh mendorong ke dalam repositori infrastruktur
  * Semua orang bisa mengajukan perubahan terhadap segala sesuatu dengan membuka PR (termasuk tugas-tugas otomatis yang berjalan di server CI)
* platform atau layanan penggelaran mana yang Anda gunakan?
  * AWS CodeDeploy, Kubernetes, atau OpenShift membutuhkan pendekatan yang berbeda
* Bagaimana lingkungan dikelompokan?
  * Berdasarkan lingkungan, wilayah, proyek



{% hint style="info" %}
_Penyedia-penyedia logis_ bekerja secara keseluruhan di dalam logik Terraform dan seringkali tidak berinteraksi dengan layanan-layanan lainnya. Maka dari itu kita bisa beranggapan nilai kompleksitasnya adalah O(1). Penyedia-penyedia logis yang umum adalah [random](https://registry.terraform.io/providers/hashicorp/random/latest/docs), [local](https://registry.terraform.io/providers/hashicorp/local/latest/docs), [terraform](https://www.terraform.io/docs/providers/terraform/index.html), [null](https://registry.terraform.io/providers/hashicorp/null/latest/docs), [time](https://registry.terraform.io/providers/hashicorp/time/latest).
{% endhint %}

## Memulai penstrukturan konfigurasi Terraform

Meletakan seluruh kode di dalam berkas `main.tf` merupakan ide yang baik ketika Anda baru memulai atau ketika menulis contoh kode. Pada kasus-kasus lainnya, Anda sebaiknya memisahkan konfigurasi secara logis ke dalam beberapa berkas sebagai berikut:

* `main.tf` - berisi modul-modul, _locals_, dan sumber data-sumber data untuk menciptakan seluruh sumber daya.
* `variables.tf` - berisi deklarasi variabel-variabel yang digunakan pada `main.tf`
* `outputs.tf` - berisi keluaran-keluaran dari sumber daya - sumber daya yang diciptakan pada `main.tf`
* `versions.tf` - berisi persyaratan versi untuk Terraform dan penyedia

`terraform.tfvars` sebaiknya tidak digunakan kecuali pada [komposisi](key-concepts.md#komposisi)

## Bagaimana cara pikir tentang struktur konfigurasi Terraform?

{% hint style="info" %}
Pastikan Anda paham konsep-konsep dasar - [modul sumber daya](key-concepts.md#modul-sumber-daya), [modul infrastruktur](key-concepts.md#modul-infrastruktur), dan [komposisi](key-concepts.md#komposisi), karena konsep-konsep tersebut digunakan pada contoh-contoh berikut.
{% endhint %}

### Rekomendasi umum struktur kode

* Lebih mudah dan lebih cepat bekerja dengan jumlah sumber daya yang lebih sedikit
  * `terraform plan` dan `terraform apply` keduanya memanggil API komputasi awan untuk memverifikasi status sumber daya
  * Jika seluruh infrastruktur Anda berada di dalam satu komposisi maka hal ini akan membuat operasi Terraform memakan waktu yang lama
* Radius ledakan menjadi lebih kecil dengan sumber daya yang lebih sedikit
  * Mengisolasi sumber daya yang tidak saling berkaitan dengan cara meletakan mereka di komposisi yang berbeda mengurangi resiko ketika terjadi kesalahan
* Mulai proyek Anda dengan menggunakan keadaan jarak jauh karena:
  * Laptop Anda bukanlah tempat sumber kebenaran infrastruktur Anda
  * Mengelola berkas `tfstate` di dalam git merupakan mimpi buruk
  * Ketika nantinya lapisan-lapisan infrastruktur mulai berkembang ke berbagai arah (jumlah dependensi atau sumber daya) maka akan lebih mudah bagi Anda untuk mengontrolnya
* Praktikan aturan penamaan dan struktur yang konsisten:
  * Seperti kode prosedural, kode Terraform sebaiknya ditulis dengan prinsip bawha kode akan dibaca oleh orang lain. Konsistensi akan membantu ketika perubahan terjadi di masa yang akan datang
  * Bukanlah hal yang mustahil untuk memindahkan sumber daya pada berkas keadaan Terraform. Tetapi hal tersebut mungkin sulit dilakukan jika Anda memiliki penamaan dan struktur yang tidak konsisten.
* Jaga modul-modul sumber daya sesederhana mungkin
* Jangan gunakan nilai kode keras (hard-coded) untuk nilai yang bisa diberikan sebagai variabel atau ditemukan menggunakan sumber data
* Gunakan sumber data dan `terraform_remote_state` secara khusus sebagai perekat antar modul infrastruktur di dalam komposisi

Di dalam buku ini, contoh proyek dikelompokan berdasarkan kompleksitas - dari infrastruktur yang kecil sampai sangat besar. Pemisahan ini tidak bersifat mutlak, jadi periksa juga struktur-struktur lainnya.

### Orkestrasi modul infrastruktur dan komposisi

Memiliki infrastruktur skala kecil sama artinya dengan memiliki jumlah dependensi dan sumber daya yang sedikit. Seiring berkembangnya proyek maka kebutuhan untuk mengeksekusi konfigurasi Terraform secara berantai akan semakin jelas keliatan. Selain itu, kebutuhan untuk menghubungan modul-modul infrastruktur yang berbeda dan menyampaikan nilai di dalam komposisi menjadi semakin jelas juga.

Setidaknya ada 5 group solusi orkestrasi yang berbeda yang bisa digunakan oleh pengembang:

* Hanya Terraform. Sangat lugas, pengembang hanya perlu mengetahui Terraform untuk menyelesaikan pekerjaan.
* Terragrunt. Alat orkestrasi murni yang bisa digunakan untuk mengorkestrasi keseluruhan infrastruktur dan juga dependensinya. Terragrunt beroperasi dengan modul infrastruktur dan komposisi secara asli. Hal ini mengurangi jumlah duplikasi kode.
* Berkas buatan sendiri. Seringkali hal ini terjadi sebagai titik awal menuju orkestrasi dan sebelum menemukan Terragrunt.
* Ansible atau alat otomatisasi umum lainnya. Umumnya digunakan ketika Terraform diadopsi setelah Ansible atau ketika Ansible UI digunakan secara aktif.
* [Crossplane](https://crossplane.io) dan solusi lainya yang terinspirasi dari Kubernetes. Kadangkala, merupakan hal yang masuk akal untuk menggunakan ekosistem Kubernetes dan mempekerjakan fitur lingkaran rekonsiliasi untuk mencapai keadaan yang diinginkan dari konfigurasi Terraform. Tonton video [Crossplane vs Terraform](https://www.youtube.com/watch?v=ELhVbSdcqSY) untuk informasi lebih lanjut.

Berdasarkan hal yang dijelaskan di atas, buku ini mengulas dua hal pertama dari solusi orkestrasi proyek yaitu hanya Terraform dan Terragrunt.

Lihat contoh struktur kode untuk [Terraform](https://www.terraform-best-practices.com/examples/terraform) atau [Terragrunt](https://www.terraform-best-practices.com/examples/terragrunt) pada bab selanjutnya.
