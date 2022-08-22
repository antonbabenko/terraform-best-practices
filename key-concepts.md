# מושגי מפתח

התיעוד הרשמי של Terraform מתאר את כל [היבטי הקונפיגורציה](https://www.terraform.io/language) בפירוט רב. קראו אותו בעיון כדי להבין את שאר עמוד זה.

עמוד זה מתאר מושגים מרכזיים המשמשים בתוך הספר.

## משאב

משאב הוא AWS\_vpc , AWS\_db\_instation וכדומה. משאב שייך לספק, מקבל ארגומנטים, פולט תכונות ובעל מחזור חיים. ניתן ליצור, לאחזר, לעדכן ולמחוק משאב.

## מודולים של משאבים

מודול משאב הוא אוסף של משאבים מחוברים אשר יחד מבצעים את הפעולה המשותפת (לדוגמה, המודול  AWS VPC Terrasform יוצר VPC, רשתות משנה, שער NAT וכדומה). הדבר תלוי בקונפיגורצית הספק, שניתן להגדירה בתוכה, או במבנים ברמה גבוהה יותר (למשל, במודל תשתית).

## מודולים של תשתיות&#x20;

מודול תשתית הוא אוסף של מודלי משאבים, שניתן לחבר באופן לא לוגי, אך במצב הנוכחי/בפרוייקט/בהגדרה משרתת את אותה המטרה. היא מגדירה את הקונפיגורציה עבור הספקים, המועברים למודולי המשאבים ולמשאבים עצמם. בדרך כלל, היא מוגבלת לעבודה בישות אחת לכל מפריד לוגי (לדוגמה, AWS Region, Google Project).

לדוגמה, מודול [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis/) משתמש במודולי משאבים כגון [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc/) ו-[terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group/) כדי לנהל את התשתית הדרושה להפעלת [Atlantis](https://www.runatlantis.io/) ב-[AWS Fargate](https://aws.amazon.com/fargate/).

דוגמה נוספת היא מודול  [terraform-aws-cloudquery](https://github.com/cloudquery/terraform-aws-cloudquery) שבו נעשה שימוש במודולים מרובים על-ידי [terraform-aws- modules](https://github.com/terraform-aws-modules) יחד כדי לנהל את התשתית וכן להשתמש במשאבי Docker כדי לבנות, לדחוף ולפרוס Docker images. הכל בקונפיגורציה  אחת.

## קומפוזיציה

קומפוזיציה הוא אוסף של מודולי תשתית, היכולים להתפרס על-פני מספר אזורים מופרדים לוגית (לדוגמה, אזורי AWS, מספר חשבונות AWS). ההרכב משמש לתיאור התשתית המלאה הדרושה לארגון או לפרוייקט כולו.

הרכב מורכב ממודולי תשתית, הכוללים מודולי משאבים, אשר מיישמים משאבים בודדים.

![Simple infrastructure composition](.gitbook/assets/composition-1.png)

## מקור מידע

מקור מידע מבצע פעולת קריאה בלבד ותלוי בקונפיגורצית הספק, הוא משומש במודולי משאבים ובמודולי תשתית.

מקור מידע `terraform_remote_state` משמש כדבק עבור מודולים ורכיבים ברמה גבוהה יותר.

מקור הנתונים [החיצוני](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data\_source) מאפשר לתוכנית חיצונית לפעול כמקור נתונים ולחשוף נתונים שרירותיים לשימוש במקומות אחרים בקונפיגורציית Terraform. להלן דוגמה ממודול [terraform-aws-module](https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/258e82b50adc451f51544a2b57fd1f6f8f4a61e4/package.tf#L5-L7) שבו שם הקובץ מחושב על-ידי קריאה לקובץ python Script חיצוני.

מקור המידע http הופך בקשת get HTTP לכתובת ה- URL הנתונה, ומיצא מידע אודות התגובה, אשר שימושית לעתים קרובות לקבלת מידע מנקודות קצה שבהן ספק Terraform אינו קיים.

## מצב מרוחק

מודולי תשתית וקומפוזיציות אמורים לאחסן את קבצי המצב שלהם במיקום מרוחק, שבו ניתן לגשת אליהם על-ידי מפתחים אחרים בדרך נשלטת (לדוגמה, ACL, ניהול גירסאות, ורישום).

## ספק, מקצה משאבים, וכו׳

ספקים, מקצה משאבים ומספר מונחים אחרים מתוארים היטב בתיעוד הרשמי ואין טעם לחזור על כך כאן. לדעתי, אין להם קשר עם כתיבת מודולי Terraform טובים.

## למה כלכך _קשה_?

בעוד שמשאבים בודדים דומים לאטומים בתשתית, מודולי משאבים הם מולקולות (כולל אטומות). מודול הוא היחידה הקטנה ביותר הניתנת לשיתוף והפקת גרסאות. הוא כולל רשימה מדויקת של ארגומנטים, מיישם לוגיקה בסיסית עבור יחידה כזו כדי לבצע את הפונקציה הנדרשת. לדוגמה, מודול קבוצת אבטחה [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group) יוצר משאבים של `aws_security_group` ו- `aws_security_group_rule` המבוססים על קלט. ניתן להשתמש במודול משאבים זה בפני עצמו יחד עם מודולים אחרים כדי ליצור את מודול התשתית.

הגישה למידע על פני מולקולות (מודולי משאבים ומודולי תשתית) מבוצעת באמצעות ייצוא המודולים ומקורות המידע.

הגישה בין ההרכבים מתבצעת לעתים קרובות באמצעות מקורות נתונים של מצב מרוחק.[ קיימות דרכים מרובות לשיתוף נתונים בין תצורות.](https://www.terraform.io/language/state/remote-state-data#alternative-ways-to-share-data-between-configurations)

כאשר ממחישים את המושגים המתוארים לעיל ביחסי פסאודו, הדבר עשוי להיראות כך:

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
