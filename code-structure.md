# 코드 구조

Terraform 코드 구조와 관련된 질문은 커뮤니티에서 가장 자주 묻는 질문입니다. 우리 모두가 어느 시점엔가 프로젝트에 가장 적합한 코드 구조가 무엇일지 고민해보기도 했죠.

## Terraform 구성(configurations)을 어떻게 구성해야 할까? <a href="#how-should-i-structure-my-terraform-configurations" id="how-should-i-structure-my-terraform-configurations"></a>

이는 많은 해결책이 존재하는 질문 중 하나이며 보편적인 조언을 드리기가 매우 어렵습니다. 따라서 우리가 다루고자 하는것이 무엇인지 이해하는 것부터 시작해 봅시다.

* 프로젝트의 복잡성은 어떻게 되나요?
  * 관련 리소스 수
  * Terraform 프로바이더 수(아래 "논리적 제공자(logical providers)"에 대한 참고 사항을 확인하세요)
* 인프라가 얼마나 자주 변경됩니까?
  * 월/주/일에 1회**부터**
  * 지속적으로**까지**(새 커밋이 있을 때마다)
* 코드 변경 게시자? 새 아티팩트가 빌드되면 CI 서버가 저장소를 업데이트하도록 허용합니까?
  * 개발자만 인프라 저장소에 푸시할 수 있습니다.
  * 누구나 PR을 열어 무엇에 대한 변경이든 제안할 수 있습니다(CI 서버에서 실행되는 자동화된 작업 포함).
* 어떤 배포 플랫폼이나 배포 서비스를 사용하시나요?
  * AWS CodeDeploy, Kubernetes 또는OpenShift에는 약간 다른 접근 방식이 필요합니다.
* 환경은 어떻게 그룹화되나요?
  * 환경, 지역, 프로젝트별

