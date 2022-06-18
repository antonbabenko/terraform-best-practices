# Mittlere Infrastruktur mit Terraform

Quellcode: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform)

Dieses Beispiel enthält Code als Beispiel für die Strukturierung von Terraform-Konfigurationen für eine mittelgroße Infrastruktur, dazu werden verwendet:

* 2 AWS-Konten
* 2 separate Umgebungen (`prod` und `stage`, die sich nichts teilen). Jede Umgebung befindet sich in einem separaten AWS-Konto.
* Jede Umgebung verwendet eine andere Version des Standard-Infrastrukturmoduls (`alb`), das aus der [Terraform-Registry](https://registry.terraform.io/) stammt.
* Jede Umgebung verwendet die gleiche Version eines internen Moduls `modules/network`, da es aus einem lokalen Verzeichnis stammt.

{% hint style="success" %}
* Perfekt für Projekte, bei denen die Infrastruktur logisch getrennt ist (separate AWS-Konten)
* Gut, wenn keine Notwendigkeit besteht, zwischen AWS-Konten geteilte Ressourcen zu ändern (eine Umgebung = ein AWS-Konto = eine Statusdatei)
* Gut, wenn kein Bedarf an der Orchestrierung von Änderungen zwischen den Umgebungen besteht
* Gut, wenn die Infrastrukturressourcen pro Umgebung absichtlich unterschiedlich sind und nicht verallgemeinert werden können (z. B. sind einige Ressourcen in einer Umgebung oder in einigen Regionen nicht vorhanden)
{% endhint %}

{% hint style="warning" %}
Je größer das Projekt wird, desto schwieriger wird es, diese Umgebungen untereinander auf dem neuesten Stand zu halten. Erwägen Sie den Einsatz von Infrastrukturmodulen (von der Stange oder intern) für wiederholbare Aufgaben.
{% endhint %}

##
