# 核心概念

Terraform 官方文档详细阐述了 [配置的方方面面](https://www.terraform.io/docs/configuration/index.html)。请仔细阅读以便理解本节的其余部分。

本节内容将介绍本书中所使用的核心概念。

## 资源 (Resource)

类似`aws_vpc`, `aws_db_instance` 这样的都统称为资源。单个的资源一定属于某个提供商(Provider)，它接受参数，输出属性，并且有一个生命周期。资源可以被创建、检索、更新和删除。

## 资源模块 (Resource module)

资源模块是一组连接的资源，它们共同执行通用操作（例如，[AWS VPC Terraform module](https://github.com/terraform-aws-modules/terraform-aws-vpc/) 创建VPC、子网、NAT网关等）。它依赖于提供商配置，该配置可以在其中定义，或在更高级别的结构（如在基础设施模块）中定义。

## 基础设施模块 (Infrastructure module)

基础设施模块是一组资源模块的集合，这些资源模块在逻辑上可能没有连接，但在当前的情况/项目/设置中具有相同的目的。它定义了提供商的配置，这些配置传递给下游资源模块和资源。通常，它的范围限定在每个逻辑分隔符（例如，AWS区域、Google项目）的一个实体中。

例如，[terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis/) 模块使用像 [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc/) 和 [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group/) 这样的资源模块来管理在 [AWS Fargate](https://aws.amazon.com/fargate/) 上运行 [Atlantis](https://www.runatlantis.io) 所需的基础设施。

另一个例子是 [terraform-aws-cloudquery](https://github.com/cloudquery/terraform-aws-cloudquery) 模块，其中使用 [terraform-aws-modules](https://github.com/terraform-aws-modules/) 的多个模块一起管理基础设施，并使用Docker资源来构建、推送和部署Docker镜像。所有这些都在一个集合中。

## 组合 (Composition)

组合是由跨越多个逻辑分隔区域（例如，AWS区域、多个AWS账户）的基础设施模块组成的集合。组合用于描述整个组织或项目所需的完整基础设施。

组合由基础设施模块组成，这些基础设施模块又由资源模块组成，这些资源模块实现各个资源。

![简单的基础设施组合](.gitbook/assets/composition-1.png)

## 数据源 (Data source)

数据源执行只读操作并依赖于提供商的配置，它用于资源模块和基础设施模块。&#x20;

数据源`terraform_remote_state`作为高级模块和组合的粘合剂。&#x20;

[外部数据源](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external)允许外部程序充当数据源，并公开任意数据以供 Terraform 配置中的其他地方使用。这里有一个来自[terraform-aws-lambda](https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/258e82b50adc451f51544a2b57fd1f6f8f4a61e4/package.tf#L5-L7) 模块的示例，其中文件名通过调用外部Python脚本计算。&#x20;

[http](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) 数据源向给定的URL发出HTTP GET请求，并导出有关响应的信息，这对于从不存在本机 Terraform 提供商的端点获取信息通常很有用。

## 远程状态 (Remote state)

基础设施模块和组合应该将它们的 [Terraform state](https://www.terraform.io/docs/language/state/index.html) 保存在远程位置，以便可以以可控的方式被他人检索（例如指定ACL、版本控制和日志记录）。

## 提供商 (Provider)，配置器 (provisioner)和其他

提供商、配置器等术语在官方文档中已经有很好的描述，因此在这里重复没有意义。我认为，它们与编写良好的Terraform模块关系不大。

## 为何如此_复杂_?

虽然单个资源就像基础设施中的原子一样，但资源模块是分子。模块是最小的可版本化和可共享的单位。它具有精确的参数列表，为这样一个单元实现基本逻辑来完成所需的功能。例如，[terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group) 模块可以根据输入创建`aws_security_group`和`aws_security_group_rule`资源。这个资源模块本身可以与其他模块一起使用来创建基础设施模块。

使用模块的输出和数据源执行跨分子（资源模块和基础设施模块）的数据访问。&#x20;

组合之间的访问通常使用远程状态数据源来执行。 有多种方法可以在[配置之间共享数据](https://developer.hashicorp.com/terraform/language/state/remote-state-data#alternative-ways-to-share-data-between-configurations)。&#x20;

当把上面描述的概念放在伪关系中时，它可能看起来像这样：

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