{% hint style="info" %}
_논리적 프로바이더_는 전적으로 Terraform의 논리 내에서 작동하며, 다른 서비스와 상호 작용하지 않는 경우가 많으므로 복잡성을 O(1)로 생각할 수 있습니다. 가장 일반적인 논리적 프로바이더에는 [random](https://registry.terraform.io/providers/hashicorp/random/latest/docs), [local](https://registry.terraform.io/providers/hashicorp/local/latest/docs), [terraform](https://www.terraform.io/docs/providers/terraform/index.html), [null](https://registry.terraform.io/providers/hashicorp/null/latest/docs), [time](https://registry.terraform.io/providers/hashicorp/time/latest)이 포함됩니다.
{% endhint %}

## Terraform 구성(configurations) 구조화 시작하기 <a href="#getting-started-with-the-structuring-of-terraform-configurations" id="getting-started-with-the-structuring-of-terraform-configurations"></a>

모든 코드를 main.tf에 넣는 것은 프로젝트를 막 시작하거나 예제 코드를 작성할 때는 좋은 생각입니다. 다른 모든 경우에는 다음과 같이 여러 파일에 논리적으로 분할하는 것이 더 좋습니다.

* `main.tf` - 모듈, 로컬 및 데이터 소스를 호출하여 모든 리소스 생성
* `variables.tf` - `main.tf`에서 사용되는 변수 선언을 포함합니다
* `outputs.tf` - `main.tf`에서 생성된 리소스의 출력(outputs)을 포함합니다.
* `versions.tf` - Terraform 및 프로바이더에 대한 버전 요구 사항을 포함합니다.

`terraform.tfvars`는 [구성(composition)](key-concepts.md#composition) 외에는 어디에도 사용하면 안 됩니다.

## Terraform 구성(configuration)의 구조를 어떻게 생각하면 될까? <a href="#how-to-think-about-terraform-configuration-structure" id="how-to-think-about-terraform-configuration-structure"></a>

{% hint style="info" %}
[리소스 모듈(resource module)](key-concepts.md#resource-module), [인프라 모듈(infrastructure module)](key-concepts.md#infrastructure-module) 및 [구성(composition)](key-concepts.md#composition)이다음의 예에서 사용되니 이들의 주요 개념을 이해했는지 확인하세요.
{% endhint %}

### 코드 구조화에 대한 일반적인 권장 사항 <a href="#common-recommendations-for-structuring-code" id="common-recommendations-for-structuring-code"></a>

* 적은 수의 리소스로 작업하는 것이 더 쉽고 빠릅니다.
  * `terraform plan` 및 `terraform apply`는 모두 클라우드 API 호출<mark style="background-color:red;">(예: AWS, GCP)</mark>을 보내 리소스 상태를 확인합니다.
  * 전체 인프라를 단일 구성(composition)으로 구성(configure)하는 경우 시간이 다소 걸릴 수 있습니다.
* 리소스가 적을 경우 <mark style="background-color:red;">폭발 반경(blast radius, 보안 침해의 경우)</mark>이 더 작습니다.
  * 관련되지 않은 리소스를 별도의 구성(composition)에 배치하여 서로 격리하면 문제가 발생할 경우 위험이 줄어듭니다.
* 원격 상태(remote state)를 사용해 프로젝트를 시작하세요. 이유는 다음과 같습니다.&#x20;
  * 노트북은 인프라의 단일 진실 공급원(infrastructure source of truth)을 위한 장소가 아닙니다.
  * `tfstate` 파일을 git에서 관리하는 것은 헬게이트의 시작입니다.
  * 나중에 인프라 계층이 여러 방향(의존성dependencies 또는 리소스 수)으로 증가하기 시작하면 상황을 제어하기가 더 쉬워질 겁니다.
* 일관된 구조와 [명명 규칙(naming convention)](naming.md)을 실천하세요.
  * 절차적 코드와 마찬가지로 Terraform 코드는 무엇보다 사람들이 읽을 수 있도록 작성되어야 합니다. 6개월 후에 변경 사항이 발생하더라도 구조에 일관성이 있다면 도움이 될 겁니다.
  * Terraform 상태 파일에서 리소스를 이동할 수 있지만 구조와 이름 지정이 일관되지 않은 경우 이동하기가 더 어려울 수 있습니다.
* 리소스 모듈을 최대한 단순하게 유지하세요.
* 변수로 전달할수 있거나 데이터 소스를 사용하여 검색할 수 있는 값은 하드코딩하지 마세요.
* 데이터 소스와 `terraform_remote_state`를 특히 구성(composition) 내 인프라 모듈 간의 접착제로 사용하세요.

이 책에서는 예제 프로젝트들이 소규모 인프라부터 대규모 인프라까지 복잡성에 따라 그룹화되어 있습니다. 이 분리는 엄격하지 않으므로 다른 구조도 확인하세요.

### &#x20;인프라 모듈 및 구성의 오케스트레이션(composition) <a href="#code-structure-orchestration-of-infrastructure-modules-and-compositions" id="code-structure-orchestration-of-infrastructure-modules-and-compositions"></a>

인프라가 작다는 것은 의존성도 적고 리소스도 적다는 것을 의미합니다. 프로젝트가 성장함에 따라 Terraform 구성(configurations) 실행을 연결하고, 다양한 인프라 모듈을 연결하고, 구성(composition) 내에서 값을 전달해야 할 필요성이 분명해집니다.

개발자가 사용하는 오케스트레이션 솔루션에는 최소 5가지 그룹이 있습니다.

1. 테라폼만 사용합니다. 매우 간단합니다. 개발자는 작업을 완료하려면 Terraform만 알면 됩니다.
2. Terragrunt. 전체 인프라를 조율하고 의존성을 처리하는 데 사용할 수 있는 순수 오케스트레이션 도구입니다. Terragrunt는 기본적으로 인프라 모듈 및 구성(composition)으로 작동하므로 코드의 중복을 줄입니다.
3. 인하우스(in-house) 스크립트. 오케스트레이션을 위한 출발점으로, 그리고 Terragrunt를 발견하기 전에 사용하곤합니다.
4. Ansible 또는 유사한 범용 자동화 도구. 주로 Ansible 이후에 Terraform을 채택하거나 Ansible UI를 적극적으로 사용할 때 사용됩니다.
5. [Crossplane](https://crossplane.io) 및 기타 Kubernetes에서 영감을 받은 솔루션. 때로는 Kubernetes 생태계를 활용하고 조정 루프 기능을 사용해 원하는 Terraform 구성(configuration) 상태를 달성하는 것이 합리적입니다. 자세한 내용은 [Crossplane vs Terraform](https://www.youtube.com/watch?v=ELhVbSdcqSY) 비디오를 참조하세요.

이를 염두에 두고 이 책에서는 이러한 프로젝트 구조 중 처음 두 개, Terraform만 사용하는 경우와 Terragrunt를 알아봅니다.

다음 장에서 [Terraform](examples/terraform/) 또는 [Terragrunt](examples/terragrunt.md)의 코드 구조 예를 참조하세요.
