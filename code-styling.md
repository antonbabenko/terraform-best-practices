# Estilo del código



{% hint style="info" %}


* Los ejemplos y módulos de Terraform deberían integrar documentación que describa sus funcionalidades y el cómo utilizarlas.
* Enlaces en el sitio web del Terraform Registry son relevantes y no funcionarán, así que hacer uso de rutas absolutas en el README.md.
* La documentación puede incluir diagramas creados con [<mark style="color:purple;">mermaid</mark>](https://github.com/mermaid-js/mermaid) **** y planos creados con [<mark style="color:purple;">cloudfcraft.co</mark>](https://www.cloudcraft.co).
* Hacer uso de los **** [<mark style="color:purple;">hooks de pre-commit de Terraform</mark>](https://github.com/antonbabenko/pre-commit-terraform) **** para asegurarse de que el código es válido, de que está en el formato adecuado y está documentado adecuadamente antes de que sea _pusheado_ a git y revisado por una persona.\

{% endhint %}

### **Documentación**

#### **Documentación generada automáticamente**

[<mark style="color:purple;">pre-commit</mark>](https://pre-commit.com) **** es un marco de trabajo **-**_framework_- para administrar y mantener hooks de precommit multi lenguaje. Está escrito en Python y es una herramienta potente para hacer algo de manera automática en la máquina del desarrollador antes de que el código sea _commiteado_ al repositorio de git. Normalmente, es utilizado para ejecutar _linters_ y formatear código (ver [<mark style="color:purple;">hooks soportados</mark>](https://pre-commit.com/hooks.html)).

Con las configuraciones de Terraform, el `pre-commit` puede ser utilizado para formatear y validar código, así como actualizar documentación.

Se recomienda revisar el [<mark style="color:purple;">repositorio de pre-commit-terraform</mark>](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md) para la familiarización con el mismo, y con otros repositorios existentes (por ejemplo, [<mark style="color:purple;">terraform-aws-vpc</mark>](https://github.com/terraform-aws-modules/terraform-aws-vpc)) en donde está siendo utilizado.

@porhacer: Documentar versiones de módulos, liberaciones, GH Actions.

### Recursos

1\. <mark style="color:purple;"></mark> [<mark style="color:purple;">Página principal de pre-commit</mark>](https://pre-commit.com).

2\. [<mark style="color:purple;">Colección de git hooks para Terraform a ser usados con el framework pre-commit</mark>](https://github.com/antonbabenko/pre-commit-terraform).

3\. Publicación de blog por [<mark style="color:purple;">Dean Wilson: hooks de pre-commit y terraform – una red segura para tus repositorios</mark>](https://www.unixdaemon.net/tools/terraform-precommit-hooks/).
