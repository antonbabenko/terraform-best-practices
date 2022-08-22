---
description: >-
  מסמך זה הוא ניסיון לתאר באופן שיטתי שיטות עבודה מומלצות כאשר משתמשים ב
  Terraform ולספק המלצות לבעיות הכי שכיחות שחויים משתמשי Terraform.
---

# ברוכים הבאים

[Terraform](https://www.terraform.io/) הוא פרויטק חדש למדי (כמו רוב הכלים בחלל ה DevOps) שהחל ב2014.

Terraform הוא כלי רב עוצמה (אם לא העוצמתי ביותר שיש בשוק כרגע) ואחד הכלים המשומשים ביותר המאפשר ניוהל של תשתיות כקוד. זה מאפשר למתפחים לעשות הרבה דברים ולא מגביל אותם בצורה שתהיה קשה לתחזוק,תמיכה ואינטגרציה.

ייתכן שחלק מהמידע המתואר בספר זה לא נראה כמו שיטות העבודה הכי טובות. אני יודע זאת, וכדי לעזור לקוראים להפריד בין שיטות עבודה מבוססות ומהן דעות אישיות על עשיית דברים, אני לפעמים משמתש ברמזים כדי לספק  הקשר ואייקונים כדי לציין את רמת המוכנות בכל תת-סעיף הקשור לשיטות העבודה המומלצות.

הספר התחיל במדריד בשנת 2018, זמין בחינם בכתובת [https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com).

כמה שנים לאחר מכן, הוא עודכן עם שיטות עבודה מומלצות יותר אשר זמינות עם Terraform גרסה 1.0. בסופו של דבר, הספר אמור להכיל את רוב שיטות העבודה המומלצות והבלתי מעורערות עבור משמתשי Terraform.

## תרגומים

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/e1Mp2scOX6OnQbifCen3/" %}
[English](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/e1Mp2scOX6OnQbifCen3/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/" %}
[Español (Spanish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/" %}
[Bahasa Indonesia (Indonesian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/" %}
[Français (French)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/PKopCWJZbhpQ9FT0W8tL/" %}
[Deutsch (German)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/PKopCWJZbhpQ9FT0W8tL/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/8VlMHbHDbW6qRWdgN5oU/" %}
[Italiano (Italian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/8VlMHbHDbW6qRWdgN5oU/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/" %}
[Português (Brazilian Portuguese)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/" %}
[Polski (Polish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/" %}
[Українська (Ukrainian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/)
{% endcontent-ref %}

צרו איתי קשר אם אתם מעוניים לעזור בתרגום הספר לספות שונות.

## תרומות

אני תמיד רוצה לקבל משוב ולעדכן את הספר ככל שהקהילה גדלה, מתבגרת ורעיונות חדשים מיושמים ומאומתים לאורך  זמן

אם אתם מעוניינים בנושאים ספציפיים, אנא פתחו סוגייה, או סמנו נושא שאתם רוצים שאכסה אותו. אם אתה מרגיש שיש לך תוכן לתרום, כתוב טיוטה ושלח pull request (אל תדאג/י לגבי כתיבת טקסט טוב בשלב זה!)

## מחברים

ספר זה מתוחזק על ידי [Anton Babenko](https://github.com/antonbabenko) ובעזרת תורמים ומתרגמנים שונים.

## ספונסרים

| [![](.gitbook/assets/cluster-dev-logo-site.png)](https://cluster.dev) | [Cluster.dev](http://cluster.dev) — the only manager for cloud-native infrastructures.                   |
| --------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| [![](.gitbook/assets/coder-logo-for-sponsor.png)](http://coder.com/)  | [Coder.com](http://coder.com/) — create remote development machines for your team, powered by Terraform. |

## רישיון

This work is licensed under Apache 2 License. See LICENSE for full details.

The authors and contributors to this content cannot guarantee the validity of the information found here. Please make sure that you understand that the information provided here is being provided freely, and that no kind of agreement or contract is created between you and any persons associated with this content or project. The authors and contributors do not assume and hereby disclaim any liability to any party for any loss, damage, or disruption caused by errors or omissions in the information contained in, associated with, or linked from this content, whether such errors or omissions result from negligence, accident, or any other cause.

Copyright © 2018-2022 Anton Babenko.
