# Terraform을 사용한 소규모 인프라

출처: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

이 예시에는 외부 의존성을 전혀 사용하지 않는 소규모 인프라에 대한 Terraform 구성(configurations)을 구조화하는 예제 코드가 포함되어 있습니다.

{% hint style="success" %}
* 프로젝트를시작하고 진행해 가면서 리팩토링하기에 딱입니다.
* 소규모 리소스 모듈에 적합
* 소규모 및 선형 인프라 모듈(예: [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis))에 적합
* 소수의 리소스에 적합(20\~30개 미만)
{% endhint %}

{% hint style="warning" %}
리소스 수가 증가하는 경우, 모든 리소스에 대한 단일 상태 파일은 Terraform 작업 프로세스를 느리게 만들 수 있습니다(리소스 수를 제한하려면 `-target` 인수를 사용하는 것이 좋습니다).
{% endhint %}
