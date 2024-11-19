---
description: >-
  이 문서는 Terraform 사용의 모범 사례를 체계적으로 설명하고 Terraform 사용자들이 겪는 가장 흔한 문제에 대한 권장 사항을
  제공합니다.
---

# 어서오세요

[Terraform](https://www.terraform.io)은 강력하며(지금 최강의 툴이 아니라면) 가장 많이 사용되는 도구 중 하나로, 인프라를 코드로 관리할 수 있습니다. 개발자들이 많은 일을 할 수 있도록 해주며 지원과 통합을 손쉽게 만들어 줍니다.

이 책에서 설명하는 정보의 일부는 모범 사례처럼 보이지 않을지 모릅니다. 저도 이를 인지하고 있습니다. 따라서 독자들이 사용자들이 선호하는 비슷한 방식과 업계에서 확립된 모범 사례를 구분할 수 있도록, 문맥에 대한 힌트와 아이콘을 사용해 각 하위 항목과 관련된 모범 사례의 깊이를 표시해 두었습니다.

이 책은 2018년 햇살이 가득한 마드리드에서 집필을 시작했으며, 여기 이 주소에서 읽어볼 수 있습니다. [https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com).

Terraform 1.0에서 사용할 수 있는 실질적 모범 사례를 지난 몇 년 간 업데이트해 왔습니다. 결과적으로 이 책에는 Terraform 사용자들을 위한, 논란의 여지가 없는 모범 사례와 권장 사항이 대부분 포함되어 있다고 할 수 있습니다.

## 후원자

Please [contact me](https://github.com/antonbabenko/terraform-aws-devops#social-links) if you want to become a sponsor.

| [![](.gitbook/assets/ctf-logo.png)](https://compliance.tf/?utm_source=tf_best_practices&utm_medium=sponsorship) | [Compliance.tf](https://compliance.tf/?utm_source=tf_best_practices&utm_medium=sponsorship) — Terraform Compliance Simplified. Make your Terraform modules compliance-ready. |
| --------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [![](.gitbook/assets/)]()                                                                                       | []() —                                                                                                                                                                       |

## 번역

{% content-ref url="https://app.gitbook.com/s/u3iITRIHQx97ro2PkfdC/" %}
[العربية (Arabic)](https://app.gitbook.com/s/u3iITRIHQx97ro2PkfdC/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/PJbgKPAX0ohEMLpETpg7/" %}
[Bosanski (Bosnian)](https://app.gitbook.com/s/PJbgKPAX0ohEMLpETpg7/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/B48qUSNPO2XmkIySLzfr/" %}
[Português (Brazilian Portuguese)](https://app.gitbook.com/s/B48qUSNPO2XmkIySLzfr/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/e1Mp2scOX6OnQbifCen3/" %}
[English](https://app.gitbook.com/s/e1Mp2scOX6OnQbifCen3/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/6shyPtr2KrqW4ANbFXYg/" %}
[Français (French)](https://app.gitbook.com/s/6shyPtr2KrqW4ANbFXYg/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/DyguS0uZfMW7X7m9BWx1/" %}
[ქართული (Georgian)](https://app.gitbook.com/s/DyguS0uZfMW7X7m9BWx1/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/PKopCWJZbhpQ9FT0W8tL/" %}
[Deutsch (German)](https://app.gitbook.com/s/PKopCWJZbhpQ9FT0W8tL/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/5c1kFpqxaDZC2g9e6rtT/" %}
[ελληνικά (Greek)](https://app.gitbook.com/s/5c1kFpqxaDZC2g9e6rtT/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/4bq6CyY8vYiEHkjN63rT/" %}
[עברית (Hebrew)](https://app.gitbook.com/s/4bq6CyY8vYiEHkjN63rT/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/Mgong4S6IjtibE055zUM/" %}
[हिंदी (Hindi)](https://app.gitbook.com/s/Mgong4S6IjtibE055zUM/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/ZLCz7lNWbSJxDGuNOI44/" %}
[Bahasa Indonesia (Indonesian)](https://app.gitbook.com/s/ZLCz7lNWbSJxDGuNOI44/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/8VlMHbHDbW6qRWdgN5oU/" %}
[Italiano (Italian)](https://app.gitbook.com/s/8VlMHbHDbW6qRWdgN5oU/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/3vykLOWgdQLPLgHtxqQH/" %}
[日本語 (Japanese)](https://app.gitbook.com/s/3vykLOWgdQLPLgHtxqQH/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/BoZVs6O2OJFQLNV1utmm/" %}
[ಕನ್ನಡ (Kannada)](https://app.gitbook.com/s/BoZVs6O2OJFQLNV1utmm/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/9yChMGbFo2G47Wiow1yY/" %}
[Polski (Polish)](https://app.gitbook.com/s/9yChMGbFo2G47Wiow1yY/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/sFM1GW5TPCGsskQ03mTm/" %}
[Română (Romanian)](https://app.gitbook.com/s/sFM1GW5TPCGsskQ03mTm/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/5VD4NK4mHOY8SWjC9N5e/" %}
[简体中文 (Simplified Chinese)](https://app.gitbook.com/s/5VD4NK4mHOY8SWjC9N5e/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/fTxekzr50pIuGmrPkXUD/" %}
[Español (Spanish)](https://app.gitbook.com/s/fTxekzr50pIuGmrPkXUD/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/Fedpbc5NbKjynXI8xTeF/" %}
[Türkçe (Turkish)](https://app.gitbook.com/s/Fedpbc5NbKjynXI8xTeF/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/tXRvMPILxeJaJTM2CsSq/" %}
[Українська (Ukrainian)](https://app.gitbook.com/s/tXRvMPILxeJaJTM2CsSq/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/dcjhau04KQIKHUJA90iN/" %}
[اردو (Urdu)](https://app.gitbook.com/s/dcjhau04KQIKHUJA90iN/)
{% endcontent-ref %}

이 책을 다른 언어로 번역하는 데 기여하고 싶다면 저에게 연락주세요.

## 기여

시간이 지남에 따라 커뮤니티가 성숙해가고 새로운 아이디어가 구현 및 검증되어감에 따라 저는 항상 피드백을 받아 이 책을 업데이트 하고자 합니다.

특정 주제에 관심이 있다면 [이슈를 열거나,](https://github.com/antonbabenko/terraform-best-practices/issues) 다루어졌으면 하는 이슈에 엄지손가락을 눌러주세요. 기여하고 싶은 **콘텐츠를 가지고 계시면** 초안을 작성해 풀 리퀘스트를 제출해 주세요(이 단계에서는 빼어난 글솜씨를 걱정할 필요가 없습니다!).

## 저자

이 책은 다양한 기고자와 번역가의 도움을 받아 [안똔 바벤코(Anton Babenko)](https://github.com/antonbabenko)가 유지하고 있습니다.

## 특허(라이선스)

이 저작물은 Apache 2 라이선스에 따라 라이선스가 부여됩니다. 자세한 내용은 [라이선스](https://github.com/antonbabenko/terraform-best-practices/blob/master/LICENSE)를 참조하세요.

본 컨텐츠의 저자와 기여자는 본 컨텐츠에서 발견되는 정보의 유효성을 보장하지 않습니다. 귀하는 본 컨텐츠에서 제공되는 정보는 자유롭게 제공되며, 귀하와 본 컨텐츠 또는 프로젝트와 관련된 사람들 사이에 그 어떤 종류의 합의나 계약도 이루어지지 않는다는 점을 이해하셔야 합니다. 오류 또는 누락이 과실, 사고 또는 어떤 기타 원인에 의한 것이든, 본저자와 기여자는 컨텐츠에 포함되거나, 관련되거나, 연결된 정보의 오류 또는 누락으로 인한 그 어떠한 손실, 손상 또는 중단에 대해서 당사자에게 그 어떠한 책임도 지지 않으며 그책임을 부인함을 여기밝힙니다.

저작권© 2018-2023 안똔 바벤코 Anton Babenko.
