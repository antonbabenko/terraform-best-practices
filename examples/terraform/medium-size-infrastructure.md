# Terraform을 사용한 중간 규모 인프라

출처: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform)

이 예시에는 다음을 사용하는 중간 규모 인프라에 대한 Terraform 구성(configurations)을 구조화하는 예제 코드가 포함되어 있습니다.

* AWS 계정 2개
* 2개의 별도 환경(아무것도 공유하지 않는 `prod` 및 `stage`). 각 환경은 별도의 AWS 계정에 존재
* 각 환경은 [Terraform Registry](https://registry.terraform.io/)에서 제공되는 기존 인프라 모듈(`alb`)의 다른 버전을 사용합니다.
* 로컬 디렉토리에서 소스를 제공하므로 각 환경은 같은 버전의 내부 모듈 `modules/network`을 사용합니다.

{% hint style="success" %}
* 인프라가 논리적으로 분리된 프로젝트에 적합(별도의 AWS 계정들이 쓰임)
* AWS 계정 간에 공유된 리소스를 수정할 필요가 없는 경우(환경 1개 = AWS 계정 1개 = 상태 파일 1개)에 좋음
* 환경 간에 변경 사항을 조정할 필요가 없는 경우에 적합
* 인프라리소스가 환경별로 의도적으로 달라 일반화할 수 없는 경우(예: 어떤 리소스가 특정 환경이나 일부 지역에 없음)
{% endhint %}

{% hint style="warning" %}
프로젝트가 커짐에 따라 이러한 환경을 서로 최신 상태로 유지하는 것은 더욱 어려워집니다. 반복 가능한 작업에 인프라 모듈(기존 모듈 또는 내부 모듈) 사용을 고려해 보세요.
{% endhint %}
