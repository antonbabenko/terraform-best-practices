# 代码风格

{% hint style="info" %}
* 示例和 Terraform 模块应包含说明功能及其使用方法的文档。&#x20;
* README.md 文件中的所有链接都应该是绝对链接，以使 Terraform Registry 网站正确显示它们。
* 文档可能包括使用[mermaid](https://github.com/mermaid-js/mermaid)创建的图表和使用[cloudcraft.co](https://cloudcraft.co)创建的蓝图。&#x20;
* 使用 [Terraform pre-commit hooks](https://github.com/antonbabenko/pre-commit-terraform) 确保代码有效、格式正确并自动记录，然后再推送到 git 并由人工审查。
{% endhint %}

## Documentation（文档）

### 自动生成的文档

[pre-commit](https://pre-commit.com/) 是一个用于管理和维护多语言预提交挂钩的框架。它是用 Python 编写的，是一个强大的工具，可以在代码提交到 git 存储库之前在开发人员的机器上自动执行某些操作。通常，它用于运行 linters 和格式化代码（参见[supported hooks](https://pre-commit.com/hooks.html)）。

通过 Terraform 配置，`pre-commit`可用于格式化和验证代码，以及更新文档。

查看 [pre-commit-terraform repository](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md) 以熟悉它，以及已经使用它的现有存储库（例如， [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc)）。

### terraform-docs

[terraform-docs](https://github.com/segmentio/terraform-docs) 是一种工具，可以从 Terraform 模块以各种输出格式完成文档的生成。你可以手动运行它（没有预提交挂钩），或使用 [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform) 来自动更新文档。

@todo：记录模块版本、发布、GH actions

## 参考资源

1. 预提交框架主页：[pre-commit framework homepage](https://pre-commit.com/)
2. 用于预提交框架的Terraform 的 git 钩子集合：[Collection of git hooks for Terraform to be used with pre-commit framework](https://github.com/antonbabenko/pre-commit-terraform)
3. [Dean Wilson](https://github.com/deanwilson)的博客文章：[pre-commit hooks and terraform - a safety net for your repositories](https://www.unixdaemon.net/tools/terraform-precommit-hooks/)
