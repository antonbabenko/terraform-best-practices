# Conceitos chave

A documentação oficial do Terraform descreve[ todos os aspectos da configuração em detalhes](https://www.terraform.io/docs/configuration/index.html). Leia-o com atenção para entender o restante desta seção.

## Recursos

Um recurso é `aws_vpc`, `aws_db_instance`, etc. Um recurso pertence a um provedor, aceita argumentos, produz atributos e tem ciclos de vida. Um recurso pode ser criado, recuperado, atualizado e excluído.

## Módulo de Recursos

O módulo de recursos é uma coleção de recursos conectados, que juntos, executam a ação comum (por exemplo, o [módulo AWS VPC Terraform](https://github.com/terraform-aws-modules/terraform-aws-vpc/) cria VPC, sub-redes, gateway NAT, etc.). Depende da configuração do provedor, que pode ser definida nele, ou em estruturas de nível superior (por exemplo, no módulo de infraestrutura).

## Módulo de infraestrutura

Um módulo de infraestrutura é uma coleção de módulos de recursos, que podem ser logicamente não conectados, mas na situação/projeto/configuração atual servem ao mesmo propósito. Ele define a configuração para provedores, passada para os módulos de recursos downstream e para os recursos. Normalmente é limitado a trabalhar em uma entidade por separar lógico (por exemplo, região da AWS, projeto do Google).

Por exemplo, o módulo [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis/) utiliza módulo de recursos tais como o [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc/) e [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group/) para gerenciar infraestrutura necessária para executar o  [Atlantis](https://www.runatlantis.io) no [AWS Fargate](https://aws.amazon.com/fargate/).

Outro exemplo é o módulo [terraform-aws-cloudquery](https://github.com/cloudquery/terraform-aws-cloudquery), onde vários módulos do [terraform-aws-modules](https://github.com/terraform-aws-modules/) estão sendo utilizados juntos para gerenciar a infraestrutura, assim como utilizar recursos do Docker para criar, enviar e implantar imagens Docker. Tudo em um conjunto.

## Composição <a href="#composicao" id="composicao"></a>

Composição é uma coleção de módulos de infraestrutura, que podem abranger várias áreas separadas logicamente (por exemplo, regiões da AWS, várias contas da AWS). A composição é usada para descrever a infraestrutura completa necessária para toda a organização ou projeto.

Uma composição consiste em módulos de infraestrutura, que consistem em módulos de recursos, que implementam recursos individuais.

![Composição de infraestrutura simples](.gitbook/assets/composition-1.png)

## Fonte de Dados

A fonte de dados executa uma operação somente leitura e é dependente da configuração do provedor, é também usada em um módulo de recursos e em um módulo de infraestrutura.

A fonte de dados  `terraform_remote_state` atua como uma “cola” para módulos e composições de nível superior.

Já uma fonte de dados [externa](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data\_source), permite que um programa externo atue como fonte de dados, expondo informações arbitrários para uso em outro lugar na configuração do Terraform. Aqui está um exemplo do módulo [terraform-aws-lambda](https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/258e82b50adc451f51544a2b57fd1f6f8f4a61e4/package.tf#L5-L7), onde o nome do arquivo é calculado chamando um script Python externo.

A fonte de dados [http](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) realiza uma solicitação `HTTP GET` para o URL fornecido e exporta informações sobre a resposta, o que geralmente é útil para obter informações de terminais onde um provedor Terraform nativo não existe.

## Estado Remoto

Módulos de infraestrutura e composições devem manter seu [estado Terraform](https://www.terraform.io/docs/language/state/index.html) em um local remoto, onde possam ser recuperados por outros de maneira controlável (por exemplo, especificar ACL, versionamento, logging).

## Provedor, Aprovisionador, etc

Provedores, provisionadores e alguns outros termos estão muito bem descritos na documentação oficial e não vale a pena repetir aqui. Na minha opinião, eles têm pouco a ver com escrever bons módulos Terraform.

## Por que é tão difícil?

Enquanto os recursos individuais são como átomos na infraestrutura, os módulos de recursos são moléculas. Um módulo é a menor unidade com versão e compartilhável. Possui uma lista exata de argumentos, implementa lógica básica para que tal unidade realize a função necessária. Por exemplo, o módulo [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group) cria recursos `aws_security_group` e `aws_security_group_rule` com base no input. Este módulo de recursos por si só pode ser usado em conjunto com outros módulos para criar o módulo de infraestrutura.

O acesso aos dados entre moléculas (módulos de recursos e módulos de infraestrutura) é realizado utilizando saídas e fontes de dados dos módulos.

O acesso entre composições geralmente é realizado usando fontes de dados de estado remoto. [Existem várias maneiras de compartilhar dados entre as configurações](https://www.terraform.io/docs/language/state/remote-state-data.html#alternative-ways-to-share-data-between-configurations).

Ao colocar os conceitos descritos acima em pseudo-relações, pode-se ficar assim:

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
