# Contoh-Contoh Struktur Kode

## Struktur kode Terraform

{% hint style="info" %}
Contoh-contoh berikut menggunakan penyedia AWS tetapi sebagian besar prinsip yang digunakan pada contoh-contoh di bawah dapat diaplikasikan ke penyedia komputasi awan dan juga penyedia lainnya seperti DNS, Basis data, Pemantauan sistem, dan lain-lain.
{% endhint %}

| Tipe                                                           | Deskripsi                                                                                                                                                                     | Tingkat Kesiapan        |
| -------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------- |
| [kecil](terraform/small-size-infrastructure.md)                | Beberapa sumber daya, tanpa dependensi eksternal. Satu akun AWS. Satu wilayah. Lingkungan tunggal.                                                                            | Ya                      |
| [sedang](terraform/medium-size-infrastructure.md)              | Beberapa lingkungan dan akun AWS, modul-modul infrastruktur siap pakai. Menggunakan Terraform.                                                                                | Ya                      |
| [besar](terraform/large-size-infrastructure-with-terraform.md) | Banyak akun AWS, banyak wilayah, kebutuhan yang mendesak untuk mengurangi salin tempel, modul infrastruktur pesanan, penggunaan komposisi kelas berat. Menggunakan Terraform. | Sedang dalam pengerjaan |
| Sangat besar                                                   | Beberapa penyedia (AWS, GCP, Azure). Penggelaran di banyak komputasi awan. Menggunakan Terraform.                                                                             | Tidak                   |

## Terragrunt code structures

| Tipe         | Deskripsi                                                                                                                                    | Tingkat Kesiapan |
| ------------ | -------------------------------------------------------------------------------------------------------------------------------------------- | ---------------- |
| sedang       | Beberapa akun AWS dan lingkungan, modul infrastruktur siap pakai, pola komposisi menggunakan Terragrunt.                                     | Tidak            |
| besar        | Banyak akun AWS, banyak wilayah, kebutuhan mendesak untuk mengurangi salin tempel, penggunaan komposisi kelas berat. Menggunakan Terragrunt. | Tidak            |
| sangat besar | Beberapa penyedia (AWS, GCP, Azure). Penggelaran di banyak komputasi awan. Menggunakan Terragrunt.                                           | Tidak            |
