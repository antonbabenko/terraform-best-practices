# Estructura del código

Las preguntas relacionas a la estructura del código de Terraform son por mucho las más frecuentes dentro de la comunidad. Probablemente todos en algún punto han pensado acerca de la mejor estructura para el código.

### ¿Cómo debería de estructurar mis configuraciones de Terraform?&#x20;

Esta es una de las preguntas en las que existen muchas soluciones y es muy difícil dar un consejo general, así que comencemos por comprender con qué estamos tratando.&#x20;

* ¿Cuál es la complejidad del proyecto?
  * Número de recursos relacionados.
  * Número de proveedores de Terraform.
* ¿Qué tan seguido cambia la infraestructura?
  * **De** una vez al mes, semana, día.
  * **A** continuamente (cada que hay un nuevo _commit_).
* ¿Cuáles son los iniciadores de cambio del código? ¿_Se permite que un servidor CI -continuous integration- actualice el repositorio cuando un nuevo artefacto es compilado_?
  * Sólo los desarrolladores pueden _pushear_ al repositorio de infraestructura.
  * Todos pueden proponer cambios mediante una PR -_pull_ _request_- (incluyendo tareas automatizadas corriendo en un servidor CI)
* ¿Qué plataforma o servicio de despliegue se utiliza?
  * AWS CodeDeploy, Kubernetes y OpenShift requieren planteamientos diferentes.
* ¿Cómo son agrupados los entornos?
  * Por entorno, región, proyecto.

{% hint style="info" %}
Los _proveedores lógicos_ trabajan por completo dentro de la propia lógica de Terraform y no interactúan con ningún otro servicio, así que podemos pensar en su complejidad como O(1). Los proveedores lógicos más comunes incluyen [<mark style="color:purple;">random</mark>](https://registry.terraform.io/providers/hashicorp/random/latest/docs), [<mark style="color:purple;">local</mark>](https://registry.terraform.io/providers/hashicorp/local/latest/docs), <mark style="color:purple;"></mark> [<mark style="color:purple;">terraform</mark>](https://www.terraform.io/language/state/remote-state-data), <mark style="color:purple;"></mark> [<mark style="color:purple;">null</mark>](https://registry.terraform.io/providers/hashicorp/null/latest/docs), <mark style="color:purple;"></mark> [<mark style="color:purple;">time</mark>](https://registry.terraform.io/providers/hashicorp/time/latest).
{% endhint %}

### Comenzando con la estructuración de la configuración de Terraform

Poner todo el código en `main.tf` es una buena idea de cuando estás comenzando o escribiendo un código ejemplo. Para cualquier otro caso será mejor tener varios archivos en una separación lógica como a continuación se presenta:

* main.tf - llama a los módulos, locals y data-sources para crear todos los recursos.&#x20;
* variables.tf - contiene declaraciones de variables utilizadas en el main.tf.&#x20;
* outputs.tf - contiene outputs de recursos creados en main.tf.
* versions.tf - contiene requerimientos de versión para Terraform y proveedores.

_terraform.tfvars_ no debe ser utilizado en ningún otro lugar más que en la [<mark style="color:purple;">composición</mark>](key-concepts.md#composicion).

### **¿Cómo pensar acerca de la estructura de configuración de Terraform?**

{% hint style="info" %}
Por favor, asegúrate de comprender los conceptos clave -[<mark style="color:purple;">módulo de recurso</mark>](key-concepts.md#modulo-de-recurso), [<mark style="color:purple;">módulo de</mark>](key-concepts.md#modulo-de-infraestructura)

[<mark style="color:purple;">infraestructura</mark>](key-concepts.md#modulo-de-infraestructura) y [<mark style="color:purple;">composición</mark>](key-concepts.md#composicion),  a como son utilizados en los siguientes ejemplos.
{% endhint %}

### Recomendaciones generales para estructurar el código

* Es más fácil y rápido trabajar con un menor número de recursos.&#x20;
* `terraform plan` y `terraform apply` realizan llamadas API a la nube para verificar el estatus de los recursos.
* Si tienes toda tu infraestructura en una sola composición, puede tomar varios minutos.
* El radio de afectación -_blast radius_- es más pequeño con menos recursos.
* Aislar recursos no relacionados unos de otros al ponerlos en composiciones separadas reduce el riesgo de que algo salga mal.
* Comienza tu proyecto utilizando estados remotos.
* Tu laptop no es lugar como fuente de la verdad de tu infraestructura.
* Administrar un archivo `tfstate` en git es una pesadilla.
* Luego, cuando las capas de la infraestructura comiencen a crecer en todas direcciones (número de dependencias o recursos) será más fácil mantener las cosas bajo control.
* Practica una estructura y convención de [<mark style="color:purple;">nombrado</mark>](https://www.terraform-best-practices.com/naming) consistente.
* Como en el código procedural, el código de Terraform debe ser escrito para que, en primera, sea comprensible para las personas. La consistencia ayudará cuando se realicen cambios del día de hoy a dentro de seis meses.
* Es posible mover recursos en el archivo del estado de Terraform, pero podría ser más difícil si realizas un estructurado y nombrado inconsistente.
* Mantén los módulos de recursos tan planos como sea posible.
* No _hardcodees_ valores que pueden ser pasados como variables o descubiertos utilizando fuentes de datos -_data sources-_.
* Usa las fuentes de datos y `terraform_remote_state`, específicamente, como pegamento entre los módulos de infraestructura dentro de la composición.

En el presente libro, los ejemplos de proyectos están agrupados por _complejidad -_de pequeñas a muy grandes infraestructuras. Está separación no es restrictiva, así que revisa también por otras infraestructuras.&#x20;

### Orquestación de módulos de infraestructura y composiciones

Tener una infraestructura pequeña significa que también se cuenta con un pequeño número de dependencias así como de recursos. Conforme el proyecto crece, la necesidad de encadenar la ejecución de configuraciones de Terraform, conectando diferentes módulos de infraestructura y pasando valores dentro de una composición, se vuelve visible.

Existen al menos 5 diferentes grupos de soluciones de orquestación que los desarrolladores utilizan:

1. Sólo Terraform - Muy directo, los desarrolladores sólo tienen que saber Terraform para tener el trabajo hecho.
2. Terragrunt - Herramienta de orquestación pura que se puede utilizar para orquestar toda la infraestructura y gestionar las dependencias. Terragrunt opera con módulos y composiciones de infraestructura de manera nativa, lo que reduce la duplicación de código.
3. Scripts propios - A menudo, esto sucede como un punto de partida hacia la orquestación y antes de descubrir Terragrunt.
4. Ansible otra herramienta de automatización de propósito general similar - Usualmente utilizada cuando Terraform es adoptado después de Ansible, o cuando Ansible UI es utilizada activamente.
5. [<mark style="color:purple;">Crossplane</mark>](https://crossplane.io) y otras soluciones inspiradas en Kubernetes - En algunas ocasiones  hace sentido el utilizar el ecosistema de Kubernetes y emplear alguna funcionalidad de reconciliación de bucle para alcanzar el estado deseado de la configuración de Terraform. Ve el vídeo <mark style="color:purple;"></mark> [<mark style="color:purple;">Crossplane vs Terraform</mark>](https://www.youtube.com/watch?v=ELhVbSdcqSY) para mayor información.&#x20;

Con esto en mente, estaremos revisando las primeras dos estructuras de proyectos, sólo [<mark style="color:purple;">Terraform</mark>](examples/terraform/) y [<mark style="color:purple;">Terragrunt</mark>](examples/terragrunt.md).
