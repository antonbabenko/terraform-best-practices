# 코드 스타일링

{% hint style="info" %}
* 예제와 Terraform 모듈에는 기능 설명과 사용법을 기술하는 문서가 포함되어야 합니다.
* README.md 파일의 모든 링크는 Terraform Registry 웹사이트에서 올바르게 표시되도록 절대 링크여야 합니다.
* 문서에는 [mermaid](https://github.com/mermaid-js/mermaid) 로 만든 다이어그램과 [cloudcraft.co](https://cloudcraft.co)로 만든 청사진이 포함되어 있을 수 있습니다.
* [Terraform 사전 커밋 후크 (Terraform pre-commit hooks](https://github.com/antonbabenko/pre-commit-terraform))를 사용하여 코드가 git에 푸시되고 사람들이 검토하기에 앞서 코드가 유효하고, 형식이 적절하고, 자동으로 문서화되었는지 확인하세요.
{% endhint %}

## 문서

### 자동으로 생성된 문서 <a href="#automatically-generated-documentation" id="automatically-generated-documentation"></a>

[pre-commit](https://pre-commit.com/)(사전 커밋)은 다중 언어 사전 커밋 후크를 관리하고 유지하기 위한 프레임워크입니다. Python으로 작성되었으며 코드가 git 저장소에 커밋되기에 앞서 개발자의 컴퓨터에서 자동으로 작업을 수행하는 강력한 도구입니다. 일반적으로 린터를 실행하고 코드 형식을 지정하는 데 사용됩니다([지원되는 후크 ](https://pre-commit.com/hooks.html)참조).

Terraform 구성(configurations)을 사용하면 `pre-commit`(사전 커밋)을 사용하여 코드 형식을 지정하고 유효성을 검사할 수 있을 뿐만 아니라 문서를 업데이트할 수 있습니다.

사전 커밋이 익숙해지도록 [pre-commit-terraform 저장소](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md)를 확인해보세요. 그리고 이 저장소가 이미 사용되고 있는 기존 저장소(예: [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc))도 확인해 보세요.

### 테라폼 독스(terraform-docs)

[terraform-docs](https://github.com/segmentio/terraform-docs)(테라폼 독스)는 Terraform 모듈에서 다양한 출력 형식으로 문서를 생성하는 도구입니다. 사전 커밋 후크 없이 수동으로 실행하거나, [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform)(사전 커밋 Terraform 후크)를 사용하여 문서를 자동으로 업데이트할 수 있습니다.

@todo: Document module versions, release, GH actions

## 리소스

1. [pre-commit 프레임워크 홈페이지](https://pre-commit.com/)
2. [pre-commit 프레임워크와 함께 사용하는 Terraform용 git 후크 모음](https://github.com/antonbabenko/pre-commit-terraform)
3. [Dean Wilson](https://github.com/deanwilson) 블로그 글: [pre-commit 훅과 terraform - 당신의 저장소를 위한 안전망](https://www.unixdaemon.net/tools/terraform-precommit-hooks/)
