# Υποδομή μικρού μεγέθους με Terraform

Πηγή: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

Αυτό το παράδειγμα περιέχει κώδικα ως παράδειγμα δόμησης των ρυθμίσεων του Terraform για μια υποδομή μικρού μεγέθους, όπου δεν χρησιμοποιούνται εξωτερικές εξαρτήσεις.

{% hint style="success" %}
* Ιδανικό για να ξεκινήσετε και να αναδιαμορφώσετε καθώς προχωράτε
* Ιδανικό για μικρές ενότητες πόρων
* Καλό για μικρές και γραμμικές ενότητες υποδομής (π.χ. [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis))
* Καλό για μικρό αριθμό πόρων (λιγότερους από 20-30)&#x20;
{% endhint %}

{% hint style="warning" %}
Το ενιαίο αρχείο κατάστασης για όλους τους πόρους μπορεί να κάνει τη διαδικασία εργασίας με το Terraform αργή αν ο αριθμός των πόρων αυξάνεται (εξετάστε το ενδεχόμενο να χρησιμοποιήσετε ένα όρισμα `-target` για να περιορίσετε τον αριθμό των πόρων)
{% endhint %}
