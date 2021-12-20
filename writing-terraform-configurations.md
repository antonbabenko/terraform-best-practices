# Escribiendo configuraciones de Terraform

##

### **Uso de locales -**_**locals-**_** para especificar explícitamente dependencias entre los recursos**

Es una manera útil para dar una pista a Terraform de que algunos recursos deberían de ser borrados antes incluso de que no haya una dependencia directa en las configuraciones de Terraform.

<mark style="color:purple;"></mark>[<mark style="color:purple;">https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf</mark>](https://raw.githubusercontent.com/antonbabenko/terraform-best-practices/master/snippets/locals.tf)   <mark style="color:purple;"></mark>  &#x20;

### **Terraform 0.12 – Argumentos Opcionales vs Requeridos**

1\. El argumento requerido `index_document` __ debe ser definido si `var.website` no es un `map` vacío.

2\. El argumento opcional `error_document` puede ser omitido.

> main.tf
>
> ```hcl
> variable "website" {
>   type    = map(string)
>   default = {}
> }
>
> resource "aws_s3_bucket" "this" {
>   # omitted...
>
>   dynamic "website" {
>     for_each = length(keys(var.website)) == 0 ? [] : [var.website]
>
>     content {
>       index_document = website.value.index_document
>       error_document = lookup(website.value, "error_document", null)
>     }
>   }
> }
> ```

> terraform.tfvars
>
> ```hcl
> website = {
>   index_document = "index.html"
> }
> ```
