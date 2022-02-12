# Estrutura do código

As perguntas relacionadas à estrutura de código do Terraform sào de longe as mais frequentes na comunidade. Todos pensaram na melhor estrutura de código para o projeto em algum momento também.

## Como devo estruturar minhas configurações do Terraform?

Esta é uma das questões em que existem muitas soluções e é muito difícil dar conselhos dinâmicos, então vamos começar entendendo com o que estamos lidando.

* Qual é a complexidade do seu projeto?
  * Número de recursos relacionados.
  * Número de provedores Terraform (veja a nota abaixo sobre “provedores lógicos”).
* Com que frequência sua infraestrutura muda?
  * **A partir** de uma vez por mês/semana/dia.
  * **Continuamente** (toda vez que houver um novo commit).
* Iniciadores de mudança de código? _Você permite que o servidor CI atualize o repositório quando um novo artefato é criado?_
  * Somente desenvolvedores podem realizar o push para o repositório de infraestrutura.
  * Todos podem propor uma mudança em qualquer coisa abrindo um PR (incluindo tarefas automatizadas em execução no servidor CI).
* Qual plataforma de implementação ou serviço de implementação você utiliza?
  * AWS CodeDeploy, Kubernetes, ou OpenShift exigem uma abordagem um pouco diferente.
* Como os ambientes são agrupados?
  * Por ambiente, região, projeto...

{% hint style="info" %}
_Os provedores lógicos trabalham inteiramente dentro da lógica do Terraform e, muitas vezes, não interagem com nenhum outro serviço, entao podemos pensar em sua complexidade como_ O(1). Os provedores lógicos mais comuns incluem [random](https://registry.terraform.io/providers/hashicorp/random/latest/docs), [local](https://registry.terraform.io/providers/hashicorp/local/latest/docs), [terraform](https://www.terraform.io/docs/providers/terraform/index.html), [null](https://registry.terraform.io/providers/hashicorp/null/latest/docs), [time](https://registry.terraform.io/providers/hashicorp/time/latest).
{% endhint %}

## Introdução à estruturação de configurações do Terraform

Colocar todo o código em um único `main.tf` é uma boa ideia quando você está começando ou escrevendo um código de exemplo. Em todos os outros casos, será melhor ter vários arquivos divididos logicamente assim:

* `main.tf` - chame módulos, locais e fontes de dados para criar todos os recursos.
* `variables.tf` - contém declarações de variáveis utilizadas em `main.tf.`
* `outputs.tf` - contém saídas dos recursos criados em `main.tf.`
* `versions.tf` - contém requisitos de versão para Terraform e provedores.

`terraform.tfvars` não deve ser utilizado em nenhum lugar exceto na [composição](key-concepts.md#composicao).

## Como pensar sobre a estrutura de configurações do Terraform?

{% hint style="info" %}
Por favor, certifique-se de entender os principais conceitos - [módulo de recursos](key-concepts.md#modulo-de-recursos),&#x20;

[módulo de infraestrutura](key-concepts.md#modulo-de-infraestrutura) e [composição](key-concepts.md#composicao), conforme são utilizados nos exemplos a seguir.
{% endhint %}

### Recomendações comuns para estruturar código

* É mais fácil e rápido trabalhar com um número menor de recursos
  * `terraform plan` e `terraform apply` fazem chamada API na nuvem para verificar o status dos recursos.
  * Se você tiver toda a sua infraestrutura em uma única composição, isso pode levar algum tempo.
* O raio afetado é menor com menos recursos
  * Isolar recursos não relacionados uns aos outros, colocando-os em composições separadas, reduz o risco se algo der errado.
* Inicie seu projeto utilizando o estado remoto porque:
  * Seu notebook não é lugar para sua fonte de verdade de infraestrutura.
  * Gerenciar um arquivo `tfstate` no git é um pesadelo.
  * Mais tarde, quando as camadas de infraestrutura começarem a crescer em várias direções (número de dependências ou recursos), será mais fácil manter as coisas sob controle.
* Pratique uma estrutura consistente e uma convenção de [nomenclatura](naming.md#convencoes-gerais):
  * Assim como o código procedural, o código do Terraform deve ser escrito para que as pessoas leiam primeiro, a consistência ajudará quando as mudanças ocorrerem daqui a seis meses.
  * É possível mover recursos no arquivo de estado do Terraform, mas pode ser mais difícil de efetuar se você tiver estrutura e nomenclatura inconsistentes.
* Mantenha os módulos de recursos o mais simples possível.
* Não codifique valores que possam ser passados como variáveis ou descobertos usando fontes de dados.
* Use fontes de dados e o `terraform_remote_state` especificamente como uma cola entre os módulos de infraestrutura na composição.

Neste livro, os projetos de exemplo são agrupados por _complexidade_ - de infraestruturas pequenas a muito grandes. Essa separação não é rígida, portanto, verifique também outras estruturas.

### Orquestração de módulos e composições de infraestrutura

Ter uma infraestrutura pequena significa haver um pequeno número de dependências e poucos recursos. À medida que o projeto cresce, torna-se óbvia a necessidade de encadear a execução das configurações do Terraform, conectar diferentes módulos de infraestrutura e passar valores em uma composição.

Existem pelo menos 5 grupos distintos de soluções de orquestração que os desenvolvedores usam:

1. Somente o Terraform. Muito simples, os desenvolvedores precisam conhecer apenas o Terraform para realizar o trabalho.
2. Terragrunt. Ferramenta de orquestração pura que pode ser usada para orquestrar toda a infraestrutura, bem como lidar com dependências. O Terragrunt opera com módulos e composições de infraestrutura nativamente, reduzindo assim a duplicação de código.
3. Roteiros internos (in-house scripts). Muitas vezes isso acontece como um ponto de partida para a orquestração e antes de descobrir o Terragrunt.
4. Ansible ou ferramenta de automação de uso geral similar. Geralmente utilizado quando o Terraform é adotado após o Ansible, ou quando a “interface” do usuário do Ansible é usada ativamente.
5. [Crossplane](https://crossplane.io) e outras soluções inspiradas no Kubernetes. Às vezes, faz sentido utilizar o ecossistema Kubernetes e empregar um recurso de “loop” de reconciliação para atingir o estado desejado de suas configurações do Terraform. Observe o vídeo [Crossplane vs Terraform](https://www.youtube.com/watch?v=ELhVbSdcqSY) para mais informações.

Com isso em mente, este livro analisa às duas primeiras dessas estruturas de projeto, apenas Terraform e Terragrunt.

Veja exemplos de estruturas de código para o [Terraform](examples/#estruturas-de-codigo-do-terraform) e/ou [Terragrunt](examples/#estruturas-de-codigo-do-terragrunt) no próximo capítulo.
