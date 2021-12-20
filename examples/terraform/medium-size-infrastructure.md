# Infraestructura  de tamaño mediano con Terraform

Fuente: [<mark style="color:purple;">https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform</mark>](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform)<mark style="color:purple;"></mark>

La presente integra código como ejemplo de la estructuración de la configuración para una infraestructura de tamaño mediano que utiliza:

* 2 cuentas de AWS.
* 2 entornos separados (`prod` y `stage`_,_ los cuales no comparten nada). Cada entorno vive en una cuenta separada de AWS.
* Cada entorno utiliza diferentes versiones del módulo estándar de infraestructura (`alb`_)_ proveniente del [<mark style="color:purple;">Registro de Terraform</mark>](https://registry.terraform.io) <mark style="color:purple;"></mark> -_Terraform Registry_**-**.
* Cada entorno hace uso de la misma versión del módulo interno `modules/network` dado que es procedente de un directorio local.

{% hint style="success" %}
* Perfecta para proyectos en donde la infraestructura está separa lógicamente (cuentas separadas de AWS).
* Buena cuando no hay necesidad de modificar recursos compartidos entre las diferentes cuentas de AWS (un entorno = una cuenta AWS = un archivo de estado).
* Buena cuando no hay necesidad de orquestación de los cambios entre los entornos.
* Buena cuando los recursos de infraestructura son diferentes por entorno intencionalmente y no pueden ser generalizados (por ejemplo, algunos recursos están ausentes en un entorno o en algunas regiones).
{% endhint %}

{% hint style="warning" %}
A medida de que el proyecto crezca, estos entornos serán más difíciles de mantener actualizados al día unos de otros. Considerar utilizar módulos de infraestructura (estándares o propios) para tareas repetibles.
{% endhint %}
