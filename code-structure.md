# 代码结构

有关Terraform代码结构的问题是社区中迄今为止最常见的问题。 每个人都在某个时候考虑过项目的最佳代码结构。

## 我应该如何构建我的 Terraform 配置？

这是一个有很多解决方案的问题之一，很难给出通用的建议，所以让我们从理解我们正在处理什么开始。

* 你的项目有多复杂？
  * 相关resources（资源）数量
  * Terraform 提供商的数量（参见下面关于“逻辑提供者”的注释）
* 你的基础架构多久更改一次？
  * **从**每月/每周/每天一次
  * **到**连续（每次有新提交时）
* 代码更改发起者？ 当一个新的_artifact（_构件）生成时，是否让 CI 服务器更新存储库？
  * 只有开发人员可以推送到基础架构存储库
  * 每个人都可以通过打开 PR（包括在 CI 服务器上运行的自动化任务）来提出对任何事物的更改
* 你使用哪种部署平台或部署服务？
  * AWS CodeDeploy、Kubernetes 或 OpenShift 需要稍微不同的方法
* 环境如何分组？
  * 按环境、地区、项目

{% hint style="info" %}
_Logical providers（逻辑提供商）_完全在 Terraform 的逻辑中工作，并且通常不与任何其他服务交互，因此我们可以将它们的复杂性视为 O(1)。 最常见的逻辑提供商包括 [random](https://registry.terraform.io/providers/hashicorp/random/latest/docs), [local](https://registry.terraform.io/providers/hashicorp/local/latest/docs), [terraform](https://www.terraform.io/docs/providers/terraform/index.html), [null](https://registry.terraform.io/providers/hashicorp/null/latest/docs), [time](https://registry.terraform.io/providers/hashicorp/time/latest).
{% endhint %}

## 开始了解 Terraform 配置的结构

当开始或编写示例代码时，将所有代码放在 `main.tf`中是一个好主意。 在所有其他情况下，最好将多个文件按逻辑拆分，如下所示：

* `main.tf` - 调用modules（模块）、locals（本地）和data sources（数据源）来创建所有资源
* `variables.tf` - 包含在`main.tf` 中使用的变量声明
* `outputs.tf` - 包含在 `main.tf`中创建的资源的输出
* `versions.tf` - 包含 Terraform 和提供商的版本要求

`terraform.tfvars` 不应在除[composition](key-concepts.md#composition)（组合）之外的任何地方使用。

## 如何考虑 Terraform 配置结构？

{% hint style="info" %}
&#x20;请确保您了解核心概念 - [resource module](key-concepts.md#resource-module)（资源模块），[infrastructure module](key-concepts.md#infrastructure-module)（基础设施模块），和 [composition](key-concepts.md#composition)（组合）， 因为它们在以下示例中使用。
{% endhint %}

### 结构化代码的常见建议

* 使用更少的资源可以更轻松、更快速地进行工作
  * `terraform plan` 和 `terraform apply` 都调用 cloud API 来验证资源状态
  * 如果你的整个基础设施都在一个组合中，这可能需要一些时间
* 资源越少，爆炸半径（A blast radius）就越小
  * 通过将不相关的资源放置在单独的组合中以进行隔离，可以降低如果出现问题时的风险
* 使用远程状态启动您的项目，因为：
  * 你的笔记本电脑不是基础设施代码真实来源的合适位置
  * 在 git 中管理`tfstate`文件是一场噩梦
  * 当基础设施层开始朝多个方向（依赖项或资源数量）增长时，将更容易控制事物
* 实践一致的结构和 [naming](naming.md) convention（命名约定）：
  * 与procedural code（过程式代码）一样，Terraform 代码应该首先编写供人们阅读。当六个月后发生变化时，一致性将有所帮助
  * 可以在 Terraform 状态文件中移动资源，但如果结构和命名不一致，则可能更难做到
* 保持资源模块尽可能简单
* 不要将可以作为变量传递或使用数据源(data sources)发现的值硬编码
* 专门使用data sources(数据源)和`terraform_remote_state` 作为composition（组合）中基础设施模块之间的粘合剂&#x20;

在本书中，示例项目按_复杂性_分组 —— 从小型到超大型基础设施。这种分离并不严格，因此还要检查其他结构。

### 基础架构模块和组合的编排

拥有小型基础设施意味着存在少量依赖项和资源。 随着项目的增长，链接 Terraform 配置的执行、连接不同的基础设施模块以及在组合中传递值的需求变得显而易见。

开发人员使用的编排解决方案至少有5个不同的群体:

1. 仅限Terraform。 非常简单，开发人员只需了解 Terraform 即可完成工作。
2. Terragrunt。 纯编排工具，可用于编排整个基础架构以及处理依赖项。 Terragrunt 原生地操作基础设施模块和组合，因此它减少了代码重复。
3. In-house scripts（内部脚本）。 通常，这发生在编排的起点和发现 Terragrunt 之前。
4. Ansible 或类似的通用自动化工具。通常在 Ansible 之后采用 Terraform 时使用，或者在积极使用 Ansible UI 时使用。&#x20;
5. [Crossplane](https://crossplane.io/) 和其他受 Kubernetes 启发的解决方案。有时，利用 Kubernetes 生态系统并采用reconciliation loop（协调循环）功能来实现 Terraform 配置的所需状态是有意义的。 观看视频[Crossplane vs Terraform](https://www.youtube.com/watch?v=ELhVbSdcqSY)了解更多信息。

考虑到这一点，本书回顾了这些项目结构中的前两个，即仅使用Terraform和Terragrunt。

请参阅下一章中 [Terraform](examples/terraform/) 或 [Terragrunt](examples/terragrunt.md) 的代码结构示例。
