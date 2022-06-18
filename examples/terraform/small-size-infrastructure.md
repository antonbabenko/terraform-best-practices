# Kleinere Infrastruktur mit Terraform

Quellcode: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

Dieses Beispiel enthält Code als Beispiel für die Strukturierung von Terraform-Konfigurationen für eine kleine Infrastruktur, in der keine externen Abhängigkeiten verwendet werden.

{% hint style="success" %}
* Perfekt für den Einstieg und zum Refactoring im laufenden Betrieb
* Perfekt für kleine Ressourcenmodule
* Gut für kleine und lineare Infrastrukturmodule (z.B. [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis))
* Gut geeignet für eine kleine Anzahl von Ressourcen (weniger als 20-30)
{% endhint %}

{% hint style="warning" %}
Eine einzige Statusdatei für alle Ressourcen kann den Arbeitsprozess mit Terraform verlangsamen, wenn die Anzahl der Ressourcen wächst (erwägen Sie die Verwendung des Arguments `-target`, um die Anzahl der Ressourcen zu begrenzen)
{% endhint %}
