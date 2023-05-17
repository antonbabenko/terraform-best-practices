# ಕೋಡ್ ಸ್ಟೈಲಿಂಗ್

{% hint style="info" %}
* ಉದಾಹರಣೆಗಳು ಮತ್ತು ಟೆರಾಫಾರ್ಮ್ ಮಾಡ್ಯೂಲ್‌ಗಳು ಫೀಚರ್ ಗಳನ್ನು ಹೇಗೆ ಬಳಸುವುದು ಎಂಬುದನ್ನು ವಿವರಿಸುವ ಡಾಕ್ಯುಮೆಂಟ್ ಗಳನ್ನು ಹೊಂದಿರಬೇಕು.
* ಟೆರಾಫಾರ್ಮ್ ರಿಜಿಸ್ಟ್ರಿ ವೆಬ್‌ಸೈಟ್ ಅವುಗಳನ್ನು ಸರಿಯಾಗಿ ತೋರಿಸಲು README.md ಫೈಲ್‌ಗಳಲ್ಲಿನ ಎಲ್ಲಾ ಲಿಂಕ್‌ಗಳು ಸಂಪೂರ್ಣವಾಗಿರಬೇಕು.
* ಡಾಕ್ಯುಮೆಂಟೇಷನ್ [mermaid](https://github.com/mermaid-js/mermaid) ರೊಂದಿಗೆ ರಚಿಸಲಾದ ಡೈಗ್ರಾಮ್ ಗಳು ಮತ್ತು [cloudcraft.co](https://cloudcraft.co) ನೊಂದಿಗೆ ರಚಿಸಲಾದ ಬ್ಲೂಪ್ರಿಂಟ್‌ಗಳನ್ನು ಒಳಗೊಂಡಿರಬಹುದು.
* ಕೋಡ್ ಮಾನ್ಯವಾಗಿದೆ, ಸರಿಯಾಗಿ ಫಾರ್ಮ್ಯಾಟ್ ಮಾಡಲಾಗಿದೆ ಮತ್ತು ಅದನ್ನು ಜಿಟ್‌ಗೆ ತಳ್ಳುವ ಮೊದಲು ಸ್ವಯಂಚಾಲಿತವಾಗಿ ದಾಖಲಿಸಲಾಗಿದೆ ಹಾಗು ಇದನ್ನು ಮಾನವರು ಪರಿಶೀಲಿಸಿದ್ದಾರೆ ಎಂದು ಖಚಿತಪಡಿಸಿಕೊಳ್ಳಲು [Terraform pre-commit hooks](https://github.com/antonbabenko/pre-commit-terraform)ಗಳನ್ನು ಬಳಸಿ.
{% endhint %}

## ಡಾಕ್ಯುಮೆಂಟೇಷನ್

### ಸ್ವಯಂಚಾಲಿತವಾಗಿ ರಚಿಸಲಾದ ಡಾಕ್ಯುಮೆಂಟೇಷನ್

[pre-commit](https://pre-commit.com/) ಎನ್ನುವುದು ಬಹು-ಭಾಷಾ pre -commit-hook ಗಳನ್ನು ನಿರ್ವಹಿಸುವ ಚೌಕಟ್ಟಾಗಿದೆ. ಇದು ಪೈಥಾನ್‌ನಲ್ಲಿ ಬರೆಯಲ್ಪಟ್ಟಿದೆ ಮತ್ತು ಕೋಡ್ ಅನ್ನು ಜಿಟ್ ರೆಪೊಸಿಟರಿಗೆ ಕಮಿಟ್ ಮಾಡುವ ಮೊದಲು ಡೆವಲಪರ್‌ನ ಯಂತ್ರದಲ್ಲಿ ಸ್ವಯಂಚಾಲಿತವಾಗಿ ಏನನ್ನಾದರೂ ಮಾಡಲು ಪ್ರಬಲ ಸಾಧನವಾಗಿದೆ. ಸಾಮಾನ್ಯವಾಗಿ, ಇದನ್ನು ಲಿಂಟರ್‌ಗಳು ಮತ್ತು ಫಾರ್ಮ್ಯಾಟ್ ಕೋಡ್ ಅನ್ನು ಚಲಾಯಿಸಲು ಬಳಸಲಾಗುತ್ತದೆ ([supported hooks](https://pre-commit.com/hooks.html) ಗಳನ್ನು ನೋಡಿ).

ಟೆರಾಫಾರ್ಮ್ ಕಾಂಫಿಗುರೇಷನ್ ಗಳೊಂದಿಗೆ`pre-commit` ಅನ್ನು ಕೋಡ್ ಫಾರ್ಮ್ಯಾಟ್ ಮಾಡಲು ಮತ್ತು validate ಮಾಡಲು , ಹಾಗೆಯೇ ಡಾಕ್ಯುಮೆಂಟೇಷನ್ ನವೀಕರಿಸಲು ಬಳಸಬಹುದು.

ಅದರೊಂದಿಗೆ ನೀವು ಚಿರ-ಪರಿಚಿತರಾಗಲು  [pre-commit-terraform repository](https://github.com/antonbabenko/pre-commit-terraform/blob/master/README.md)ಯನ್ನೂ ಹಾಗು ಇದನ್ನು ಬಳಸಲಾದ, ಈಗಾಗಲೇ ಅಸ್ತಿತ್ವದಲ್ಲಿರುವ ರೆಪೊಸಿಟರಿಗಳನ್ನೂ (ಉದಾ, [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc)) ಪರಿಶೀಲಿಸಿ.

### ಟೆರ್ರಾಫಾರ್ಮ್-ಡಾಕ್ಸ್(terraform-docs)

[terraform-docs](https://github.com/segmentio/terraform-docs) ಎನ್ನುವುದು ವಿವಿಧ ಔಟ್‌ಪುಟ್ ಫಾರ್ಮ್ಯಾಟ್‌ಗಳಲ್ಲಿ ಟೆರಾಫಾರ್ಮ್ ಮಾಡ್ಯೂಲ್‌ಗಳಿಂದ ಡಾಕ್ಯುಮೆಂಟೇಷನ್ ಅನ್ನು ಉತ್ಪಾದಿಸುವ ಸಾಧನವಾಗಿದೆ. ನೀವು ಅದನ್ನು ಮಾನ್ಯುಯಲ್ ಆಗಿ ಚಲಾಯಿಸಬಹುದು (ಪೂರ್ವ-ಕಮಿಟ್ ಕೊಕ್ಕೆಗಳಿಲ್ಲದೆ), ಅಥವಾ ಸ್ವಯಂಚಾಲಿತವಾಗಿ ನವೀಕರಿಸಲು [pre-commit-terraform hooks](https://github.com/antonbabenko/pre-commit-terraform) ಗಳನ್ನು ಬಳಸಬಹುದು.

@todo: Document module versions, release, GH actions

## ಸಂಪನ್ಮೂಲಗಳು

1. [pre-commit framework homepage](https://pre-commit.com/)
2. [Collection of git hooks for Terraform to be used with pre-commit framework](https://github.com/antonbabenko/pre-commit-terraform)
3. ಬ್ಲಾಗ್ ಪೋಸ್ಟ್ [Dean Wilson](https://github.com/deanwilson)ಅವರಿಂದ: [pre-commit hooks and terraform - a safety net for your repositories](https://www.unixdaemon.net/tools/terraform-precommit-hooks/)
