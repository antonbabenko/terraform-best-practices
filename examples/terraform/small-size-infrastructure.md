# 使用 Terraform 的小型基础设施

来源: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

此示例包含的代码作为为小型基础设施构建 Terraform 配置的示例，其中不使用外部依赖项。

{% hint style="success" %}
* 非常适合入门和按需重构
* 非常适合小型资源模块
* 适用于小型和线性基础设施模块（例如，[terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis)）
* 适用于少量资源（少于 20-30）
{% endhint %}

{% hint style="warning" %}
如果资源数量不断增加，所有资源的单一状态文件会使使用 Terraform 的过程变慢（考虑使用参数 `-target` 来限制资源数量）
{% endhint %}
