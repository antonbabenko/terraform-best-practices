---
description: コード構造サンプル
---

# コード構造サンプル

## Terraformのコード構造

{% hint style="info" %}
これらの例ではAWSプロバイダーを使用していますが、例で示された原則の大部分は、他のパブリッククラウドプロバイダーや、DNS、データベース、モニタリングなどの他の種類のプロバイダーにも適用可能です。
{% endhint %}

| タイプ                                                                                                         | 説明                                                                        | 準備状況 |
| ----------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- | ---- |
| [小規模](https://www.terraform-best-practices.com/examples/terraform/small-size-infrastructure)                | リソースは少数、外部依存なし。単一のAWSアカウント。単一のリージョン。単一の環境。                                | 完了   |
| [中規模](https://www.terraform-best-practices.com/examples/terraform/medium-size-infrastructure)               | 複数のAWSアカウントと環境、Terraformを使用した既製のインフラモジュール。                                | 完了   |
| [大規模](https://www.terraform-best-practices.com/examples/terraform/large-size-infrastructure-with-terraform) | 多数のAWSアカウントと複数のリージョン、コピーペーストの削減が急務、カスタムインフラモジュール、コンポジションの多用。Terraformを使用。 | 進行中  |
| 超大規模                                                                                                        | 複数のプロバイダー（AWS、GCP、Azure）。マルチクラウド展開。Terraformを使用。                          | 未着手  |

## Terragruntコード構造

| タイプ  | 説明                                                                         | 準備状況 |
| ---- | -------------------------------------------------------------------------- | ---- |
| 中規模  | 複数のAWSアカウントと環境、既製のインフラモジュール、Terragruntを用いたコンポジションパターン。                     | 未着手  |
| 大規模  | 多数のAWSアカウントと複数のリージョン、コピーペーストの削減が急務、カスタムインフラモジュール、コンポジションの多用。Terragruntを使用。 | 未着手  |
| 超大規模 | 複数のプロバイダー（AWS、GCP、Azure）。マルチクラウド展開。Terragruntを使用。                          | 未着手  |
