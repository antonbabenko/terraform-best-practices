---
description: FTP (Frequent Terraform Problems)
---

# 问答 (FAQ)

## 我应该注意并考虑使用哪些工具？

* [**Terragrunt**](https://terragrunt.gruntwork.io/) - 编排工具（Orchestration tool）
* [**tflint**](https://github.com/terraform-linters/tflint) - 代码检查器（Code linter）
* [**tfenv**](https://github.com/tfutils/tfenv) - 版本管理器（Version manager）
* [**Atlantis**](https://www.runatlantis.io/) - 拉取请求自动化（Pull Request automation）
* [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) - 用于预提交框架 [pre-commit framework](https://pre-commit.com/) Terraform 的 git 钩子集合
* [**Infracost**](https://www.infracost.io) - 拉取请求中 Terraform 的云成本估算。 也适用于 Terragrunt、Atlantis 和 pre-commit-terraform。

## 模块[dependency hell](https://en.wikipedia.org/wiki/Dependency\_hell)（依赖地狱）解决方案是什么？

应指定资源和基础设施模块的版本。 提供商应该在模块之外配置，但只能在组合中配置。 提供商和 Terraform 的版本也可以被锁定。

没有主要的依赖管理工具，但有一些技巧可以减少依赖地狱的问题。 例如，[Dependabot](https://dependabot.com/) 可用于自动化依赖更新。 Dependabot 创建拉取请求以确保您的依赖关系安全和最新。 Dependabot 支持 Terraform 配置。
