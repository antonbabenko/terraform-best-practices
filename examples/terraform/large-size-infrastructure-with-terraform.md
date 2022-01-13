# Penggunaan Terraform Untuk Infrastruktur Skala Besar

Sumber: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/large-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/large-terraform)

Contoh di atas berisi kode sebagai ilustrasi struktur konfigurasi Terraform untuk infrastruktur ukuran besar yang mengandung hal berikut:

* 2 akun AWS
* 2 wilayah
* 2 lingkungan terpisah (`prod` dan `stage` yang tidak berbagi apa pun). Setiap lingkungan hidup di akun yang berbeda dan menjangkau sumber daya di 2 wilayah
* Setiap lingkungan menggunakan versi yang berbeda dari modul infrastruktur siap pakai (`alb`) yang berasal dari [Terraform Registry](https://registry.terraform.io)
* Setiap lingkungan menggunakan versi yang sama dari modul internal `modules/network` yang bersumber dari direktori lokal.

{% hint style="info" %}
Pada proyek besar seperti yang dijabarkan di atas, manfaat dari penggunaan Terragrunt menjadi sangat jelas. Lihat Contoh struktur kode pada Terragrunt .
{% endhint %}

{% hint style="success" %}
* Sangat cocok untuk proyek dengan infrastruktur yang terpisah secara logis (akun AWS berbeda)
* Cocok ketika tidak ada kebutuhan untuk mengubah sumber daya bersama antar akun AWS (satu lingkungan = satu akun AWS = satu berkas keadaan)
* Bagus ketika tidak ada kebutuhan mengorkestrasi perubahan antar lingkungan
* Bagus ketika sumber daya infrastruktur sengaja dibedakan untuk setiap lingkungan dan tidak bisa digeneralisasi (Contoh beberapa sumber daya tidak ada di satu lingkungan atau beberapa wilayah)
{% endhint %}

{% hint style="warning" %}
Seiring berkembangnya proyek, akan menjadi lebih sulit untuk menjaga supaya lingkungan-lingkungan tersebut mutakhir. Pertimbangkan untuk menggunakan modul infrastruktur (siap pakai atau internal) untuk pekerjaan yang berulang.
{% endhint %}

##
