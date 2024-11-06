# Terraformを使用した小規模インフラ

ソース: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

この例には、外部依存がない小規模インフラストラクチャのためのTerraform構成を整理するコードが含まれています。

{% hint style="success" %}
* 初めての導入や進めながらのリファクタリングに最適
* 小規模なリソースモジュールに最適
* 小規模かつ直線的なインフラストラクチャモジュールに適している（例： [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis))
* リソースが少ない（20〜30未満）の場合に適している
{% endhint %}

{% hint style="warning" %}
すべてのリソースに対して単一の状態ファイルを使用すると、リソースが増え、Terraformの操作が遅くなる可能性があります（`-target`引数を使ってリソース数を制限することを検討してください）
{% endhint %}
