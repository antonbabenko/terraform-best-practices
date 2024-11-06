# 概念

公式のTerraformドキュメントには、[設定のすべての側面](https://www.terraform.io/docs/configuration/index.html)が詳細に説明されています。次のセクションを理解するために、注意深くお読みください。\
\
このセクションでは、本書で使用される重要な概念について説明します。

## リソース

リソースとは、`aws_vpc`や`aws_db_instance`などを指します。リソースはプロバイダーに属し、引数を受け取り、属性を出力し、ライフサイクルを持っています。リソースは作成、取得、更新、削除が可能です。

## リソースモジュール

リソースモジュールは、相互に接続されたリソースの集まりで、共通のアクションを実行します（例：[AWS VPC Terraformモジュール](https://github.com/terraform-aws-modules/terraform-aws-vpc/)は、VPC、サブネット、NATゲートウェイなどを作成します）。プロバイダー設定に依存し、それはモジュール内またはより上位の構造（例：インフラモジュール）で定義できます。

## インフラモジュール

インフラモジュールは、リソースモジュールの集まりで、論理的には接続されていない場合もありますが、現在の状況やプロジェクト、設定において同じ目的を果たします。プロバイダーの設定を定義し、それが下位のリソースモジュールやリソースに渡されます。通常、論理的な区切りごと（例：AWSリージョン、Googleプロジェクト）に1つのエンティティで機能するよう制限されています。\


例えば、 [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis/) モジュールは、 [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc/) や [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group/) のようなリソースモジュールを使用して、 [AWS Fargate](https://aws.amazon.com/fargate/)上で [Atlantis](https://www.runatlantis.io) を実行するために必要なインフラを管理します。

もう一つの例は、 [terraform-aws-cloudquery](https://github.com/cloudquery/terraform-aws-cloudquery) モジュールです。ここでは、複数の [terraform-aws-modules](https://github.com/terraform-aws-modules/) によるモジュールが一緒に使用され、インフラを管理するとともに、Dockerリソースを使用してDockerイメージをビルド、プッシュ、デプロイします。すべてが一つのセットで実行されます。

## コンポジション

コンポジションとは、複数のインフラモジュールの集まりで、複数の論理的に分離された領域（例：AWSリージョン、複数のAWSアカウント）にまたがることができます。コンポジションは、組織全体やプロジェクト全体に必要なインフラを記述するために使用されます。

コンポジションはインフラモジュールで構成され、そのモジュールはリソースモジュールで構成され、リソースモジュールは個々のリソースを実装しています。

![Simple infrastructure composition](.gitbook/assets/composition-1.png)

## データソース

データソースは読み取り専用の操作を実行し、プロバイダー設定に依存しています。リソースモジュールやインフラストラクチャモジュールで使用されます。

データソース`terraform_remote_state`は、上位レベルのモジュールやコンポジションを結びつける役割を果たします。

[外部データソース](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external)を使用すると、外部プログラムがデータソースとして機能し、Terraformの設定内で他の場所で使用する任意のデータを提供できます。以下は、[terraform-aws-lambda](https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/258e82b50adc451f51544a2b57fd1f6f8f4a61e4/package.tf#L5-L7)モジュールの例で、外部のPythonスクリプトを呼び出してファイル名を計算しています。

[http](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http)データソースは、指定されたURLに対してHTTP GETリクエストを行い、レスポンスに関する情報をエクスポートします。これは、ネイティブなTerraformプロバイダーが存在しないエンドポイントから情報を取得する際に便利です。

## リモートステート

インフラモジュールやコンポジションは、[Terraformの状態(Terraform state)](https://www.terraform.io/docs/language/state/index.html)をリモートの場所に保存し、他のユーザーが制御可能な方法で取得できるようにするべきです（例：ACLの指定、バージョニング、ロギングの設定）。

## プロバイダー、プロビジョナーなど

プロバイダーやプロビジョナー、その他いくつかの用語については公式ドキュメントで非常に詳しく説明されており、ここで繰り返す必要はありません。私の意見では、これらは良いTerraformモジュールを書くことにあまり関係がないと考えています。

## なぜ難しいのか？

個々のリソースがインフラの「原子」のようなものである一方、リソースモジュールは「分子」（原子から構成される）に相当します。モジュールは、バージョン管理され共有可能な最小の単位です。特定の引数リストがあり、この単位に必要な機能を実行するための基本的なロジックが実装されています。例えば、[terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group)モジュールは、入力に基づいて`aws_security_group`や`aws_security_group_rule`リソースを作成します。このリソースモジュール自体は、他のモジュールと組み合わせてインフラストラクチャモジュールを作成するために使用できます。

「分子」（リソースモジュールやインフラモジュール）間でのデータアクセスは、モジュールのアウトプットやデータソースを使って行います。

コンポジション間のアクセスは、リモートステートデータソースを使用することが多いです。[設定間でデータを共有する方法は複数](https://www.terraform.io/docs/language/state/remote-state-data.html#alternative-ways-to-share-data-between-configurations)あります。

上記の概念を擬似的な関係に当てはめると、次のようになります。

```
composition-1 {
  infrastructure-module-1 {
    data-source-1 => d1

    resource-module-1 {
      data-source-2 => d2
      resource-1 (d1, d2)
      resource-2 (d2)
    }

    resource-module-2 {
      data-source-3 => d3
      resource-3 (d1, d3)
      resource-4 (d3)
    }
  }
}
```
