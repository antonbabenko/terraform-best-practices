# 주요 개념

공식 Terraform 문서는 [구성(configuration)의 모든 측면을 자세히 설명](https://developer.hashicorp.com/terraform/language)합니다. 이 섹션의 나머지 부분을 이해하려면 주의 깊게 읽으세요

이 섹션에서는 이 책에서 사용되는 주요 개념을 설명합니다.

## 리소스(Resource)

리소스는 is `aws_vpc`, `aws_db_instance` 등입니다. 리소스는 어느 한 프로바이더에 속하며 인수(arguments)를 수락하고 속성(attributes)을 출력(output)하며 수명 주기(lifecycle)를가집니다. 리소스는 생성, 검색, 업데이트 및 삭제할 수 있습니다.

## 리소스 모듈(Resource module)

리소스 모듈은 공통 작업(예: AWS VPC Terraform 모듈이 VPC, 서브넷, NAT 게이트웨이 등을 생성함)을 함께 수행하는 연결된 리소스의 집합입니다. 이는 공급자 구성에 따라 달라지며, 이는 공급자의 구성에 따라 다르며, 공급자 구성 안에서 정의하거나 상위 수준의 구조(예: 인프라 모듈)에서 정의할 수 있습니다.

## 인프라 모듈(Infrastructure module)

인프라 모듈은 논리적으로 연결되지는 않지만 현재 상황/프로젝트/셋업에서 동일한 목적을 수행하는 리소스 모듈의 집합입니다. 공급자에 대한 구성을 정의하고 다운스트림 리소스 모듈 및 리소스로 전달됩니다. 일반적으로 논리적 구분자(예: AWS Region, Google Project)당 하나의 엔티티에서 작업하도록 제한됩니다.

예를 들어 [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis/) 모듈은 [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc/) 및 [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group/)과 같은 리소스 모듈을 사용하여 [AWS Fargate](https://aws.amazon.com/fargate/)에서 [Atlantis](https://www.runatlantis.io)를 실행하는 데 필요한 인프라를 관리합니다.

또 다른 예로 [terraform-aws-modules](https://github.com/terraform-aws-modules/) 모듈을 여러 개 함께 사용하여 인프라를 관리하고 도커 리소스를 사용하여 도커 이미지를 구축, 푸시 및 배포하는 [terraform-aws-cloudquery](https://github.com/cloudquery/terraform-aws-cloudquery) 모듈이 있습니다. 이 모든 것이 한 세트로 이루어집니다.

## 구성(Composition)

구성은 논리적으로 분리된 여러 영역(예: AWS 지역, 여러 AWS 계정)에 걸쳐 존재할 수 있는 인프라 모듈의 모음입니다. 구성은 전체 조직이나 프로젝트에 필요한 전체 인프라를 설명하는 데 사용됩니다.

구성은 개별 리소스를 구현하는 리소스 모듈들로 이루어진 인프라 모듈입니다.

<figure><img src=".gitbook/assets/Composition 1 (4) Korean with English.drawio.png" alt=""><figcaption><p>간단한 인프라 구성</p></figcaption></figure>

## 데이터 소스(Data source)

데이터 소스는 읽기 전용 작업을 수행하며 프로바이더 구성에 따라 리소스 모듈 및 인프라 모듈에서 사용됩니다.

데이터 소스 `terraform_remote_state`는 상위 모듈 및 구성(compositions)에 접착제 역할을 합니다.

데이터 소스 [external(외부)](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external)는 외부 프로그램이 데이터 소스 역할을 하여, 테라폼 구성(configuration)의 다른 곳에서 사용할 수 있도록 임의의 데이터를 노출시킵니다. 예로[terraform-aws-lambda module](https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/258e82b50adc451f51544a2b57fd1f6f8f4a61e4/package.tf#L5-L7)이 있습니다. 여기서 파일 이름은 외부 파이썬 스크립트를 호출하여 계산됩니다.

데이터 소스 [http](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http)는 주어진 URL로 HTTP GET 요청을 보내고 응답에 대한 정보를 내보냅니다. 이는 네이티브 Terraform 프로바이더가 존재하지 않는 엔드포인트에서 정보를 얻는 데 유용한 경우가 많습니다.

## 원격 상태(Remote state)

인프라 모듈 및 구성(compositions)은 [Terraform state](https://www.terraform.io/docs/language/state/index.html)를 다른 사용자가 제어 가능한 방식(예: ACL 지정, 버전 관리, 로깅)으로 검색할 수 있는 원격 위치에 지속시켜야 합니다.

## 프로파이더(provider), 프로비저너 (provisioner) 및 기타

프로파이더, 프로비저너 및 기타 몇 가지 용어는 공식 문서에 매우 잘 설명되어 있으므로 여기서 반복할 필요가 없습니다. 제 생각에는 좋은 Terraform 모듈을 쓰는 것과는 거의 관련이 없습니다.

## 왜 이렇게 어려울까?

개별 리소스는 인프라의 원자와 같으며 리소스 모듈은 분자(여러 개의 원자로 구성됨)와 같습니다. 모듈은 버전이 관리되고 공유가 가능한 가장 작은 단위입니다. 모듈에는 정확한 인수 목록이 있으며, 해당 단위가 필요한 기능을 수행하도록 기본 논리를 구현합니다. 예를 들어 [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group) 모듈은 입력을 기반으로 리소스 `aws_security_group` 및 `aws_security_group_rule`을 생성합니다. 이 리소스 모듈 자체를 다른 모듈과 함께 사용하여 인프라 모듈을 만들 수 있습니다.

분자(리소스 모듈 및 인프라 모듈) 전반의 데이터에 대한 액세스는 모듈의 아웃풋(outputs) 및 데이터 소스(data sources)를 사용하여 이루어집니다.

구성(compositions) 간 액세스는 원격 상태(remote state)의 데이터 소스를 사용하여 수행되는 경우가 많습니다. [구성 간에 데이터를 공유하는 방법에는 여러 가지](https://developer.hashicorp.com/terraform/language/state/remote-state-data#alternative-ways-to-share-data-between-configurations)가 있습니다.

위에서 설명한 개념을 의사 코드(pseudo-relations)로 표현한다면 다음과 같이 보일 것입니다.

```
# 한국어
구성-1 {
  인프라-모듈-1 {
    데이터-소스-1 => d1

    리소스-모듈-1 {
      데이터-소스2 => d2
      리소스-1 (d1, d2)
      리소스-2 (d2)
    }

    리소스-모듈-2 {
      데이터-소스-3 => d3
      리소스-3 (d1, d3)
      리소스-4 (d3)
    }
  }
}
```

```
# 영어(English)
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
