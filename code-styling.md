# تنسيق الكود

{% hint style="info" %}
* يجب أن تحتوي أمثلة ووحدات Terraformعلى توثيق لشرح الخصائص التي تقدمها وكيفية استعمالها
* كل الروابط في ملف README.md يجب أن تكون مطلقة لجعل موقع Terraform Registry يعرضها بشكل صحيح
* يمكن أن يحتوي التوثيق على رسومات تم إنشاؤها باستخدام [mermaid](https://github.com/mermaid-js/mermaid) أو مخططات تم إنشاؤها باستخدام [cloudcraft.co](https://cloudcraft.co). &#x20;
* قم باستعمال [Terraform pre-commit hooks](https://github.com/antonbabenko/pre-commit-terraform) للتأكد من أن الكود صالح، ومنسق بشكل صحيح، وموثق تلقائيًا قبل دفعه إلى Git واستعراضه من قبل البشر. &#x20;
{% endhint %}

## التوثيق

### التوثيق مولداً تلقائياً

إن [pre-commit](https://pre-commit.com/) هو إطار عمل لإدارة وصيانة pre-commit hooks متعددة اللغات، مكتوبة بلغة بايثون وهي أداة قوية للقيام ببعض المهام بشكل أتوماتيكي على جهاز المطور قبل الدفع بالكود إلى git repository. تستعمل عادةً لتشغيل linters ولتنسيق الكود ( انظر إلى [supported hooks](https://pre-commit.com/hooks.html))

مع ملفات Terraform يمكننا استعمال `pre-commit`لتنسيق الكود والتحقق منه بالإضافة إلى تعديل التوثيق

تحقق من [pre-commit-terraform repository](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md) ومن  [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc) الذي يقوم باستعماله

### أداة terraform-docs

إن [terraform-docs](https://github.com/segmentio/terraform-docs) هي أداة تقوم بتوليد التوثيق من وحدات Terraform وتولد أشكال مختلفة، يمكنك أن تشغلها يدوياً (بدون pre-commit hooks) أو تستعمل إطار عمل [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform) لجعل التوثيق يتكون أتوماتيكياً.

@todo: Document module versions, release, GH actions

## الموراد

1. [pre-commit framework homepage](https://pre-commit.com/)
2. [Collection of git hooks for Terraform to be used with pre-commit framework](https://github.com/antonbabenko/pre-commit-terraform)
3. Blog post by [Dean Wilson](https://github.com/deanwilson): [pre-commit hooks and terraform - a safety net for your repositories](https://www.unixdaemon.net/tools/terraform-precommit-hooks/)
