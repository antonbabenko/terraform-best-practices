---
description: >-
  El presente libro es un intento por describir sistemáticamente las mejores
  prácticas para el uso de Terraform y proveer de recomendaciones a los
  problemas más comunes que experimentan sus usuarios.
---

# ¡Bienvenido!

<mark style="color:purple;">Terraform</mark> es un proyecto relativamente nuevo (como la mayoría de las herramientas DevOps, de hecho) que comenzó en el año 2014.

Terraform es bastante potente (si no es que la herramienta más potente disponible en el mercado actualmente) y una de las herramientas que permiten la administración de infraestructura como código más usadas. Terraform permite a los desarrolladores realizar una gran variedad de cosas pero no los restringe de hacerlas de maneras en las que en un futuro les serán difíciles de integrar o de dar soporte.

Algo de la información descrita tal vez no parezca como parte de las mejores prácticas, lo sé, y para ayudar a los lectores a separar cuáles son las mejores prácticas establecidas y cuáles son sólo otras formas opinadas de hacer las cosas, hago uso de sugerencias para proporcionar algo del contexto e iconos para especificar el nivel de madurez de cada subsección relacionada con las mejores prácticas.

Este libro tuvo su comienzo un día soleado de Madrid del 2018, y se encuentra disponible de manera gratuita en [<mark style="color:purple;">https://www.terraform-best-practices.com/</mark>](https://www.terraform-best-practices.com)

Años después, ha sido actualizado incluyendo a más de las mejores prácticas disponibles para Terraform 1.0. Eventualmente, este libro debería contener la mayoría de las mejores prácticas y recomendaciones indiscutibles para los usuarios de Terraform.

## **Patrocinadores**

Please [contact me](https://github.com/antonbabenko/terraform-aws-devops#social-links) if you want to become a sponsor.

| [![](.gitbook/assets/cast-logo.png)](https://cast.ai/antonbabenko)                                                             | [CAST AI](https://cast.ai/antonbabenko) — Cut your Kubernetes costs by 60%+ on average. First cluster optimization FREE!                                                            |
| ------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [![](.gitbook/assets/speakeasy-logo.png)](https://speakeasyapi.dev?utm_source=tf_best_practices&utm_medium=github+sponsorship) | [Speakeasy](https://speakeasyapi.dev?utm_source=tf_best_practices&utm_medium=github+sponsorship) — Terraform Providers, SDKs and docs for your API. Make your API enterprise-ready! |

## Traducciones

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/u3iITRIHQx97ro2PkfdC/" %}
[العربية (Arabic)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/u3iITRIHQx97ro2PkfdC/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/PJbgKPAX0ohEMLpETpg7/" %}
[Bosanski (Bosnian)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/PJbgKPAX0ohEMLpETpg7/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/" %}
[Português (Brazilian Portuguese)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/B48qUSNPO2XmkIySLzfr/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/e1Mp2scOX6OnQbifCen3/" %}
[English](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/e1Mp2scOX6OnQbifCen3/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/" %}
[Français (French)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/6shyPtr2KrqW4ANbFXYg/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/DyguS0uZfMW7X7m9BWx1/" %}
[ქართული (Georgian)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/DyguS0uZfMW7X7m9BWx1/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/PKopCWJZbhpQ9FT0W8tL/" %}
[Deutsch (German)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/PKopCWJZbhpQ9FT0W8tL/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/5c1kFpqxaDZC2g9e6rtT/" %}
[ελληνικά (Greek)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/5c1kFpqxaDZC2g9e6rtT/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/4bq6CyY8vYiEHkjN63rT/" %}
[עברית (Hebrew)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/4bq6CyY8vYiEHkjN63rT/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/Mgong4S6IjtibE055zUM/" %}
[हिंदी (Hindi)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/Mgong4S6IjtibE055zUM/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/" %}
[Bahasa Indonesia (Indonesian)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/ZLCz7lNWbSJxDGuNOI44/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/8VlMHbHDbW6qRWdgN5oU/" %}
[Italiano (Italian)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/8VlMHbHDbW6qRWdgN5oU/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/BoZVs6O2OJFQLNV1utmm/" %}
[ಕನ್ನಡ (Kannada)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/BoZVs6O2OJFQLNV1utmm/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/bJnDvAqIyVgo7LDHgxYJ/" %}
[한국어 (Korean)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/bJnDvAqIyVgo7LDHgxYJ/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/" %}
[Polski (Polish)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/9yChMGbFo2G47Wiow1yY/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/sFM1GW5TPCGsskQ03mTm/" %}
[Română (Romanian)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/sFM1GW5TPCGsskQ03mTm/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/5VD4NK4mHOY8SWjC9N5e/" %}
[简体中文 (Simplified Chinese)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/5VD4NK4mHOY8SWjC9N5e/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/Fedpbc5NbKjynXI8xTeF/" %}
[Türkçe (Turkish)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/Fedpbc5NbKjynXI8xTeF/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/" %}
[Українська (Ukrainian)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/tXRvMPILxeJaJTM2CsSq/)
{% endcontent-ref %}

{% content-ref url="http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/dcjhau04KQIKHUJA90iN/" %}
[اردو (Urdu)](http://127.0.0.1:5000/o/-LMqIrDlzEiI-N4uHrWg/s/dcjhau04KQIKHUJA90iN/)
{% endcontent-ref %}

Contáctame ([<mark style="color:purple;">email</mark>](mailto:anton@antonbabenko.com) o [<mark style="color:purple;">twitter</mark>](https://twitter.com/antonbabenko)) si te gustaría traducirlo.

## **Contribuciones**

Siempre quiero recibir comentarios y actualizar este libro a medida que la comunidad madura y se implementan y verifican nuevas ideas con el tiempo.

Si estás interesado en ciertos temas, por favor, [<mark style="color:purple;">abre un issue</mark>](https://github.com/antonbabenko/terraform-best-practices/issues), o bien, da tu pulgar arriba en aquel te gustaría que cubriéramos más. Si crees que cuentas con contenido para incluir y te gustaría contribuir, escribe un borrador y envía una pull-request (¡no te preocupes por tener que escribir un buen texto!).

## **Autores**

Este libro es mantenido por [<mark style="color:purple;">Anton Babenko</mark>](https://github.com/antonbabenko) con la ayuda de varios contribuidores y traductores. Su versión al español es traducida por [<mark style="color:purple;">Abel López</mark>](https://www.linkedin.com/in/abelopz/).

## **Licencia**

El presente trabajo es licenciado bajo la Licencia Apache 2. Ver LICENCIA para detalles completos.

Los autores y contribuidores de este contenido no garantizan la validez de la información aquí encontrada. Favor de asegurarse de que se sobreentiende que la información proveída se provee de manera gratuita, y no es creado ningún tipo de acuerdo o contrato entre usted y las personas asociadas con el contenido de este proyecto. Los autores y contribuidores no asumen y, por la presente, renuncian a cualquier responsabilidad ante cualquier parte por cualquier pérdida, daño o interrupción causada por errores u omisiones en la información contenida, asociada o vinculada a este contenido, ya sea que dichos errores u omisiones sean el resultado de negligencia, accidente ocualquier otra causa.

Derechos de autor © 2018-2023 Anton Babenko.
