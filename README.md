---
description: >-
  このドキュメントでは、Terraformのベストプラクティスを体系的に説明し、Terraformユーザーが最も頻繁に経験する問題に対する推奨事項を提供します。
---

# ようこそ

[Terraform](https://www.terraform.io)は非常に強力（現在では最も強力なものかもしれません）で、インフラをコードとして管理できるツールの中でも最も広く使用されています。開発者に多くのことを可能にし、サポートや統合が困難になる方法で作業することを制限しません。

本書で説明されている情報の一部は、ベストプラクティスとは見えないかもしれません。そのため、読者が確立されたベストプラクティスと単なる一つの意見に基づくやり方を区別できるように、時折ヒントを使って文脈を提供し、各サブセクションに関連するベストプラクティスの成熟度レベルを示すアイコンを使用しています。

本書は2018年、晴れたマドリードで書き始められ、無料で以下のサイトから入手可能です: [https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com)

数年後、Terraform 1.0で利用可能な最新のベストプラクティスで更新されました。最終的には、Terraformユーザーにとって疑いのないベストプラクティスと推奨事項のほとんどを本書に収めることを目指しています。

## 出資

スポンサーになっていただける場合は[こちら](https://github.com/antonbabenko/terraform-aws-devops#social-links)からご連絡ください。

| [![](.gitbook/assets/cast-logo.png)](https://cast.ai/antonbabenko)                                                                   | [CAST AI](https://cast.ai/antonbabenko) — Kubernetesのコストを平均60％以上削減。最初のクラスター最適化は無料です！                                                                       |
| ------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [![](.gitbook/assets/speakeasy-logo.png)](https://speakeasyapi.dev/?utm\_source=tf\_best\_practices\&utm\_medium=github+sponsorship) | [Speakeasy](https://speakeasyapi.dev/?utm\_source=tf\_best\_practices\&utm\_medium=github+sponsorship) —APIのためのTerraformプロバイダー、SDK、ドキュメント。APIをエンタープライズ対応に！ |

## 言語

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/u3iITRIHQx97ro2PkfdC/" %}
[العربية (Arabic)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/u3iITRIHQx97ro2PkfdC/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/PJbgKPAX0ohEMLpETpg7/" %}
[Bosanski (Bosnian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/PJbgKPAX0ohEMLpETpg7/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/" %}
[Português (Brazilian Portuguese)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/" %}
[Français (French)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/DyguS0uZfMW7X7m9BWx1/" %}
[ქართული (Georgian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/DyguS0uZfMW7X7m9BWx1/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/PKopCWJZbhpQ9FT0W8tL/" %}
[Deutsch (German)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/PKopCWJZbhpQ9FT0W8tL/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/5c1kFpqxaDZC2g9e6rtT/" %}
[ελληνικά (Greek)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/5c1kFpqxaDZC2g9e6rtT/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/4bq6CyY8vYiEHkjN63rT/" %}
[עברית (Hebrew)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/4bq6CyY8vYiEHkjN63rT/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/Mgong4S6IjtibE055zUM/" %}
[हिंदी (Hindi)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/Mgong4S6IjtibE055zUM/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/" %}
[Bahasa Indonesia (Indonesian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/8VlMHbHDbW6qRWdgN5oU/" %}
[Italiano (Italian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/8VlMHbHDbW6qRWdgN5oU/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/BoZVs6O2OJFQLNV1utmm/" %}
[ಕನ್ನಡ (Kannada)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/BoZVs6O2OJFQLNV1utmm/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/bJnDvAqIyVgo7LDHgxYJ/" %}
[한국어 (Korean)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/bJnDvAqIyVgo7LDHgxYJ/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/" %}
[Polski (Polish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/sFM1GW5TPCGsskQ03mTm/" %}
[Română (Romanian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/sFM1GW5TPCGsskQ03mTm/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/5VD4NK4mHOY8SWjC9N5e/" %}
[简体中文 (Simplified Chinese)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/5VD4NK4mHOY8SWjC9N5e/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/" %}
[Español (Spanish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/Fedpbc5NbKjynXI8xTeF/" %}
[Türkçe (Turkish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/Fedpbc5NbKjynXI8xTeF/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/" %}
[Українська (Ukrainian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/dcjhau04KQIKHUJA90iN/" %}
[اردو (Urdu)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/dcjhau04KQIKHUJA90iN/)
{% endcontent-ref %}

他言語への翻訳にご協力いただける方はご連絡ください。

## コントリビューション

常にフィードバックを求め、この本をコミュニティの成熟や新しいアイデアの実装・検証に応じて更新していきたいと考えています。

特定のトピックに興味がある場合は、[issue](https://github.com/antonbabenko/terraform-best-practices/issues)を立てるか、取り上げてほしいリクエストに「いいね」をしてください。また、**コンテンツを提供**したい場合は、ドラフトを書いてプルリクエストを送ってください（現時点で文章の完成度を気にする必要はありません！）。

## 著者

この本は、 [Anton Babenko](https://github.com/antonbabenko) と様々な寄稿者や翻訳者の協力によって管理されています。

## ライセンス

この作品はApache 2ライセンスの下で提供されています。詳細はLICENSEをご確認ください。

このコンテンツの著者および寄稿者は、ここで提供される情報の正確性を保証するものではありません。ここで提供される情報は自由に提供されており、このコンテンツやプロジェクトに関わるいかなる人との間にも、契約や合意が成立しないことをご理解ください。\
著者および寄稿者は、このコンテンツに含まれる、関連する、またはリンクされている情報の誤りや不足に起因して、いかなる当事者に生じた損失、損害、または混乱に対しても一切の責任を負わないことをここに明記します。これには、過失、事故、その他の理由に起因する誤りや不足が含まれます。

Copyright © 2018-2023 Anton Babenko.
