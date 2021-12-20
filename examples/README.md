# Ejemplos de estructura del código

### Estructuras de código de Terraform

{% hint style="info" %}
Estos ejemplos son presentados con AWS como proveedor pero la mayoría de los principios mostrados en los ejemplos pueden ser aplicados a otros proveedores de nube pública así como a otro tipo de proveedores (DNS, DB, Monitoring, etc).
{% endhint %}

| Tipo                                                                                                                                                                     | Descripción                                                                                                                                                                               | Disponibilidad            |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------- |
| <mark style="color:purple;"></mark>[<mark style="color:purple;">pequeña</mark>](terraform/small-size-infrastructure.md)<mark style="color:purple;"></mark>               | <p>Pocos recursos, sin dependencias externas. Una sola cuenta de AWS.</p><p>Una sola región. Un sólo entorno.</p>                                                                         | Disponible                |
| <mark style="color:purple;">m</mark>[<mark style="color:purple;">ediana</mark>](terraform/medium-size-infrastructure.md)<mark style="color:purple;"></mark>              | Varias cuentas y entornos en AWS, módulos estándar de infraestructura utilizando Terraform.                                                                                               | Disponible                |
| <mark style="color:purple;"></mark>[<mark style="color:purple;">grande</mark>](terraform/large-size-infrastructure-with-terraform.md)<mark style="color:purple;"></mark> | Muchas cuentas de AWS, muchas regiones, necesidad urgente de reducir el copiado y pegado, módulos de infraestructura personalizados, uso intensivo de composiciones utilizando Terraform. | TEP (Trabajo en proceso)  |
| muy grande                                                                                                                                                               | Varios proveedores (AWS, GCP, Azure). Despliegues multi nube utilizando Terraform.                                                                                                        | No Disponible             |

### Estructuras de código de Terraform

| Tipo       | Descripción                                                                                                                                                                                | Disponibilidad |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------- |
| mediana    | Varias cuentas y entornos de AWS, módulos estándar de infraestructura, patrón de composición con Terragrunt.                                                                               | No Disponible  |
| grande     | Muchas cuentas de AWS, muchas regiones, urgente necesidad de reducir el copiado y pegado, módulos de infraestructura personalizados, uso intensivo de composiciones utilizando Terragrunt. | No Disponible  |
| muy grande | Varios proveedores (AWS, GCP, Azure). Despliegues multi nube utilizando Terragrunt.                                                                                                        | No Disponible  |
