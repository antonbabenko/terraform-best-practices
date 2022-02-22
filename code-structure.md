# Struktura kodu

Pytania dotyczące struktury kodu są zdecydowanie najczęściej zadawanymi w społeczności Terraform. W pewnym momencie każdy zaczyna się zastanawiać co dla projektu będzie najlepsze.

## Jak powinienem uporządkować moje konfiguracje Terraform?

To jedno z pytań, na które jest wiele odpowiedzi, lecz bardzo trudno jest udzielić uniwersalnych porad, więc postarajmy się zacząć od zrozumienia z czym mamy do czynienia.

* Jaka jest złożoność Twojego projektu?
  * Liczba powiązanych zasobów
  * Liczba użytych dostawców Terraform (uwaga — patrz poniżej na temat „dostawców logicznych” (logical providers))
* Jak często zmienia się Twoja infrastruktura?
  * **Zaczynając od** raz w miesiącu/tygodniu/codziennie
  * **Skończywszy na** ciągłym (za każdym razem, gdy pojawia się nowa zmiana (commit))
* Kto lub co zmienia kod? _Czy pozwalasz serwerowi CI aktualizować repozytorium po zbudowaniu nowego artefaktu?_
  * Tylko programiści mogą wysyłać kod do repozytorium infrastruktury
  * Każdy może proponować zmiany, otwierając pull-requesty (w tym automatyczne zadania uruchomione na serwerze CI)
* Z jakiej platformy lub usługi wdrożeniowej korzystasz?
  * AWS CodeDeploy, Kubernetes czy OpenShift wymagają nieco innych podejść
* Jak grupowane są środowiska?
  * Według środowiska, regionu, projektu

