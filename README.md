---
description: >-
  This document is an attempt to systematically describe best practices using
  Terraform and provide recommendations for the most frequent problems Terraform
  users experience.
---

# Welcome

[Terraform](https://www.terraform.io) is a fairly new project (as most DevOps tools actually) that was started in 2014.

Terraform is powerful (if not the most powerful out there now) and one of the most used tools which allow management of infrastructure as code. It allows developers to do a lot of things and does not restrict them from doing things in ways that will be hard to support or integrate with.

Some information described in this book may not seem like the best practices. I know this, and to help readers to separate what are established best practices and what is just another opinionated way of doing things, I sometimes use hints to provide some context and icons to specify the level of maturity on each subsection related to best practices.

The book was started in sunny Madrid in 2018, available for free here at [https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com).

A few years later it has been updated with more actual best practices available with Terraform 1.0. Eventually, this book should contain most of the indisputable best practices and recommendations for Terraform users.

## Translations

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/" %}
[Español (Spanish)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/fTxekzr50pIuGmrPkXUD/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/" %}
[Bahasa Indonesia (Indonesian)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/" %}
[Français (French)](https://app.gitbook.com/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/)
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

Contact me if you want to help translate this book into other languages.

## Contributions

I always want to get feedback and update this book as the community matures and new ideas are implemented and verified over time.

If you are interested in specific topics, please [open an issue](https://github.com/antonbabenko/terraform-best-practices/issues), or thumb up an issue you want to be covered. If you feel that **you have content** and you want to contribute, write a draft and submit a pull request (don't worry about writing good text at this point!).

## Authors

This book is maintained by [Anton Babenko](https://github.com/antonbabenko) with the help of different contributors and translators.

## Sponsors

| [![](.gitbook/assets/cluster-dev-logo-site.png)](https://cluster.dev) | [Cluster.dev](http://cluster.dev) — the only manager for cloud-native infrastructures.                   |
| --------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| [![](.gitbook/assets/coder-logo-for-sponsor.png)](http://coder.com/)  | [Coder.com](http://coder.com/) — create remote development machines for your team, powered by Terraform. |

## License

This work is licensed under Apache 2 License. See LICENSE for full details.

The authors and contributors to this content cannot guarantee the validity of the information found here. Please make sure that you understand that the information provided here is being provided freely, and that no kind of agreement or contract is created between you and any persons associated with this content or project. The authors and contributors do not assume and hereby disclaim any liability to any party for any loss, damage, or disruption caused by errors or omissions in the information contained in, associated with, or linked from this content, whether such errors or omissions result from negligence, accident, or any other cause.

Copyright © 2018-2022 Anton Babenko.
