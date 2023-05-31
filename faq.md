---
description: FTP (Frequent Terraform Problems)
---

# Συχνές ερωτήσεις

## Ποια είναι τα εργαλεία που πρέπει να γνωρίζω και να εξετάσω τη χρήση τους;

* [**Terragrunt**](https://terragrunt.gruntwork.io/) - Εργαλείο ενορχήστρωσης
* [**tflint**](https://github.com/terraform-linters/tflint) - Linter κώδικα
* [**tfenv**](https://github.com/tfutils/tfenv) - Διαχειριστής έκδοσης
* [**Atlantis**](https://www.runatlantis.io/) - Αυτοματοποίηση αιτημάτων pull
* [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) - Συλλογή git hooks για την Terraform που μπορούν να χρησιμοποιηθούν με το [pre-commit framework](https://pre-commit.com/)
* [**Infracost**](https://www.infracost.io/) - Εκτιμήσεις κόστους cloud για την Terraform σε pull requests. Λειτουργεί επίσης με την Terragrunt, το Atlantis και το pre-commit-terraform.

## Ποιες είναι οι λύσεις για την «[κόλαση των εξαρτήσεων](https://en.wikipedia.org/wiki/Dependency\_hell)» με τις ενότητες;

Οι εκδόσεις των μονάδων πόρων και υποδομών θα πρέπει να προσδιορίζονται. Οι πάροχοι θα πρέπει να διαμορφώνονται εκτός των μονάδων, αλλά μόνο στη σύνθεση. Η έκδοση των παρόχων και του Terraform μπορεί επίσης να κλειδωθεί.

Δεν υπάρχει κύριο εργαλείο διαχείρισης εξαρτήσεων, αλλά υπάρχουν ορισμένες συμβουλές για να γίνουν οι προδιαγραφές εξαρτήσεων λιγότερο προβληματικές. Για παράδειγμα, το [Dependabot](https://dependabot.com/) μπορεί να χρησιμοποιηθεί για την αυτοματοποίηση των ενημερώσεων των εξαρτήσεων. Το Dependabot δημιουργεί pull requests για να διατηρείτε τις εξαρτήσεις σας ασφαλείς και ενημερωμένες. Το Dependabot υποστηρίζει ρυθμίσεις Terraform.
