---
description: PFT (Problemas Frecuentes de Terraform)
---

# Preguntas y respuestas frecuentes

### ¿Cuáles son las herramientas que debería tener en cuenta y considerar utilizar?

* [<mark style="color:purple;">**Terragrunt**</mark>](https://terragrunt.gruntwork.io) - herramienta de orquestación.
* [<mark style="color:purple;">**tflint**</mark>](https://github.com/terraform-linters/tflint) <mark style="color:purple;"></mark> - linter de código.
* [<mark style="color:purple;">**tfenv**</mark>](https://github.com/tfutils/tfenv) - gestor de versiones.
* [<mark style="color:purple;">**Atlantis**</mark>](https://www.runatlantis.io) - automaticación de Pull Request.
* [<mark style="color:purple;">**pre-commit-terraform**</mark>](https://github.com/antonbabenko/pre-commit-terraform) <mark style="color:purple;"></mark> - Colección de hooks de git para Terraform a usar con [<mark style="color:purple;">pre-commit framework</mark>](https://pre-commit.com).
* [<mark style="color:purple;">**Infracost**</mark>](https://www.infracost.io/) - Cloud estima los costes de Terraform mediante un sistema de extraccion y trabaja con Terragrunt, Atlantis y Terraform pre-cometido

### ¿Has tenido la oportunidad de responder a la pregunta anterior?&#x20;

Sí, después de unos meses finalmente encontramos la respuesta. Lamentablemente, Mike está de vacaciones, así que me temo que no podemos dar la respuesta en este momento.

### **¿Cuál es la solución al** [<mark style="color:purple;">**dependency hell**</mark>](https://en.wikipedia.org/wiki/Dependency\_hell) **-**_**infierno de las dependencias**_**- con los módulos?**

Las versiones de los recursos y los módulos de la infraestructura deben ser especificados. Los proveedores deben ser configurados fuera de los módulos, solamente en la composición. Las versiones de los proveedores y Terraform también se pueden bloquear.

No hay una herramienta de gestión de dependencias maestra pero, hay varios tips para hacer el _dependency hell_ menos problemático. Por ejemplo, [<mark style="color:purple;">**Dependabot**</mark>](https://github.com) <mark style="color:purple;">****</mark> puede ser utilizado para automatizar la actualización de dependencias. Dependabot crea _pull requests_ para mantener las dependencias seguras y actualizadas al día. Dependabot soporta configuraciones de Terraform.
