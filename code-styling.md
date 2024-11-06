# コーディングスタイル

{% hint style="info" %}
* 例やTerraformモジュールには、機能と使用方法を説明するドキュメントを含める必要があります。
* README.mdファイル内のすべてのリンクは絶対Pathにし、Terraform Registryのウェブサイトで正しく表示されるようにします。
* ドキュメントには、[mermaid](https://github.com/mermaid-js/mermaid)で作成した図や[cloudcraft.co](https://cloudcraft.co/)で作成した設計図を含めることができます。
* Terraformのプリコミットフック([Terraform pre-commit hooks](https://github.com/antonbabenko/pre-commit-terraform))を使用して、コードが正しく、適切にフォーマットされ、自動的にドキュメント化されるようにし、Gitにプッシュされる前に確認できるようにしてください。
{% endhint %}

## ドキュメンテーション

### ドキュメントの自動生成

[pre-commit](https://pre-commit.com/)は、マルチランゲージのプリコミットフックを管理および維持するためのフレームワークです。Pythonで書かれており、コードがGitリポジトリにコミットされる前に、開発者のマシン上で自動的に何かしらの処理を行うための強力なツールです。通常は、リンターを実行したり、コードをフォーマットしたりするために使用されます（[サポートされているフック](https://pre-commit.com/hooks.html)を参照）。

Terraformの構成では、`pre-commit`を使用してコードをフォーマットし、検証し、ドキュメントを更新することができます。

[pre-commit-terraformリポジトリ](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md)をチェックして、使い方を把握し、すでに使用されている既存のリポジトリ（例：[terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc)）を確認してください。

### terraform-docs

[terraform-docs](https://github.com/segmentio/terraform-docs)は、さまざまな出力形式でTerraformモジュールからドキュメントを生成するツールです。手動で実行することもできます（プリコミットフックなしで）、または [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform) を使用してドキュメントを自動的に更新することもできます。

@todo: モジュールのバージョン、リリース、GHアクションを文書化する

## 参照

1. [pre-commit framework homepage](https://pre-commit.com/)
2. [Collection of git hooks for Terraform to be used with pre-commit framework](https://github.com/antonbabenko/pre-commit-terraform)
3. Blog post by [Dean Wilson](https://github.com/deanwilson): [pre-commit hooks and terraform - a safety net for your repositories](https://www.unixdaemon.net/tools/terraform-precommit-hooks/)
