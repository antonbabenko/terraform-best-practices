# Terraformを使用した大規模インフラ

ソース: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/large-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/large-terraform)

この例は、大規模インフラストラクチャ向けのTerraform構成を整理するコード例で、以下の内容を使用しています。

* 2つのAWSアカウント
* 2つのリージョン
* 2つの独立した環境（プロダクションとステージング、共有は一切なし）。各環境は異なるAWSアカウント内にあり、2つのリージョン間でリソースを展開する
* 各環境は、[Terraform Registry](https://registry.terraform.io/)から取得した既製のインフラモジュール（`alb`）の異なるバージョンを使用
* 各環境は、ローカルディレクトリから取得される内部モジュール`modules/network`の同じバージョンを使用

{% hint style="info" %}
ここで説明するような大規模プロジェクトでは、Terragruntを使用する利点が非常に明確になります。[Terragruntのコード構造例](../terragrunt.md)をご覧ください。
{% endhint %}

{% hint style="success" %}
* インフラが論理的に分離されているプロジェクトに最適（AWSアカウントが分かれている場合）
* AWSアカウント間で共有されるリソースを変更する必要がない場合に適している（一つの環境＝一つのAWSアカウント＝一つの状態ファイル）
* 環境間での変更のオーケストレーションが不要な場合に適している
* 環境ごとにインフラリソースが異なり、一般化できない場合に適している（例：ある環境またはリージョンに存在しないリソースがある場合）
{% endhint %}

{% hint style="warning" %}
プロジェクトが成長するにつれ、これらの環境を互いに最新の状態に保つことが難しくなります。繰り返し行われるタスクには、既製または内部のインフラモジュールの使用を検討してください。
{% endhint %}

##
