---
description: בעיות תכופות עם Terraform.
---

# שאלות ותשובות

## מהם הכלים שעליכם להיות מודעים אליהם ולשקול להשתמש בהם

* [**Terragrunt**](https://terragrunt.gruntwork.io/) - כלי אורקסטרציה
* [**tflint**](https://github.com/terraform-linters/tflint) - סורק קוד
* [**tfenv**](https://github.com/tfutils/tfenv) - מנהל גרסאות
* [**Atlantis**](https://www.runatlantis.io/) - אוטומציית Pull Request
* [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) - אוסף של git hooks עבור Terraform לשימוש עם פלטפורמת [pre-commit framework](https://pre-commit.com/)
* [**Infracost**](https://www.infracost.io) - הערכת עלויות בענן עבור Terraform, עובד עם Terragrunt, Atlantis ו pre-commit-terraform.

## מה הפתרונות עם '[גיהנום התלויות](https://en.wikipedia.org/wiki/Dependency\_hell)' עם מודלים?

גרסאות של משאבים ומודלים צריכים להיות מוגדרים. ספקים (providers) יש להגדיר מחוץ למודלים, אבל רק בקומפוזיציה. גרסאות של ספקים וTerraform יכולים להיות נעולים גם.

אין כלי קסם לניהול תלויות, אבל יש כמה טיפים שיעזרו להפחית את הבעיות בתחזוק תלויות. לדוגמה, ניתן להשתמש ב Dependabot כדי להפוך עדכוני תלויות לאומוטיים. Dependabot יוצר pull requests כדי לשמור על  התלויות שלך מאובטחות ומעודכנות. Dependabot תומך בTerraform.
