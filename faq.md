---
description: 자주 묻는 테라폼에 관한 질문
---

# FAQ

## 제가 알고 있어야 하고 사용을 고려해야 할 도구는 무엇일까요? <a href="#what-are-the-tools-i-should-be-aware-of-and-consider-using" id="what-are-the-tools-i-should-be-aware-of-and-consider-using"></a>

* [**Terragrunt**](https://terragrunt.gruntwork.io/) - 오케스트레이션 도구
* [**tflint**](https://github.com/terraform-linters/tflint) - 코드 린터
* [**tfenv**](https://github.com/tfutils/tfenv) - 버전 관리자
* [**Atlantis**](https://www.runatlantis.io/) - 풀 리퀘스트 자동화
* [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) - pre-commit 프레임워크와 함께 사용하는 Terraform용 git 후크 모음
* [**Infracost**](https://www.infracost.io) - 풀 요청에서 Terraform에 대한 클라우드 비용 추정. Terragrunt, Atlantis 및 pre-commit 테라폼에서도 사용 가능합니다.

## [의존성 지옥](https://en.wikipedia.org/wiki/Dependency\_hell)에 대한 해결책은 무엇입니까? <a href="#what-are-the-solutions-to-dependency-hell-with-modules" id="what-are-the-solutions-to-dependency-hell-with-modules"></a>

리소스 및 인프라 모듈의 버전을 지정해야 합니다. 프로바이더는 모듈 외부에서, 하지만 구성(composition) 내에서만 구성되어야(configure) 합니다. 프로바이더 및 Terraform 버전도 잠글 수 있습니다.

마스터 의존성 관리 도구는 없지만 의존성 사양과 관련된 문제를 줄이는 몇 가지 팁이 있습니다. 예를 들어, [Dependabot](https://dependabot.com/)을 사용하여 의존성 업데이트를 자동화할 수 있습니다. Dependabot은 의존성을 안전하게 최신 상태로 유지하기 위해 풀 리퀘스트를 생성합니다. Dependabot은 Terraform 구성(configurations)을 지원합니다.
