# Infraestructura de tamaño grande con Terraform

Fuente: [<mark style="color:purple;">https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/large-terraform</mark>](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/large-terraform)<mark style="color:purple;"></mark>

La presente integra código como ejemplo de la estructuración de la configuración para una infraestructura de tamaño grande que utiliza:

* 2 cuentas de AWS.
* 2 entornos separados (`prod` y `stage`_,_ los cuales no comparten nada). Cada entorno vive en cuentas separadas de AWS.
* Cada entorno utiliza diferentes versiones del módulo estándar de infraestructura (_alb)_ proveniente de [<mark style="color:purple;">Registro de Terraform</mark>](https://registry.terraform.io) -_Terraform Registry-_.
* Cada entorno hace uso de la misma versión del módulo interno _modules/network_ dado que es procedente de un directorio local.

{% hint style="info" %}
En proyectos grandes como el aquí descrito, los beneficios de utilizar Terragrunt se hace palpable. Revisar [<mark style="color:purple;">Ejemplos de Estructuras de Código con Terragrunt</mark>](../terragrunt.md)**.**
{% endhint %}

{% hint style="success" %}
* Perfecta para proyectos en donde la infraestructura está separa lógicamente (cuentas separadas de AWS).
* Buena cuando no hay necesidad de modificar recursos compartidos entre las diferentes cuentas de AWS (un entorno = una cuenta AWS = un archivo de estado).
* Buena cuando no hay necesidad de orquestación de los cambios entre los entornos.
* Buena cuando los recursos de infraestructura son diferentes por entorno intencionalmente y no pueden ser generalizados (por ejemplo, algunos recursos están ausentes en un entorno o en algunas regiones).
{% endhint %}

{% hint style="warning" %}
A medida de que el proyecto crezca, estos entornos serán más difíciles de mantener actualizados al día unos de otros. Considerar utilizar módulos de infraestructura (estándares o propios) para tareas repetibles.
{% endhint %}
