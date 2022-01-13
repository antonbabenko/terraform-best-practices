# Penggunaan Terraform Untuk Infrastruktur Skala Kecil

Sumber: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

Contoh ini mengandung kode sebagai ilustrasi dari struktur konfigurasi Terraform untuk infrastruktur berukuran kecil dimana tidak ada dependensi eksternal di dalamnya.

{% hint style="success" %}
* Sangat cocok untuk permulaan dan direstruktur seiring waktu
* Sangat cocok untuk modul sumber daya kecil
* Bagus untuk modul infrastruktur kecil dan linier (Contoh [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis))
* Bagus untuk sumber daya ukuran kecil (lebih sedikit jumlahnya dari 20-30)
{% endhint %}

{% hint style="warning" %}
Berkas keadaan tunggal untuk semua sumber daya dapat memperlambat proses bekerja dengan Terraform bila jumlah dari sumber daya terus meningkat (Pertimbangkan untuk menggunakan argumen`-target` untuk membatasi jumlah sumber daya)
{% endhint %}
