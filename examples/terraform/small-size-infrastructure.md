# Terraform per infrastrutture di piccole dimensioni

Sorgente: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

Questo esempio contiene codice per la strutturazione delle configurazioni Terraform per un infrastruttura di piccole dimensioni, dove non sono usate dipendenze esterne.

{% hint style="success" %}
* Perfetto per iniziare e fare la rifattorizzazione mentre procedi.
* Perfetto per moduli con poche risorse
* Buono per moduli di infrastrutture piccoli e lineari come (per esempio, [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis))
* Buono per un piccolo numero di risorse (meno di 20-30)
{% endhint %}

{% hint style="warning" %}
Un singolo file di stato per tutte le risorse, può rendere il processo di esecuzione di Terraform lento se il numero di risorse é in crescita (considera l'uso dell'argomento -`target` per limitare il numero di risorse)
{% endhint %}
