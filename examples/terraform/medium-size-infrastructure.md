# Terraformを使用した中規模インフラ

ソース: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform)

この例は、中規模インフラストラクチャのためのTerraform構成を整理するコード例で、次の内容を使用しています。

* 2つのAWSアカウント
* 2つの独立した環境（プロダクションとステージング、共有は一切なし）。各環境は異なるAWSアカウント内に存在する
* 各環境は、[Terraform Registry](https://registry.terraform.io/)から取得した既製のインフラモジュール（ALB）の異なるバージョンを使用
* 各環境は、ローカルディレクトリから取得される内部モジュール`modules/network`の同じバージョンを使用

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
