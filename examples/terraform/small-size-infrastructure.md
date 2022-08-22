# תשתיות בקנה מידה קטן עם Terraform

מקור: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

דוגמא זו מכילה קוד לבניית קונפיגורציית Terraform עבור תשתית בקנה מידה קטן, שבה לא נעשה שימוש בתלות חיצונית.

{% hint style="success" %}
* מושלם להתחלה ולשיכתוב בהמשך
* מושלם עבור מודולי משאבים קטנים
* מתאים למודולי תשתית קטנים וליניאריים
* טוב למספר קטן של משאבים (פחות מ- 20-30)
{% endhint %}

{% hint style="warning" %}
קובץ מצב יחיד עבור כל המשאבים יכול להאט את תהליך העבודה עם Terraform אם מספר המשאבים גדל\
(שקול להשתמש בארגומנט - יעד (`target-)` להגבלת מספר המשאבים)
{% endhint %}
