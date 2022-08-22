# עיצוב קוד

{% hint style="info" %}
* דוגמאות ומודולי Terraform צריכים להכיל תיעוד המסביר תכונות וכיצד להשתמש בהן.
* כל הקישורים בקבצי ה README.md צריכים להיות מוחלטים (absolute path) בכדי ש Terraform Registry יוכל להציג אותם כמו שצריך
* התיעוד יכול לכלול דיאגרמות שנוצרו באמצעות [mermid](https://github.com/mermaid-js/mermaid) או תרשימים שנוצרו עם [cloudcraft.Co.](https://www.cloudcraft.co/)
* השתמשו ב [Terraform pre-commit hooks](https://github.com/antonbabenko/pre-commit-terraform) כדי לוודא שהקוד חוקי, מעוצב כהלכה, ומתועד באופן אוטומטי לפני שידחף אל גיט ויבדק על-ידי בני אדם.
{% endhint %}

## תיעוד

### ייצור תיעוד באופן אוטומטי

[pre-commit](https://pre-commit.com/) is a framework for managing and maintaining multi-language pre-commit hooks. It is written in Python and is a powerful tool to do something automatically on a developer's machine before code is committed to a git repository. Normally, it is used to run linters and format code (see [supported hooks](https://pre-commit.com/hooks.html)).



התוכנה pre-commit היא מסגרת בה אפשר לנהל ולתחזק hooks לשפות רבות. היא נכתבה בפייטון והיא כלי רב עוצמה לביצוע פעולות אוטומטיות במחשב של המפתח לפני שהקוד נכנס לgit. בדר״כ היא משומשת להרצת `linters` ועיצוב קוד. (ראו [hooks נתמכים](https://pre-commit.com/hooks.html))

עם קופניגורציית Terraform `pre-commit` יכול להיות משומש לעיצוב, ובדיקת תקינות הקוד וגם למען יצירת תיעוד.

בדקו את מאגר [pre-commit-terraform repository](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md) למען היכרות עם הכלי  וראו איך הוא כבר משומש במקומות אחרים כגון [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc)

### terraform-docs

הכלי [terraform-docs](https://github.com/terraform-docs/terraform-docs) הוא כלי ליצירת תיעוד ממודולי Terraform בתבניות פלט שונות. את/ה יכול להריץ את זה ידנית (בלי pre-commit-hooks), או להריץ את זה עם [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform) על מנת לקבל תיעוד מעודכן באופן אוטומטי.&#x20;

@todo: Document module versions, release, GH actions

## קישוריים חיצוניים

1. [pre-commit framework homepage](https://pre-commit.com/)
2. [Collection of git hooks for Terraform to be used with pre-commit framework](https://github.com/antonbabenko/pre-commit-terraform)
3. בלוג שנכתב ע״י [Dean Wilson](https://github.com/deanwilson): [pre-commit hooks and terraform - a safety net for your repositories](https://www.unixdaemon.net/tools/terraform-precommit-hooks/)
