# ძირითადი ცნებები

ოფიციალური Terraform დოკუმენტაცია აღწერს [კონფიგურაციის ყველა ასპექტს დეტალებში](https://www.terraform.io/docs/configuration/index.html). გაეცანით ყურადღებით რათა ადვილად გაიგოთ შემდეგი თემები.

ეს სექცია შეიცავს ძირითად ცნებებს რომლებიც გამოიყენება წიგნში.

## რესურსი (Resource)

Resource(რესურსი) არის `aws_vpc`, `aws_db_instance`და ა.შ. ყოველი რესურსი მიეკუთვნება განსაზღვრულ პროვაიდერს, ენიჭება არგუმენტები, აბრუნებს ატრიბუტებს (შემდეგში outputs) და გააჩნია სასიცოცხლო ციკლი(lifecycle). რესურსი შეიძლება შეიქმნას, მოძიებულ იქნას, განახლდეს ან წაიშალოს.

## მოდულის რესურსი (Resource module)

Resource module არის ერთმანეთთანფ დაკავშირებული რესურსების ერთობლიობა რომელიც ჯამურად ქმნის მოქმედებას (მაგ.: [AWS VPC Terrafor](https://github.com/terraform-aws-modules/terraform-aws-vpc/) მოდული ქმნის VPC, subnets, NAT gateway და ა.შ.). ეს დამოკიდებულია პროვაიდერის კონფიფურაციაზე, შესაძლოა თუ არა ეს რესურსები განსაზღვრულ იქნას მოდულის ფარგლებში ან უფრო მაღალი დონის სტრუქტურაში (მაგ.: ინფრასტრუქტურის მოდულში).

## ინფრასტრქუტურის მოდული (Infrastructure module)

ინფრასტუქტურის მოდული არის რესურსების ერთობლიობა, რომლებიც შეიძლება ლოგიკურად ერთმანეთთად კავშირში არ იყვნენ, თუმცა კონკრეტული შემთხვევაში/პროქტში/კონფიგურაციაში ერთსა და იმავე საქმეს ემსახურებოდნენ. ის აღწერს კონფიგურაციას პროვაიდერისთვის, რომელიც შემდეგ გადაეცემა ქვედა დონის მოდულის რესურსებსა და რესურსებს. როგორც წესი ის შემოიფარგლება მხოლოდ ერთ ერთეულში თითოეული ლოგიკურ პროცესორზე (მაგ: AWS Region, Google Project).

მაგალითად, [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis/) მოდული იყენებას ისეთ რესურსებს როგორებიცაა [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc/) და [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group/) რათა მართოს ინფრასტრუქტურა რომელიც საჭიროა [Atlantis](https://www.runatlantis.io)-ის გასაშვებად [AWS Fargate](https://aws.amazon.com/fargate/)-ზე.

კიდევ ერთი მაგალითი გახლავთ [terraform-aws-cloudquery](https://github.com/cloudquery/terraform-aws-cloudquery) მოდული, სადაც რამოდენიმე  [terraform-aws-modules](https://github.com/terraform-aws-modules/) მოდული გამოიყენება ერთდროულად რომ მართონ ინფრასტრუქტურა ისეთივე წარმატებით როგორც მაგალითად Docker-ის რესურსები გამოიყენება build, push, და  deploy ოპერაციებისთვის.

## კომპოზიცია (Composition)

კომპოზიცია არის ინფრასტრუქტურის მოდულების ერთობლიობა, რომლებიც შეიძლება მოიცავდეს ლოგიკურად გაყოფილ ზონებს (მაგ.: AWS Regions, several AWS accounts). კომპოზიცია გამოიყენება სრული ინფრასტრუქტურის აღსაწერად მთელი ორგინაზაციისთვის ან პროქტისთვის.

კომპოზიცია შედგება ინფრასტრუქტურის მოდულებისგან, რომელიც შედგება რესურსის მოდულებისგან, რომელიც შედგება ინდივიდუალური რესურსებისგან.

![Simple infrastructure composition](.gitbook/assets/composition-1.png)

## მონაცემთა წყარო (Data source)

მონაცემთა წყარო ასრულებს read-only ოპერაციას და დამოკიდებულია პროვაიდერის კონფიგურაციაზე, ის გამოიყენება რესურსის და ინფრასტრუქტურის მოდულებში.

მონაცემთა წყარო `terraform_remote_state` ასრულებს დამაკავშირებელ ფუნქციას ზედა დონის მოდულებსა და კომპოზიციებს შორის.

[External](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data\_source) მონაცემთა წყარო გარე პროგრამებს აძლევს საშუალებას შეასრულონ მონაცემთა წყაროს როლი, მოწოდებული ინფორმაცია კი გამოიყენოთ Terraform კონფიგურაციაში. მაგალითი [terraform-aws-lambda module](https://github.com/terraform-aws-modules/terraform-aws-lambda/blob/258e82b50adc451f51544a2b57fd1f6f8f4a61e4/package.tf#L5-L7)-დან სადაც ფაილის სახელი (filename) გენერირდება გამოძახებული Python script-ის გამოყენებით.

[http](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) მონაცემთა წყარო აკეთებს HTTP GET მოთხოვნას მოცემულ URL-ზე და ახორციელებს ინფორმაციის ექსპორტს პასუხის შესახებ, რომელიც ხშირად სასარგებლოა ინფორმაციის მისაღებად ბოლო წერტილებიდან, სადაც Terraform-ის ადგილობრივი პროვაიდერი არ არსებობს.

## Remote state&#x20;

ინფრასტრუქტურული მოდულები და კომპიზიციები უნდა ინახავდნენ [Terraform state](https://www.terraform.io/docs/language/state/index.html)-ს მოშორებულ(Remote) ადგილას რაც სხვა Terraform-ის მომხმარებლებს მისცემს საშუალებას ჰქონდეთ წვდომა და შეძლონ გუნდური/კონტროლირებადი მუშაობა (მაგ. მიუთითე ACL, versioning, logging).

## Provider, provisioner, etc

Providers, provisioners, და სხვა ტერმინები არის ძალიან კარგად აღწერილი ოფიციალურად დოკუმენტაციაში. ჩემი აზრით არ არის აუცილებლობა აქვს ამ აღწერის აქ გამეორებას და მათ ნაკლები საერთო აქვთ Terraform-ის კარგ მოდულების წერასთან.

## რატომ ასე რთულად?

როდესაც ცაკლეული რესურსები ჰგვანან ატომებს ინფრასტრუქტურაში, რესურსის მოდულები არიან მოლეკულები (ატომებისგან შემდგარი). მოდული არის ყველაზე პატარა ვერსიონირებადი და გაზიარებადი ერთეული. მას გააჩნია არგუმენტების ზუსტი სია, მას აქვს არგუმენტების ზუსტი სია, განახორციელოს ძირითადი ლოგიკა ასეთი ერთეულისთვის საჭირო ფუნქციის შესასრულებლად. მაგალითად [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group) მოდული ქმნის  `aws_security_group` და `aws_security_group_rule` რესურსებს input-ზე დაფუძნებით. ეს რესურს მოდული თავისთავად შესაძლოა გამოიყენოთ სხვა მოდულთან ერთობლიობაში ახალი ინფრასტრუქტურის მოდულის შესაქმნელად.&#x20;

მოლეკულებს (რესურს და ინფრასტრუქტურის) შორის მონაცემთა გაცვლა ხორციელდება მოდულების, Outputs-ების და მონაცემთა წყაროების მეშვეობით.

კომპოზიციებს შორის წვდომა ხშირად ხორციელდება remote state მონაცემთა წყაროების მეშვეობით. არსებობს [მონაცემთა გაზიარების სხვადასხვა გზები](https://www.terraform.io/docs/language/state/remote-state-data.html#alternative-ways-to-share-data-between-configurations).&#x20;

ზემოაღწერილი ცნებების ფსევდო-კავშირებში ჩასმისას შეიძლება ასე გამოიყურებოდეს:&#x20;

```
composition-1 {
  infrastructure-module-1 {
    data-source-1 => d1

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
