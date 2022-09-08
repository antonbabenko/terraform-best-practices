# Infrastructură de dimensiune mare - Terraform

Sursă: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/large-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/large-terraform)

Acest exemplu conține un cod ca exemplu de structurare a configuraților Terraform pentru o infrastructură de dimensiuni mari care folosește:

* 2 conturi AWS&#x20;
* 2 regiuni
* 2 medii de lucru separate (`prod` și `stage` care nu au procese comune). Fiecare mediu de lucru există într-un cont AWS separat și conține resurse în două regiuni
* Fiecare mediu de lucru folosește o altă versiune a modulelor de infrastructură gata de folosire (`alb`) provenite din [Terraform Registry](https://registry.terraform.io/)
* Fiecare mediu de lucru folosește aceeași versiune a unui modul intern `modules/network` provenind din aceeași sursă locală (local directory)

{% hint style="info" %}
Într-un proiect de dimensiuni mari ca cel descris aici, beneficiile utilizării Terragrunt devin foarte vizibile. Vezi [Exemple de structuri de cod - Terragrunt](../terragrunt.md).
{% endhint %}

{% hint style="success" %}
* Perfect pentru proiecte în care infrastructura este separată logic (conturi AWS separate)
* Potrivit când nu este nevoie de modificarea resurselor partajate între conturile AWS (un mediu de lucru = un cont AWS = un fișier de stare)
* Potrivit când nu este necesară orchestrarea schimbărilor între mediile de lucru
* Potrivit când resursele care formează infrastructura sunt diferite in funcție de mediul de lucru cu un anumit scop și nu poate fi generalizată (ex.: anumite resurse nu există într-un mediu de lucru sau într-o anumită regiune)
{% endhint %}

{% hint style="warning" %}
O dată cu expansiunea proiectului, o să fie din ce în ce mai dificil de păstrat aceste medii de lucru la curent cu fiecare. Considerați folosirea modulelor de infrastructură (gata de folosire sau interne) pentru sarcini repetitive.
{% endhint %}

##
