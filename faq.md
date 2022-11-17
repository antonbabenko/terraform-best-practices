---
description: MUT (Masalah Umum Terraform)
---

# Tanja Umum

## Alat-alat apa saja yang sebaiknya diketahui dan dipertimbangkan untuk digunakan?

* [**Terragrunt**](https://terragrunt.gruntwork.io/) - Tool orkestrasi
* [**tflint**](https://github.com/terraform-linters/tflint) - Linter kode
* [**tfenv**](https://github.com/tfutils/tfenv) - Pengelola versi
* [**Atlantis**](https://www.runatlantis.io/) - Otomatisasi Pull Request
* [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) - Kumpan kait git untuk Terraform yang digunakan bersamaan dengan [kerangka kerja pre-commit](https://pre-commit.com/)

## Apa yang menjadi solusi untuk masalah [dependency hell](https://en.wikipedia.org/wiki/Dependency\_hell) dengan modul?

Versi dari sumber daya dan modul infrastruktur sebaiknya menggunakan versi yang spesifik. Penyedia sebaiknya dikonfigurasi diluar modul tetapi hanya di dalam komposisi. Versi dari penyedia dan Terraform juga sebaiknya dikunci.

Tidak ada alat pengelola dependensi utama, tetapi ada beberapa tips untuk membuat dependensi menjadi lebih sedikit bermasalah. Sebagai contoh, [Dependabot](https://dependabot.com/) bisa digunakan untuk mengotomatisasi perbaruan dependensi. Dependabot membuat permintaaan penarikan untuk menjaga dependensi tetap aman dan terbaru. Dependabot mendukung konfigurasi Terraform.
