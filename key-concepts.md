# بنیادی خیال

ٹیرافارم (Terraform) کی دستاویزات تمام پہلوؤں کو تفصیل سے بیان کرتی ہیں۔ اس سیکشن کے باقی حصوں کو سمجھنے کے لیے [اسے غور سے پڑھیں۔](https://developer.hashicorp.com/terraform/language)

**یہ سیکشن ان اہم بنیادی** خیالات **کی وضاحت کرتا ہے جو کتاب میں استعمال کیے جاتے ہیں**

## ریسورس (Resource)

ریسورس (Resource)  `aws_vpc`, `aws_db_instance`وغیرہ ہوتے ہیں۔ ایک ریسورس کسی provider سے تعلق رکھتا ہے، arguments قبول کرتا ہے، خصوصیات آؤٹ پٹ(outputs) کرتا ہے، اور اس کا ایک lifecycle ہوتا **ہے۔** ایک ریسورس کو بنایا، حاصل کیا، اپ ڈیٹ کیا اور ختم کیا جا سکتاہے &#x20;

## ریسورس کے ماڈیول (Resource module)

ریسورس کے ماڈیول( Resource module) منسلک ریسورسز  `Resources` کا ایک مجموعہ ہوتاہے جو مل کر مشترکہ کارروائی انجام دیتے ہیں (مثال کے طور پر،   [AWS VPC Terraform module](https://github.com/terraform-aws-modules/terraform-aws-vpc/)  VPC، subnets ، NAT gateway وغیرہ بناتا ہے)۔ یہ provider  کی ترتیب پر منحصر ہے، جس کی وضاحت اس میں کی جا سکتی ہے، یا اعلیٰ سطح کے ڈھانچے میں (مثال کے طور پر، انفراسٹرکچر (module) میں)

## &#x20;انفراسٹرکچر  ماڈیول (Infrastructure module)

ایک انفراسٹرکچر ماڈیول، ریسورس ماڈیولز کا ایک مجموعہ ہے، جو منطقی طور پر منسلک نہیں ہو سکتے، لیکن موجودہ صورتحال/پروجیکٹ/سیٹ اپ میں ایک ہی مقصد پورا کرتے ہیں۔ یہ provider کے لیے ترتیب کو متعین کرتا ہے، جو ڈاون اسٹریم ریسورس ماڈیولز اور ریسورس کو پاس کر دیا جاتا ہے۔ یہ عام طور پر ایک منطقی سیپریٹر (مثال کے طور پر، AWS Region, Google Project) **کے ساتھ کام کرنے کے لیے محدود ہوتا ہے۔**

\
مثال کے طور پر، [terraform-aws-atlantis](https://github.com/cloudquery/terraform-aws-cloudquery) ماڈیول میں [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc/) اور [ terraform-aws-security-  group](https://github.com/terraform-aws-modules/terraform-aws-security-group/)  جیسے ریسورس ماڈیولز استعمال ہوتے ہیں تاکہ [AWS Fargate](https://aws.amazon.com/fargate/) پر [Atlantis](https://www.runatlantis.io/) کو چلانے کے لئے ضروری انفراسٹرکچر کو بنایا جا سکے۔

دوسری مثال [terraform-aws-cloudquery](https://github.com/cloudquery/terraform-aws-cloudquery) ماڈیول کی ہے جہاں [terraform-aws-modules](https://github.com/terraform-aws-modules/) کی طرف سے مختلف ماڈیولز کا اشتراک ہوتا ہے تاکہ انفراسٹرکچر کو منظم کیا جا سکے اور Docker کے  ریسورس کا استعمال کیا جا سکتا ہے تاکہ ایک ہی سیٹ میں images Docker  **کو تخلیق، منتقلی، اور تنصیب کیا جا سکے ۔**

## **ترکیب (**Composition)&#x20;

ترکیب انفراسٹرکچر ماڈیولز کا ایک مجموعہ ہے، جو کئی منطقی طور پر الگ علاقوں (مثال کے طور پر،Regions  AWS ، متعدد AWS **اکاؤنٹس) میں پھیلا ہو سکتا ہے۔ ترکیب کو پوری تنظیم یا پروجیکٹ کے لیے درکار مکمل انفراسٹرکچر کی وضاحت کے لیے استعمال کیا جاتا ہے۔**

**ترکیب میں انفراسٹرکچر ماڈیولز ہوتے ہیں، جن میں ریسورس ماڈیولز ہوتے ہیں، جو انفرادی ریسورس کو بناتے  ہیں۔**\


![Simple infrastructure composition](.gitbook/assets/composition-1.png)

## ڈیٹا سورس **(**Data source)

ڈیٹا سورس  **(**Data source) ایک ریڈ-اونلی `read-only` آپریشن انجام دیتا ہے اور provider **کی ترتیب پر منحصر ہے، یہ ایک ریسورس ماڈیول اور ایک انفراسٹرکچر ماڈیول میں استعمال ہوتاہے۔**

**ڈیٹا سورس  `terraform_remote_state` اعلیٰ سطحی ماڈیولز اور ترکیبوں کے لیے گلو کے طور پر کام کرتا ہے۔**

[بیرونی ڈیٹا](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external)  کسی بیرونی پروگرام کو ڈیٹا سورس کے طور پر کام کرنے کی اجازت دیتا ہے، جو ٹیرافارم Terraform **ترتیب میں کہیں اور استعمال کے لیے غیر معمولی ڈیٹا کو بے نقاب کرتا ہے۔** [**terraform-aws-lambda** ](https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/258e82b50adc451f51544a2b57fd1f6f8f4a61e4/package.tf#L5-L7)**ماڈیول سے ایک مثال یہاں ہے جہاں فائل کا نام ایک بیرونی Python اسکرپٹ کو کال کرکے کمپیوٹ کیا جاتا ہے۔**

ہتپ [http](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http)  ڈیٹا  سورس دیئے گئے URL پر HTTP GET کی درخواست کرتا ہے اور ردعمل کے بارے میں معلومات حاصل کرتا ہے جو اکثر endpoints  سے معلومات حاصل کرنے کے لیے مفید ہوتا ہے جہاں Terraform provider **موجود نہیں ہوتا ہے۔**

## &#x20;ریموٹ حالت (Remote state)

\
انفراسٹرکچر ماڈیولز اور ترتیبوں کو اپنی [Terraform state](https://www.terraform.io/docs/language/state/index.html) کو ایک remote جگہ میں جمع رکھنی چاہئے جہاں دوسرے لوگوں کی طرف سے اسے ایک کنٹرول طریقے سے استعمال کیا جا سکتا ہے (مثلاً، specify ACL, versioning, logging)۔

## &#x20;فراہم کنندہ، فراہم کرنے والا، وغیرہ (Provider, provisioner, etc)

\
پروودرس Providers، پرووسونیرس provisioners، اور کچھ دوسرے مصطلحات کو آفیشل دستاویز میں بہت اچھی طرح وضاحت کی گئی ہے اور یہاں پر اسے دہرانے کا کوئی موقع نہیں ہے۔ میرے خیال میں، ان کا زیادہ Terraform modules **لکھنے سے کچھ تعلق نہیں ہے۔**

## &#x20;یہ کیوں اتنا مشکل ہے؟ (?Why so _difficult_)

انفرادی ریسورس بنیادی ڈھانچے میں ایٹموں کی طرح ہوتے ہیں، جب کہ ریسورس ماڈیولز مالیکیولز (ایٹموں پر مشتمل) ہوتے ہیں۔ ماڈیول سب سے چھوٹی ورژن والی اور شیئر کرنے والی اکائی ہے۔ اس میں دلائل کی ایک درست فہرست ہے، جو اس طرح کی اکائی کے لیے مطلوبہ کام کرنے کے لیے بنیادی منطق کو استعمال کرتی ہے۔ مثال کے طور پر، [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group) ماڈیول ان پٹ کی بنیاد پر `aws_security_group` اور `aws_security_group_rule` **ریسورس بناتا ہے۔ یہ ریسورس ماڈیول انفراسٹرکچر ماڈیول بنانے کے لیے دیگر ماڈیولز کے ساتھ مل کر استعمال کیا جا سکتا ہے۔**

مالیکیولز (ریسورس ماڈیولز اور انفراسٹرکچر ماڈیولز) میں ڈیٹا تک رسائی ماڈیولز کے آؤٹ پٹس اور data sources **کا استعمال کرکے کی جاتی ہے۔**

ترکیبات کے درمیان رسائی اکثر ریموٹ سٹیٹ data sources **کا استعمال کرکے کی جاتی ہے۔** [پیکجوں کے درمیان ڈیٹا شیئر کرنے کے کئی طریقے ہیں۔](https://www.terraform.io/docs/language/state/remote-state-data.html#alternative-ways-to-share-data-between-configurations)

&#x20;اوپر بیان کردہ چیزوں کو pseudo-**ریلیشنز کرنے میں رکھیں تو یہ کچھ اس طرح نظر آ سکتا ہے:**



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
