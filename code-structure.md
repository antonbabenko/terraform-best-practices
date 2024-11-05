# コード構造

Terraformのコード構造に関する質問は、コミュニティで最も頻繁に見られるものです。誰もが一度はプロジェクトの最適なコード構造について考えたことがあるでしょう。

## Terraformの設定はどのように構造化すべきでしょうか？

これは多くの解決策が存在する質問の一つであり、普遍的なアドバイスを提供することは非常に難しいため、まず私たちが扱っているものを理解することから始めましょう。

* プロジェクトの複雑さはどの程度ですか？
  * 関連するリソースの数
  * Terraformプロバイダーの数 (下記の「論理的なプロバイダー」に関する注記を参照)
* インフラの変更頻度は？
  * 月1回/週1回/1日1回
  * 継続的 (新しいコミットがある度に毎回)
* 誰がコードを変更しますか？ 新しいアーティファクトがビルドされた時にCIサーバーがリポジトリを更新することを許可していますか？
  * 開発者のみがインフラのリポジトリにプッシュ可能
  * 誰でも（CIサーバー上で実行される自動化されたタスクを含む）PRをオープンすることで何かしらの変更を提案可能
* どのデプロイメントプラットフォームまたはデプロイメントサービスを使用していますか？
  * AWS CodeDeploy、Kubernetes、OpenShiftは少し異なるアプローチが必要
* 環境はどのようにグループ化されていますか？
  * 環境、リージョン、プロジェクトごと

{% hint style="info" %}
論理的なプロバイダーはTerraformのロジック内だけで完全に動作し、他のサービスとの相互作用はほとんどありません。そのため、その複雑さはO(1)として考えることができます。最も一般的な論理的なプロバイダーには、[random](https://registry.terraform.io/providers/hashicorp/random/latest/docs)、[local](https://registry.terraform.io/providers/hashicorp/local/latest/docs)、[terraform](https://www.terraform.io/docs/providers/terraform/index.html)、[null](https://registry.terraform.io/providers/hashicorp/null/latest/docs)、[time](https://registry.terraform.io/providers/hashicorp/time/latest) などがあります。
{% endhint %}

## Terraformの設定の構造化を始めるにあたって

すべてのコードを `main.tf` に配置することは、初めて始める時やサンプルコードを書く時には良い方法です。それ以外の場合は、以下のように論理的に複数のファイルに分割する方が良いでしょう：

* `main.tf` - モジュール、ローカル変数、データソースを呼び出してすべてのリソースを作成します
* `variables.tf` - `main.tf`で使用される変数の宣言を含みます
* `outputs.tf` - `main.tf`で作成されたリソースからの出力を含みます
* `versions.tf` - Terraformとプロバイダーのバージョン要件を含みます

`terraform.tfvars` は、 [composition](key-concepts.md#composition) 以外では使用すべきではありません。

## Terraformの設定構造についての考え方

{% hint style="info" %}
以下の例で使用される主要な概念の [resource module](key-concepts.md#resource-module)、[infrastructure module](key-concepts.md#infrastructure-module)、 [composition](key-concepts.md#composition) を必ず理解してください。
{% endhint %}

### コードを構造化するための一般的な推奨事項

* より少ないリソース数で作業する方が容易で速い
  * `terraform plan`と `terraform apply` はともに、リソースの状態を確認するためにクラウドAPIを呼び出します
  * インフラ全体を単一の構成にまとめると時間がかかる可能性がある
* セキュリティ侵害時の影響範囲はリソースが少ない方が小さい
  * 関連のないリソースを別々の構成に配置することで、問題が発生した場合のリスクを軽減
* プロジェクトはリモートステートを使用して開始してください。その理由は:
  * あなたのラップトップは、インフラの信頼できる情報源として適切な場所ではありません
  * gitでtfstateファイルを管理することは悪夢のようなものです
  * 後にインフラレイヤーが複数の方向（依存関係やリソースの数）に成長した時、制御しやすい
* 一貫した構造と[命名](naming.md)規則を実践してください
  * 手続き型コードと同様に、Terraformコードは最初に人が読むことを考えて書かれるべきです。一貫性があれば、6ヶ月後に変更が必要になった時に役立ちます
  * Terraformステートファイル内でリソースを移動することは可能ですが、構造や命名に一貫性がない場合、移動が困難になる可能性があります
* リソースモジュールはできるだけシンプルに保ってください
* &#x20;変数として渡せる値や、データソースを使用して検出できる値は、ハードコードしないでください
* データソースと `terraform_remote_state` は、特に構成内のインフラモジュール間の「接着剤」として使用してください

本書では、サンプルプロジェクトが複雑さによって小規模から大規模インフラまでグループ分けされています。この区分は厳密なものではないので、他の構造も確認してください。

### インフラモジュールと構成のオーケストレーション

小規模なインフラストラクチャとは、依存関係が少なく、リソースも少ないことを意味します。プロジェクトが成長するにつれて、Terraformの設定の実行を連鎖させ、異なるインフラストラクチャモジュールを接続し、構成内で値を受け渡す必要性が明らかになってきます。

開発者が使用するオーケストレーションソリューションには、少なくとも5つの異なるグループがあります：

1. Terraformのみ：非常に直接的なアプローチで、開発者は仕事を完了するためにTerraformだけを知って必要があります。
2. Terragrunt：インフラ全体のオーケストレーションと依存関係の処理が可能な純粋なオーケストレーションツールです。Terragruntはインフラストラクチャモジュールと構成をネイティブに扱うため、コードの重複を減らすことができます。
3. 自社開発スクリプト：多くの場合、これはオーケストレーションへの最初のステップとして、Terragruntを発見する前に行われます。
4. Ansibleやそれに類似する汎用自動化ツール：通常、TerraformがAnsible採用後に導入される場合や、Ansible UIが積極的に使用される場合に使用されます。
5. [Crossplane](https://crossplane.io) やその他のKubernetesに触発されたソリューション：Kubernetesエコシステムを活用し、reconciliation loop機能を使用してTerraform設定の望ましい状態を達成することが意味を持つ場合があります。詳細については、「 [Crossplane vs Terraform](https://www.youtube.com/watch?v=ELhVbSdcqSY) 」 の動画を参照

これを踏まえて、本書では最初の2つのプロジェクト構造、TerraformのみとTerragruntについて検討します。

次の章で [Terraform](examples/terraform/) または [Terragrunt](examples/terragrunt.md) のコード構造の例を確認してください。
