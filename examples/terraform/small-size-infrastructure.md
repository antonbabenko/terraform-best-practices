# მცირე ზომის ინფრასტრუქტურა  Terraform-ით

წყარო: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

ეს Terraform კოდის სტრუქტურის მაგალითი განკუთვნილია მცირე ზომის ინფრასტრუქტურისთვის რომელიც იყენებს შემდეგ კომპონენტებს:

მაგალითი შეიცავს კოდს, როგორც Terraform-ის კონფიგურაციის სტრუქტურირების მაგალითს მცირე ზომის ინფრასტრუქტურისთვის, სადაც არ არის გამოყენებული გარე დამოკიდებულებები(Dependencies).

{% hint style="success" %}
* შესანიშნავია დასაწყებად და რეფაქტირებისთვის
* შესანიშნავია მცირე რესურსის მოდულებისთვის
* კარგია მცირე და ხაზოვანი ინფრასტრუქტურის მოდულებისთვის (მაგალითად [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis))
* კარგია მცირე რაოდენობის რესურსებისთვის (20-30-ზე ნაკლები)
{% endhint %}

{% hint style="warning" %}
ყველა რესურსისთვის საერთო მდგომარეობის(State) ფაილს შეუძლია Terraform-თან მუშაობის პროცესი შეანელოს, თუ რესურსების რაოდენობა იზრდება (განიხილეთ `-target`არგუმენტის გამოყენება სამიზნე რესურსების რაოდენობის შესაზღუდად)
{% endhint %}
