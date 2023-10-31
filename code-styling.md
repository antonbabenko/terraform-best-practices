# کُوڈ اسٹائلنگ

* &#x20;ٹیرافارم ماڈلز اور مثالیں میں فیچرز اور انہیں استعمال کرنے کے طریقے کی وضاحت کرنے والی دستاویزات ہونی چاہئیں۔
* README.md فائلوں کے تمام لنکس مطلق ہونے چاہئیں تاکہ ٹیرافارم رجسٹری کی ویب سائٹ انہیں صحیح طریقے سے دکھا سکے۔
* دستاویزات میں [mermaid](https://github.com/mermaid-js/mermaid) کے ساتھ بنائے گئے ڈایاگرام اور [cloudcraft.co](https://cloudcraft.co/) کے ساتھ بنائے گئے بلیو پرنٹس شامل ہو سکتے ہیں۔
* [ٹیرافارم پری-کمیٹ ہکس](https://github.com/antonbabenko/pre-commit-terraform) استعمال کریں تاکہ یہ یقینی بنایا جا سکے کہ کوڈ درست ہے، صحیح طریقے سے فارمیٹ کیا گیا ہے، اور خود بخود دستاویز کیا گیا ہے اس سے پہلے کہ اسے git میں پش کیا جائے اور انسانوں کے ذریعہ جائزہ لیا جائے۔

## **دستاویزات**

### خودکار طور پر تیار کردہ دستاویزات

[پری کمٹ](https://pre-commit.com/) ایک فریم ورک ہے جو کثیر زبانی پری کمٹ ہکس کو منظم اور برقرار رکھنے کے لیے استعمال ہوتا ہے۔ یہ پائتھن میں لکھا گیا ہے اور ایک طاقتور ٹول ہے جو کسی ڈویلپر کی مشین پر کوڈ کو git ریپوزٹری پر کمٹ کرنے سے پہلے خودکار طریقے سے کچھ کرنے کے لیے استعمال کیا جا سکتا ہے۔ عام طور پر، اسے linter اور کوڈ کو فارمیٹ کرنے کے لیے استعمال کیا جاتا ہے ([سپورٹڈ hooks](https://pre-commit.com/hooks.html) دیکھیں)۔

ٹیرافارم کنفیگریشنز کے ساتھ `pre-commit` **کا کوڈ فارمیٹ اور تصدیق کرنے کے ساتھ ساتھ دستاویزات کو اپ ڈیٹ کرنے کے لیے بھی استعمال کیا جا سکتا ہے۔**

[پری کمٹ ٹیرافارم](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md) کو چیک کریں تاکہ اس سے آگاہی حاصل کی جا سکے، اور موجودہ ریپوزٹریاں (مثلاً، terraform-[aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc)) جہاں یہ پہلے ہی استعمال ہو رہی ہیں۔

### ٹیرافارم کی دستاویزات

[ٹیرافارم کی دستاویزات](https://github.com/segmentio/terraform-docs) ایک ایسا ٹول ہے جو ٹیرافارم ماڈلز سے مختلف آؤٹ پٹ فارمیٹس میں دستاویزات تیار کرتا ہے۔ آپ اسے دستی طور پر (pre-commit hooks کے بغیر) چلا سکتے ہیں، یا [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform) کے  ساتھ استعمال کر سکتے ہیں تاکہ دستاویزات خود بخود اپ ڈیٹ ہو جائیں۔

**@todo:** release, GH actions ,دستاویز کے ماڈیول ورژن

## حوالہ جات

1. [pre-commit framework homepage](https://pre-commit.com/)
2. [Collection of git hooks for Terraform to be used with pre-commit framework](https://github.com/antonbabenko/pre-commit-terraform)
3. Blog post by [Dean Wilson](https://github.com/deanwilson): [pre-commit hooks and terraform - a safety net for your repositories](https://www.unixdaemon.net/tools/terraform-precommit-hooks/)\
