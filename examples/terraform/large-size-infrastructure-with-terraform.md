# البنى الكبيرة باستعمال Terraform

المصدر:  [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/large-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/large-terraform)

يحتوي هذا المثال على كود لهيكلة كود Terraform لبنية تحتية كبيرة والتي تستعمل:

* حسابين AWS
* منطقتين
* بيئتين مختلفتين (`prod` and `stage` لا وجود لشيء مشترك بينهما). كل بيئة موجودة في حساب AWS مختلف وتوزع الموارد على المنطقتين
* كل بيئة تستعمل إصدارات مختلفة للوحدات الجاهزة (alb) مصدرها [Terraform Registry](https://registry.terraform.io/)&#x20;
* كل بيئة تستعمل الإصدار نفسه للوحدات الداخلية `modules/network` مصدره المجلد المحلي

{% hint style="info" %}
في المشاريع الكبيرة مثل المشروع أعلاه تظهر أهمية استعمال أداة Terragrunt. انظر إلى [Code Structures examples with Terragrunt](../terragrunt.md). &#x20;
{% endhint %}

{% hint style="success" %}
* ممتاز للمشاريع التي تحتاج إلى فصل منطقي لبيئاتها (باستعمال حسابات AWS مختلفة)
* جيد عندما لا يوجد حاجة لتعديل الموارد المشتركة بين حسابات AWS المختلفة (بيئة واحدة = حساب AWS واحد = ملف حالة وحيد)
* جيد عندما لا يوجد حاجة لتنسيق التعديلات بين البيئات المختلفة&#x20;
* جيد عند الاختلاف المتعمد للموارد بين البيئات والذي لا يمكن تعريف حالة عامة له (كوجود بعض الموارد في بيئة وغيابها في بيئة أخرى)&#x20;
{% endhint %}

{% hint style="warning" %}
&#x20;مع نمو المشروع ، سيكون من الصعب الحفاظ على تحديث هذه البيئات مع بعضها البعض. خذ بعين الاعتبار استخدام وحدات البنية التحتية (الجاهزة أو الداخلية) للمهام المتكررة.
{% endhint %}

##
