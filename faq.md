---
description: FTP (Frequent Terraform Problems اكثر المشاكل التي تعاني منها الأداة)
---

# الأسئلة الأكثر تكراراً

## ما هي الأدوات التي يجب معرفتها واستخدامها؟

* أداة [**Terragrunt**](https://terragrunt.gruntwork.io/) -أداة تنسيق
* &#x20;أداة [**tflint**](https://github.com/terraform-linters/tflint)
* أداة [**tfenv**](https://github.com/tfutils/tfenv) - إدارة الإصدارات
* أداة [**Atlantis**](https://www.runatlantis.io/) أتمتة العمل مع PR
* أداة [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) مجموعة من git-hooks خاصة بأداة Terraform التي يتم استعمالها مع إطار العمل [pre-commit framework](https://pre-commit.com/)

## ما هي الحلول لمشكلة [dependency hell](https://en.wikipedia.org/wiki/Dependency\_hell) مع الوحدات؟

يجب تحديد إصدار الوحدة التي نتعامل معها. يجب تعريف الموفرات خارج الوحدات وفقط في التراكيب، يجب أيضاً  تحديد إصدار الموفرات وإصدار Terraform أالذي نتعامل معه.&#x20;

لا يوجدا أداة إدارة Dependency، لكن يوجد بعض النصائح التي تجعل هذه المشكلة أقل إشكالاً. كمثال يمكن استعمال أداة [Dependabot](https://dependabot.com/) لأتمتة تحديث الارتباطات. تقوم هذه الأداة بإنشاء PR للحفاظ على الارتباطات بشكل أمن ومحدث. تدعم هذه الأداة ملفات Terraform.&#x20;