{% hint style="info" %}
Dostawcy logiczni (logical providers) działają w całości w ramach logiki Terraform i bardzo często nie wchodzą w interakcję z żadnymi innymi usługami, więc możemy myśleć o ich złożoności jako _O(1)_. Najpopularniejszymi dostawcami logicznymi są [random](https://registry.terraform.io/providers/hashicorp/random/latest/docs), [local](https://registry.terraform.io/providers/hashicorp/local/latest/docs), [terraform](https://www.terraform.io/docs/providers/terraform/index.html), [null](https://registry.terraform.io/providers/hashicorp/null/latest/docs), [time](https://registry.terraform.io/providers/hashicorp/time/latest).
{% endhint %}

## Rozpoczęcie pracy z odpowiednim podejściem do struktury projektu w Terraform

Umieszczenie całego kodu w pliku `main.tf` jest dobrym pomysłem, jeśli dopiero zaczynasz swoją przygodę z Terraform lub piszesz testowy kod, aby coś zweryfikować. We wszystkich innych przypadkach lepiej będzie mieć kilka plików podzielonych logicznie w następujący sposób:

* `main.tf` — wywoływanie modułów, zmienny lokalnych i źródeł danych w celu utworzenia wszystkich zasobów
* `variables.tf` — zawiera deklaracje zmiennych używanych w `main.tf`
* `outputs.tf` — zawiera dane wyjściowe z zasobów utworzonych w `main.tf`
* `versions.tf` — zawiera wymagania dotyczące wersji dla Terraform i dostawców

Plik `terraform.tfvars` nie powinien być używany poza [kompozycją](key-concepts.md#kompozycja-composition).

## Jak myśleć o strukturze konfiguracji Terraform?

{% hint style="info" %}
Upewnij się, że rozumiesz kluczowe pojęcia — [moduł zasobu](key-concepts.md#modul-zasobu-resource-module), [moduł infrastruktury](key-concepts.md#modul-infrastruktury-infrastructure-module) i [kompozycja](key-concepts.md#kompozycja-composition), gdyż są one używane w poniższych przykładach.
{% endhint %}

### Popularne wskazówki dotyczące strukturyzowania kodu

* Łatwiej i szybciej pracuje się z mniejszą liczbą zasobów
  * komendy `terraform plan` i `terraform apply` wykonują wywołania API, aby zweryfikować status zasobów
  * Jeśli masz całą infrastrukturę w jednej kompozycji, może to zająć trochę czasu
* Promień rażenia jest mniejszy przy mniejszej ilości zasobów
  * Odizolowanie od siebie niepowiązanych zasobów poprzez umieszczenie ich w oddzielnych kompozycjach zmniejsza ryzyko, jeśli coś pójdzie nie tak
* Rozpocznij swój projekt od użycia stanu zdalnego (remote state), ponieważ:
  * Twój laptop nie jest odpowiednim miejscem na źródło prawdy (source of truth) o Twojej infrastrukturze
  * Zarządzanie plikiem `tfstate` w repozytorium git to koszmar
  * Później, gdy warstwy infrastruktury zaczną rosnąć w wielu kierunkach (liczba zależności lub zasobów) łatwiej będzie mieć wszystko pod kontrolą
* Ćwicz pisanie spójnej struktury i praktykuj zachowywanie konwencji nazewnictwa:
  * Podobnie jak przy kodzie proceduralnym, kod Terraform powinien być napisany tak, aby w pierwszej kolejności mogli go przeczytać ludzie. Zachowanie porządku pomoże, kiedy trzeba będzie wrócić do zmian sprzed pół roku.
  * Przenoszenie zasobów w pliku stanu Terraform jest możliwe, ale może to być trudniejsze, jeśli masz niespójną strukturę i nazewnictwo
* Zachowaj moduły zasobów tak proste, jak to możliwe
* Nie "hardkoduj" wartości, które mogą być przekazywane jako zmienne lub uzyskane przy użyciu źródeł danych
* Użyj źródeł danych i `terraform_remote_state` jako łącznika między modułami infrastruktury w kompozycji

W tej książce przykładowe projekty są pogrupowane według _złożoności_ — od małych do bardzo dużych infrastruktur. Ten podział nie jest ścisły, więc sprawdź, jak robią to inni.

### Orkiestracja modułów i kompozycji infrastruktury

Posiadanie małej infrastruktury oznacza, że istnieje niewielka liczba zależności i niewiele zasobów. Wraz z rozwojem projektu pojawia się potrzeba łączenia wykonywania konfiguracji Terraform. Łączenia różnych modułów infrastruktury i przekazywanie wartości w ramach kompozycji staje się oczywistym następstwem.

Istnieje co najmniej 5 odrębnych grup rozwiązań do orkiestracji, z których korzystają programiści\_stki:

1. Czysty Terraform. Bardzo proste rozwiązanie. Programiści\_stki muszą znać tylko Terraform, aby wykonać zadanie.
2. Terragrunt. Narzędzie, którego można użyć do orkiestracji całej infrastruktury, a także obsługi zależności. Terragrunt działa natywnie z modułami infrastruktury i kompozycjami, dzięki czemu ogranicza powielanie kodu.
3. Skrypty wewnętrzne. Często używane jako punkt startowy do używania orkiestracji oraz przed odkryciem Terragrunt.
4. Ansible lub inne narzędzie ogólnego przeznaczenia do automatyzacji. Zwykle wybierane rozwiązanie, gdy Terraform jest używany po implementacji Ansible lub gdy aktywnie używany jest interfejs użytkownika Ansible.
5. [Crossplane](https://crossplane.io) i inne rozwiązania inspirowane Kubernetes. Czasami sensowne jest wykorzystanie ekosystemu Kubernetes i zastosowanie pętli uzgadniania (reconciliation loop), aby osiągnąć pożądany stan konfiguracji Terraform. Obejrzyj film [Crossplane vs Terraform](https://www.youtube.com/watch?v=ELhVbSdcqSY), aby uzyskać więcej informacji.

Mając to wszystko na uwadze — ta książka zawiera przegląd pierwszych dwóch z struktur projektowych — tylko Terraform i Terragrunt.

Zobacz przykłady struktur kodu dla [Terraform](examples/terraform/) lub [Terragrunt](examples/terragrunt.md) w następnym rozdziale.
