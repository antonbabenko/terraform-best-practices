# Penggunaan Terraform Untuk Infrastruktur Skala Sedang

Sumber: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform)

Contoh di atas berisi kode sebagai ilustrasi struktur konfigurasi Terraform untuk infrastruktur dengan ukuran medium yang menggunakan hal berikut:

* 2 buah akun AWS
* 2 lingkungan yang berbeda (`prod` dan `stage` yang tidak berbagi apa pun). Setiap lingkungan hidup di dalam akun AWS yang berbeda.
* Setiap lingkungan menggunakan versi yang berbeda dari modul infrastruktur siap pakai (`alb`) yang berasal dari [Terraform Registry](https://registry.terraform.io)
* Setiap lingkungan menggunakan versi yang sama dari modul internal `modules/network` yang bersumber dari direktori lokal.

{% hint style="success" %}
* Sangat cocok untuk proyek dengan infrastruktur yang terpisah secara logis (Akun AWS yang berbeda)
* Cocok ketika tidak ada kebutuhan untuk mengubah sumber daya bersama antar akun AWS (satu lingkungan = satu akun AWS = satu berkas keadaan)
* Bagus ketika tidak ada kebutuhan mengorkestrasi perubahan antar lingkungan
* Bagus ketika sumber daya infrastruktur sengaja dibedakan untuk setiap lingkungan dan tidak bisa digeneralisasi (Contoh beberapa sumber daya tidak ada di satu lingkungan atau beberapa wilayah)
{% endhint %}

{% hint style="warning" %}
Seiring berkembangnya proyek, akan menjadi lebih sulit untuk menjaga supaya lingkungan-lingkungan tersebut mutakhir. Pertimbangkan untuk menggunakan modul infrastruktur (siap pakai atau internal) untuk pekerjaan yang berulang.
{% endhint %}

##
