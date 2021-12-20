# Infraestructura de tamaño pequeño con Terraform

Fuente:  [h<mark style="color:purple;">ttps://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform</mark>](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)<mark style="color:purple;"></mark>

La presente integra código como ejemplo de la estructuración de la configuración para una infraestructura de tamaño pequeño, en donde no son utilizadas dependencias externas.

{% hint style="success" %}
* Perfecta para comenzar y refactorizar a medida que avanzas.
* Perfecta para módulos de recurso pequeños.
* Bueno para módulos de infraestructura pequeños y lineares (por ejemplo, [<mark style="color:purple;">terraform-aws-atlantis</mark>](https://github.com/terraform-aws-modules/terraform-aws-atlantis)).
* Bueno para un número pequeño de recursos (menos de 20 o 30).
{% endhint %}

{% hint style="warning" %}
Contar con un sólo archivo de estado para todos los recursos puede hacer lento el proceso de trabajo con Terraform si el número de recursos está creciendo (considerar el uso del argumento `-target` para limitar el número de recursos).
{% endhint %}
