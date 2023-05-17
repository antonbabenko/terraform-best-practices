# კოდის სტილი

{% hint style="info" %}


* ტერაფორმის მოდულები და მაგალითები უნდა შეიცავდეს დოკუმენტაციას, ფუნქციონალების გამოყენების შესახებ.
* ყველა ბმული README.md ფაილებში უნდა იყოს სრული, რათა Terraform Registry ვებსაიტმა ისინი აჩვენოს სწორად.
* დოკუმენტაცია შესაძლოა მოიცავდეს mermaid-ით შექმნილ დიაგრამებს და [cloudcraft.co](http://cloudcraft.co/)-ით შექმნილ blueprint-ებს.
* იმისათვის რომ დავრწმუნდეთ კოდის არის ვალიდური, სათანადო ფორმატში და ავტომატურად დოკუმენტირებული, უნდა გამოვიყენოთ Terraform pre-commit hooks, სანამ კოდი გადავა Git-ზე და გახდება საჯარო.
{% endhint %}

## დოკუმენტაცია

### ავტომატურად გენერირებული დოკუმენტაცია&#x20;

[pre-commit](https://pre-commit.com/) არის ფრეიმვორქი მრავალენოვანი pre-commit hooks-ების სამართავად და შესანარჩუნებლად. ის დაწერილია python-ზე და არის ძლიერი ხელსაწყო დეველოპერების კომპიუტერებზე კოდის git რეპოზიტორიაში გადატანამდე მოხდეს შემოწმება typo-ებზე. ჩვეულებრივ, ის გამოიყენება linter-ების გასაშვებად და კოდის ფორმატირებისთვის (იხილეთ [supported hooks](https://pre-commit.com/hooks.html)).

ტერაფორმის კონფიგურაციით `pre-commit` შეიძლება გამოყენებულ იქნას კოდის ფორმატირებისა და ვალიდაციისთვის, ასევე დოკუმენტაციის განახლებისთვის.

შეამოწმეთ [pre-commit-terraform repository](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md) და უკვე არსებული საცავები, რათა უკეთესად გაიგოთ მისი არსი.

### terraform-docs

[terraform-docs](https://github.com/segmentio/terraform-docs) არის ხელსაწყო, რომლის მეშვეობითაც ტერაფორმის მოდულებიდან გენერირდება დოკუმენტაცია სხვადასხვა ფორმატში. შეგიძლიათ ის გაუშვათ მანუალურად (pre-commit hooks-ის გამოყენების გარეშე) ან გამოიყენოთ [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform) თუ გსურთ რომ დოკუმენტაცია განახლდეს ავტომატურად.

@todo: Document module versions, release, GH actions

## რესურსები

1. [pre-commit framework homepage](https://pre-commit.com/)
2. [Collection of git hooks for Terraform to be used with pre-commit framework](https://github.com/antonbabenko/pre-commit-terraform)
3. Blog post by [Dean Wilson](https://github.com/deanwilson): [pre-commit hooks and terraform - a safety net for your repositories](https://www.unixdaemon.net/tools/terraform-precommit-hooks/)
