# المفاهيم الأساسية

تصف [وثائق Terraform الرسمية](https://developer.hashicorp.com/terraform/language) جميع مصطلحات تعريف البنى التحتية بالتفصيل. اقرأها بعناية لفهم بقية هذا القسم.

يشرح هذا القسم المفاهيم الأساسية المستخدمة في الكتاب

## المورد (Resource)

المورد هو aws\_vpc، aws\_db\_instance الخ...، ينتمي المورد إلى موفر معين (provider) ويقبل الوسيطات (arguments) ويولد المخرجات (outputs) وله دورات حياة (lifecycles). يمكن إنشاء مورد واسترجاع معلوماته وتحديثه وحذفه.&#x20;

## وحدة الموارد (Resource module)

وحدة الموارد هي مجموعة من الموارد المرتبطة ببعضها والتي تقوم مع بعضها بتنفيذ وظيفة معينة (لنأخذ [AWS VPC Terraform module](https://github.com/terraform-aws-modules/terraform-aws-vpc/) كمثال، تقوم هذه الوحدة ببناء VPC، subnets, NAT gateway والعديد من الموارد التي نستعملها للتشبيك)، تعتمد وحدة الموارد على الموفر، ويتم تعريفها أما في الموفر أو في الهياكل عالية المستوى (على سبيل المثال ، في وحدة البنية التحتية). &#x20;

## وحدة البنية التحتية (Infrastructure module)

وحدة البنية التحتية هي مجموعة وحدات موارد والتي قد لا تتربط منطقياً ولكنها توجد في مشروع أو نظام يخدم نفس الهدف. تعرف هذه الوحدة الـتهيئة (configuration)  للموفرين (providers)، والتي تقوم بتمريرها إلى وحدات الموارد والموارد المؤلفة لهذه الوحدة.  عادةً ما يقتصر العمل في وحدة بنية تحتية واحدة لكل كيان منفصل (على سبيل المثال ، AWS Region ، Google Project).&#x20;

كمثال فإن وحدة البنية التحتية [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis/) تستعمل وحدات الموارد مثل [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc/) و [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group/) لإدارة البنية التحتية اللازمة لتشغيل [Atlantis](https://www.runatlantis.io) on [AWS Fargate](https://aws.amazon.com/fargate/).&#x20;

كمثال أخر فإن وحدة البنية التحتية [terraform-aws-cloudquery](https://github.com/cloudquery/terraform-aws-cloudquery) يتم استعمالها لإدارة البنية التحتية كما تقوم باستعمال أداة Docker لإدارة Docker images في وحدة واحدة.

## التركيب (Composition)

التركيب هو مجموعة من وحدات البنية التحتية والتي يمكن أن تمدد على العديد من المناطق المنفصلة (AWS Regions, AWS Accounts) . يتم استعمال التركيب لوصف كامل البنية التحتية لمؤسسة أو مشروع. &#x20;

كما يبين الشكل يتألف تركيب البنية التحتية (infrastructure composition) من مجموعة وحدات بنية تحتية (infrastructure module) والتي تتكون من وحدات موارد (resources module) والتي تنجز عدة موارد محددة&#x20;

![Simple infrastructure composition](.gitbook/assets/composition-1.png)

## مصدر البيانات (Data source)

يوفر مصدر البيانات مورداً قابلاً للقراءة فقط (read-only) ويعتمد على نمط الموفر (provider) الذي نتعامل معه، يتم استعماله من قبل كل من وحدة البنية التحتية ووحدة الموارد.&#x20;

يعتبر مصدر البيانات `terraform_remote_state`أداة لربط الوحدات عالية المستوى والتراكيب المختلفة مع بعضها

يسمح مصدر البيانات [external](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data\_source) بالبرامج الخارجية بالعمل كمصدر للبيانات ليتم التعامل معها في مكان أخر من ملفات التهئية الخاصة بأداة Terraform، يمكن أن نجد مثالاً في [terraform-aws-lambda module](https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/258e82b50adc451f51544a2b57fd1f6f8f4a61e4/package.tf#L5-L7) حيث يتم الحصول على اسم الملف من خلال استدعاء كود Python خارجي

يحصل مصدر البيانات [http](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) على معلوماته من خلال إرسال طلب HTTP GET لرابط معين ويصدر الجواب الذي حصلنا عليه ويعتبر هذه المصدر مفيداً في حال عدم وجود موفر Terraform.

## ملف الحالة المخرن عن بعد (Remote state)

يجب تخزين [Terraform state](https://www.terraform.io/docs/language/state/index.html) لكل من وحدات البنية التحتية والتراكيب عن بعد حيث يمكن استرجاعه من قبل كل الأشخاص العاملين عليه ويجب أن تتم إدارته بشكل يضمن السرية والتنظيم (e.g. specify ACL, versioning, logging). &#x20;

## الموفر (Provider, provisioner)

&#x20;يوجد توصيف مجزي لمفهوم الموفر في وثائق Terraform الرسمية، ولا يوجد لازمة لتكرارها هنا، وبرأي أن ليس لها علاقة بكتابة وحدات Terraform جيدة.

## أين الصعوبة؟

بينما يمكننا اعتبار أن الموارد هي عبارة عن ذرات فإن "وحدات الموارد" تعتبر الجزئيات. "وحدة الموارد" هي أصغر وحدة يمكننا مشاركتها وإنشاء إصدرات منها، لديها قائمة محددة من الوسيطات، وتنجز وظيفة معينة. إذا أخذنا الوحدة  [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group) كمثال فإننا سنجد أنها تقوم بإنشاء الموارد `aws_security_group` و `aws_security_group_rule` بالاعتماد على الدخل، يمكن استعمال هذه الوحدة مع وحدات أخرى لإنشاء وحدة بنية تحتية.

حتى نتمكن من الوصول إلى بيانات فإننا نستعمل مخرجات الوحدات (outputs) بالإضافة إلى مصادر البيانات (data sources)&#x20;

حتى نتمكن من تبادل البيانات من تركيب إلى تركيب أخر يجب علينا استعمال مصدر البيانات `terraform_remote_state،`([كما يوجد العديد من الطرق لتبادل البيانات](https://developer.hashicorp.com/terraform/language/state/remote-state-data#alternative-ways-to-share-data-between-configurations))

وأخيراً يمكننا تمثيل المفاهيم المشروحة سابقاً بهذا الشكل

```
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
