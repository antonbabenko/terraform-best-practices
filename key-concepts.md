# Conceptos clave

La documentación oficial de Terraform describe [<mark style="color:purple;">todos los aspectos de la configuración a detalle</mark>](https://www.terraform.io/language), y se recomienda leerla con atención para comprender el resto de esta sección.

### Recurso

Un recurso -_resource_- es, por ejemplo: `aws_vpc`, `aws_db_instance`, entre otros. Los recursos pertenecen a los proveedores, aceptan argumentos, muestran datos de salida de los atributos, tienen ciclos de vida. Estos pueden ser creados, recuperados, actualizados y eliminados.

### Módulo de recurso

Un módulo de recurso -_terraform module_- es una colección de recursos conectados, los cuales en conjunto realizan una acción común (por ejemplo, el [<mark style="color:purple;">módulo de VPC de AWS de Terraform</mark>](https://github.com/terraform-aws-modules/terraform-aws-vpc/) crea una VPC, sus subredes, la NAT Gateway, etc.). Este depende de la configuración del proveedor, el cual puede definirlo en sí mismo o a un nivel superior de estructura (como en un módulo de infraestructura).

### Módulo de infraestructura

Un módulo de infraestructura -_infrastructure module_- es una colección de módulos de recurso, los cuales pueden no estar conectados lógicamente pero que en el proyecto, configuración o situación en la que se encuentran, sirven a un mismo propósito.

Por ejemplo, el módulo [<mark style="color:purple;">terraform-aws-atlantis</mark>](https://github.com/terraform-aws-modules/terraform-aws-atlantis/) utiliza módulos de recurso,tales como [<mark style="color:purple;">terraform-aws-vpc</mark>](https://github.com/terraform-aws-modules/terraform-aws-vpc/) y [<mark style="color:purple;">terraform-aws-security-group</mark>](https://github.com/terraform-aws-modules/terraform-aws-security-group/), para administrar la infraestructura requerida en la ejecución de [<mark style="color:purple;">Atlantis</mark>](https://www.runatlantis.io) sobre [<mark style="color:purple;">AWS Fargate</mark>](https://aws.amazon.com/es/fargate/).

Otro ejemplo es el módulo [<mark style="color:purple;">terraform-aws-cloudquery</mark>](https://github.com/cloudquery/terraform-aws-cloudquery), en el cual múltiples módulos de [<mark style="color:purple;">terraform-aws-modules</mark>](https://github.com/terraform-aws-modules/) son utilizados de manera conjunta para administrar la infraestructura, así como el uso de recursos de Docker para el compilado, push y despliegue de imágenes de Docker. Todo en uno.

### Composición <a href="#composicion" id="composicion"></a>

Una composición -_composition_- es una colección de módulos de infraestructura, la cual puede abarcar a lo largo de diferentes áreas separadas lógicamente (como Regiones de AWS, varias Cuentas de AWS). La composición es utilizada para describir la totalidad de la infraestructura requerida para todo el proyecto u organización.

La composición consiste de módulos de infraestructura compuestos de módulos de recurso, los cuales implementan recursos individuales.

![Composición de infraestructura simple.](https://www.terraform-best-practices.com/\~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2Fe1Mp2scOX6OnQbifCen3%2Fuploads%2F6DQkdvTnhqwFfVx2btjq%2Fcomposition-1.png?alt=media)

### Fuente de datos

La fuente de datos -_data source_- realiza operaciones de sólo lectura y depende de la configuración del proveedor. Esta es usada en un módulo de recurso y en un módulo de infraestructura.

La fuente de datos `terraform_remote_state` actúa como un pegamento para módulos y recursos de más alto nivel.

La fuente de datos [<mark style="color:purple;">externa</mark>](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data\_source) permite a un programa externo actuar como fuente de datos, exponiendo arbitrariamente información en cualquier lugar de la configuración de Terraform. Aquí tenemos un ejemplo del [<mark style="color:purple;">módulo terraform-aws-lambda</mark>](https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/258e82b50adc451f51544a2b57fd1f6f8f4a61e4/package.tf#L5-L7), en el cual el nombre del archivo es procesado llamando un script externo de Python.

La fuente de datos [<mark style="color:purple;">http</mark>](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) realiza una petición HTTP GET al URL dado y exporta la información acerca de la respuesta la cual es útil para obtener información de _endpoints_ en los que no existe un proveedor nativo de Terraform.

### **Estado remoto**

\-_Remote state_- El estado de las composiciones y módulos de infraestructura debe de persistir en una locación remota la cual pueda ser accedida por otros de forma controlada (ACL, versionamiento, logging).

### **Proveedor, aprovisionador, etc.**

Los proveedores -_providers_-, aprovisionadores -_provisioners_-, y algunos otros términos son descritos a detalle en la documentación oficial, por lo que no hay necesidad de ser repetidos en la presente. En mi opinión, tienen poco que ver con escribir buenos módulos de Terraform.

### ¿Por qué es tan _difícil_?

Mientras que los recursos individuales funcionan como átomos en la infraestructura, los módulos de recursos son moléculas. Un módulo es la unidad versionada más pequeña y compartible. Esta contiene la lista exacta de argumentos e implementa la lógica básica para que dicha unidad realice la función requerida. Por ejemplo, [<mark style="color:purple;">terraform-aws-security-group</mark>](https://github.com/terraform-aws-modules/terraform-aws-security-group) crea los recursos `aws_security_group` y `aws_security_group_rule` con base a las entradas -_inputs_-. Este módulo de recurso puede ser utilizado en conjunto con otros módulos para crear un módulo de infraestructura.

El acceso a la información entre moléculas (módulos de recurso e infraestructura) es realizado mediante el uso de salidas -_outputs_- y fuentes de datos -_data sources_-.

El acceso entre composiciones es a menudo realizado utilizando fuentes de datos de estados remotos. Hay [<mark style="color:purple;">múltiples formas de compartir información entre configuraciones</mark>](https://www.terraform.io/language/state/remote-state-data#alternative-ways-to-share-data-between-configurations).

Cuando disponemos los conceptos descritos anteriormente como pseudorelaciones, pueden lucir a como a continuación se muestran:

```
composition-1 { 
  infrastructure-module-1 { 
    data-source-1 => d
  
    resource-module-1 {
      data-source-2 => d2
      resource-1 (d1, d2)
      resource-2 (d2)
    }

    resource-module-2 {
      data-source-3 => d3
      resource-3 (d1, d3)
      resource-4 (d3)
    }
  }
}
```
