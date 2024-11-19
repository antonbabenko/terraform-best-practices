---
description: >-
  Το παρόν έγγραφο αποτελεί μια προσπάθεια συστηματικής περιγραφής των βέλτιστων
  πρακτικών χρήσης του Terraform και παροχής συστάσεων για τα συχνότερα
  προβλήματα που αντιμετωπίζουν οι χρήστες του.
---

# Καλώς ήρθατε

Το [Terraform](https://www.terraform.io) είναι ένα πολύ ισχυρό εργαλείο (αν όχι το ισχυρότερο που υπάρχει αυτή τη στιγμή) και ένα από τα πιο συχνά χρησιμοποιούμενα εργαλεία που επιτρέπουν τη διαχείριση της υποδομής ως κώδικα. Επιτρέπει στους προγραμματιστές να κάνουν πολλά πράγματα και δεν τους περιορίζει στο να κάνουν πράγματα με τρόπους που θα είναι δύσκολο να υποστηριχθούν ή να ενσωματωθούν.

Ορισμένες πληροφορίες που περιγράφονται σε αυτό το βιβλίο μπορεί να μην φαίνονται ως οι βέλτιστες πρακτικές. Το γνωρίζω αυτό και για να βοηθήσω τους αναγνώστες να διαχωρίσουν ποιες είναι οι καθιερωμένες βέλτιστες πρακτικές και ποιος είναι απλώς ένας άλλος δογματικός τρόπος να γίνονται τα πράγματα, χρησιμοποιώ μερικές φορές υποδείξεις για να δώσω κάποιο πλαίσιο και εικονίδια για να προσδιορίσω το επίπεδο ωριμότητας σε κάθε υποενότητα που σχετίζεται με τις βέλτιστες πρακτικές.

Το βιβλίο ξεκίνησε στην ηλιόλουστη Μαδρίτη το 2018 και είναι διαθέσιμο δωρεάν στην διεύθυνση [https://www.terraform-best-practices.com/](https://www.terraform-best-practices.com).

Λίγα χρόνια αργότερα έχει ενημερωθεί με περισσότερες πραγματικές βέλτιστες πρακτικές που είναι διαθέσιμες με το Terraform 1.0. Τελικά, αυτό το βιβλίο θα πρέπει να περιέχει τις περισσότερες από τις αδιαμφισβήτητες βέλτιστες πρακτικές και συστάσεις για τους χρήστες του Terraform.

## Χορηγοί

Please [contact me](https://github.com/antonbabenko/terraform-aws-devops#social-links) if you want to become a sponsor.

| [![](.gitbook/assets/ctf-logo.png)](https://compliance.tf/?utm_source=tf_best_practices&utm_medium=sponsorship) | [Compliance.tf](https://compliance.tf/?utm_source=tf_best_practices&utm_medium=sponsorship) — Terraform Compliance Simplified. Make your Terraform modules compliance-ready. |
| --------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [![](.gitbook/assets/)]()                                                                                       | []() —                                                                                                                                                                       |

## Μεταφράσεις

{% content-ref url="https://app.gitbook.com/s/u3iITRIHQx97ro2PkfdC/" %}
[العربية (Arabic)](https://app.gitbook.com/s/u3iITRIHQx97ro2PkfdC/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/PJbgKPAX0ohEMLpETpg7/" %}
[Bosanski (Bosnian)](https://app.gitbook.com/s/PJbgKPAX0ohEMLpETpg7/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/B48qUSNPO2XmkIySLzfr/" %}
[Português (Brazilian Portuguese)](https://app.gitbook.com/s/B48qUSNPO2XmkIySLzfr/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/e1Mp2scOX6OnQbifCen3/" %}
[English](https://app.gitbook.com/s/e1Mp2scOX6OnQbifCen3/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/6shyPtr2KrqW4ANbFXYg/" %}
[Français (French)](https://app.gitbook.com/s/6shyPtr2KrqW4ANbFXYg/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/DyguS0uZfMW7X7m9BWx1/" %}
[ქართული (Georgian)](https://app.gitbook.com/s/DyguS0uZfMW7X7m9BWx1/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/PKopCWJZbhpQ9FT0W8tL/" %}
[Deutsch (German)](https://app.gitbook.com/s/PKopCWJZbhpQ9FT0W8tL/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/4bq6CyY8vYiEHkjN63rT/" %}
[עברית (Hebrew)](https://app.gitbook.com/s/4bq6CyY8vYiEHkjN63rT/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/Mgong4S6IjtibE055zUM/" %}
[हिंदी (Hindi)](https://app.gitbook.com/s/Mgong4S6IjtibE055zUM/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/ZLCz7lNWbSJxDGuNOI44/" %}
[Bahasa Indonesia (Indonesian)](https://app.gitbook.com/s/ZLCz7lNWbSJxDGuNOI44/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/8VlMHbHDbW6qRWdgN5oU/" %}
[Italiano (Italian)](https://app.gitbook.com/s/8VlMHbHDbW6qRWdgN5oU/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/3vykLOWgdQLPLgHtxqQH/" %}
[日本語 (Japanese)](https://app.gitbook.com/s/3vykLOWgdQLPLgHtxqQH/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/BoZVs6O2OJFQLNV1utmm/" %}
[ಕನ್ನಡ (Kannada)](https://app.gitbook.com/s/BoZVs6O2OJFQLNV1utmm/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/bJnDvAqIyVgo7LDHgxYJ/" %}
[한국어 (Korean)](https://app.gitbook.com/s/bJnDvAqIyVgo7LDHgxYJ/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/9yChMGbFo2G47Wiow1yY/" %}
[Polski (Polish)](https://app.gitbook.com/s/9yChMGbFo2G47Wiow1yY/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/sFM1GW5TPCGsskQ03mTm/" %}
[Română (Romanian)](https://app.gitbook.com/s/sFM1GW5TPCGsskQ03mTm/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/5VD4NK4mHOY8SWjC9N5e/" %}
[简体中文 (Simplified Chinese)](https://app.gitbook.com/s/5VD4NK4mHOY8SWjC9N5e/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/fTxekzr50pIuGmrPkXUD/" %}
[Español (Spanish)](https://app.gitbook.com/s/fTxekzr50pIuGmrPkXUD/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/Fedpbc5NbKjynXI8xTeF/" %}
[Türkçe (Turkish)](https://app.gitbook.com/s/Fedpbc5NbKjynXI8xTeF/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/tXRvMPILxeJaJTM2CsSq/" %}
[Українська (Ukrainian)](https://app.gitbook.com/s/tXRvMPILxeJaJTM2CsSq/)
{% endcontent-ref %}

{% content-ref url="https://app.gitbook.com/s/dcjhau04KQIKHUJA90iN/" %}
[اردو (Urdu)](https://app.gitbook.com/s/dcjhau04KQIKHUJA90iN/)
{% endcontent-ref %}

Επικοινωνήστε μαζί μου αν θέλετε να βοηθήσετε στη μετάφραση αυτού του βιβλίου σε άλλες γλώσσες.

## Συνεισφορές

Θέλω πάντα να λαμβάνω σχόλια και να ενημερώνω αυτό το βιβλίο καθώς η κοινότητα ωριμάζει και νέες ιδέες εφαρμόζονται και επαληθεύονται με την πάροδο του χρόνου.

Αν ενδιαφέρεστε για συγκεκριμένα θέματα, παρακαλώ ανοίξτε [ένα θέμα](https://github.com/antonbabenko/terraform-best-practices/issues) ή κάντε 'thumb up' σε ένα θέμα που θέλετε να καλυφθεί. Αν αισθάνεστε ότι **έχετε περιεχόμενο** και θέλετε να συνεισφέρετε, γράψτε ένα προσχέδιο και υποβάλετε ένα pull request (μην ανησυχείτε για τη συγγραφή καλού κειμένου σε αυτό το σημείο!).\\

## Συγγραφείς

Αυτό το βιβλίο συντηρείται από τον [Anton Babenko](https://github.com/antonbabenko) με τη βοήθεια διαφόρων συνεργατών και μεταφραστών.\\

## Άδεια

Το έργο αυτό διατίθεται με άδεια Apache 2 License. Δείτε το LICENSE για πλήρεις λεπτομέρειες.

Οι συγγραφείς και οι συντελεστές αυτού του περιεχομένου δεν μπορούν να εγγυηθούν την εγκυρότητα των πληροφοριών που βρίσκονται εδώ. Βεβαιωθείτε ότι κατανοείτε ότι οι πληροφορίες που παρέχονται εδώ παρέχονται δωρεάν και ότι δεν δημιουργείται κανενός είδους συμφωνία ή σύμβαση μεταξύ εσάς και οποιουδήποτε προσώπου που σχετίζεται με αυτό το περιεχόμενο ή το έργο. Οι συγγραφείς και οι συντελεστές δεν αναλαμβάνουν και αποποιούνται με το παρόν κάθε ευθύνη έναντι οποιουδήποτε μέρους για οποιαδήποτε απώλεια, ζημία ή διαταραχή που προκαλείται από λάθη ή παραλείψεις στις πληροφορίες που περιέχονται στο παρόν περιεχόμενο, σχετίζονται με αυτό ή συνδέονται με αυτό, είτε τα εν λόγω λάθη ή παραλείψεις οφείλονται σε αμέλεια, ατύχημα ή οποιαδήποτε άλλη αιτία.

Copyright © 2018-2023 Anton Babenko.
