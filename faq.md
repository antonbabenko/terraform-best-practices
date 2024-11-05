---
description: FTP (Frequent Terraform Problems)
---

# FAQ

## 使用を検討すべきツールは何ですか？

* [**Terragrunt**](https://terragrunt.gruntwork.io/) - オーケストレーションツール
* [**tflint**](https://github.com/terraform-linters/tflint) - コードリンター
* [**tfenv**](https://github.com/tfutils/tfenv) - バージョンマネージャー
* [**asdf-hashicorp**](https://github.com/asdf-community/asdf-hashicorp) - [asdf](https://github.com/asdf-vm/asdf)バージョンマネージャー用のHashiCorpプラグイン
* [**Atlantis**](https://www.runatlantis.io/) - プルリクエストの自動化
* [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) - [pre-commitフレームワーク](https://pre-commit.com/)で使用するTerraform用のGitフックコレクション
* [**Infracost**](https://www.infracost.io) - プルリクエストでのTerraformのクラウドコスト見積もり。Terragrunt、Atlantis、pre-commit-terraformとも連携可能。

## モジュールの[ディペンデンシーヘル](https://en.wikipedia.org/wiki/Dependency\_hell)に対する解決策は何ですか？

リソースとインフラモジュールのバージョンは指定されるべきです。プロバイダーはモジュールの外部で、コンポジション内でのみ設定されるべきです。プロバイダーとTerraformのバージョンもロックすることができます。

マスターとなる依存関係管理ツールは存在しませんが、依存関係の指定をより問題の少ないものにするためのヒントがいくつかあります。例えば、[Dependabot](https://dependabot.com/)を使用して依存関係の更新を自動化することができます。Dependabotは、依存関係を安全かつ最新の状態に保つためのプルリクエストを作成します。DependabotはTerraformの設定をサポートしています。
