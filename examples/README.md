# 代码结构示例

## Terraform 代码结构

{% hint style="info" %}
这些示例显示的是 AWS 提供商，但示例中显示的大部分原则可以应用于其他公共云提供商以及其他类型的提供商（DNS、DB、监控等）。
{% endhint %}

| Type 类型                                                        | Description 描述                                           | Readiness 准备 |
| -------------------------------------------------------------- | -------------------------------------------------------- | ------------ |
| [small](terraform/small-size-infrastructure.md)                | 很少资源，没有外部依赖。 单个 AWS 账户。 单一区域。 单一环境。                      | Yes          |
| [medium](terraform/medium-size-infrastructure.md)              | 多个 AWS 账户和环境，使用 Terraform 的现成基础设施模块。                     | Yes          |
| [large](terraform/large-size-infrastructure-with-terraform.md) | 许多 AWS 账户，许多地区，迫切需要减少复制粘贴、自定义基础设施模块、大量使用组合。 使用Terraform。 | WIP 生产中      |
| very-large                                                     | 多个提供商（AWS、GCP、Azure）。 多云部署。 使用Terraform。                 | No           |

## Terragrunt 代码结构

| Type 类型    | Description 描述                                             | Readiness 准备 |
| ---------- | ---------------------------------------------------------- | ------------ |
| medium     | 多个 AWS 账户和环境，现成的基础设施模块，使用 Terragrunt 的组合模式。                | No           |
| large      | 许多 AWS 账户，许多地区，迫切需要减少复制粘贴、自定义基础设施模块、大量使用组合。 使用 Terragrunt。 | No           |
| very-large | 多个提供商（AWS、GCP、Azure）。 多云部署。 使用 Terragrunt。                 | No           |
