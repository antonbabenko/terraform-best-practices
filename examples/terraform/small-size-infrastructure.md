# البنى الصغيرة باستعمال Terraform

المصدر:  [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

يحتوي هذا المثال على كود لهيكلة كود Terraform لبنية تحتية صغيرة، حيث لا وجود لاعتمادات خارجية

{% hint style="success" %}
* ممتاز للبدء بتعلم Terraform وإعادة هيكلة الكود (refactoring)
* ممتاز لبناء الوحدات الصغيرة
* جيد لاستعمال الوحدات الصغيرة (eg, [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis))
* جيد عند وجود عدد صغير من الموارد (أقل من 20-30)
{% endhint %}

{% hint style="warning" %}
وجود ملف حالة وحيد Single state file من أجل كل الموارد سيجعل أداة Terraform بطيئة كلما زاد عدد الموارد المعرفة (خذ بعين الاعتبار استعمال الوسيط `target-` للحد من الموارد التي تتعامل معها عند طلب الأداة)&#x20;
{% endhint %}
