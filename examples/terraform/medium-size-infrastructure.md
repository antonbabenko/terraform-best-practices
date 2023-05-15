# 使用 Terraform 的中型基础设施

来源: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform)

此示例包含的代码作为为中型基础设施构建 Terraform 配置的示例，该基础设施使用：

* 2个AWS账户
* 2 个独立的环境 (`prod` 和 `stage` 什么都不共享)，每个环境都位于一个单独的 AWS 账户中
* 每个环境都使用来自 [Terraform Registry](https://registry.terraform.io/) 的不同版本的现成基础设施模块 (`alb`)
* 每个环境都使用相同版本的内部模块`modules/network`，因为它来自本地目录

{% hint style="success" %}
* 非常适合基础设施在逻辑上分离的项目（单独的 AWS 账户）
* 适合不需要修改 AWS 账户之间共享的资源（一个环境 = 一个 AWS 账户 = 一个状态文件）
* 适合不需要编排环境之间的变化
* 适合基础设施资源因环境而异且无法一概而论时（例如，在一个环境或某些地区缺少某些资源）
{% endhint %}

{% hint style="warning" %}
随着项目的增长，让这些环境彼此保持最新状态将变得更加困难。考虑使用基础设施模块（现成的或内部的）来完成可重复的任务。
{% endhint %}

##
