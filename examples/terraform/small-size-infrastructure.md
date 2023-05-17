# ಸಣ್ಣ ಗಾತ್ರದ infrastructure ಟೆರಾಫಾರ್ಮ್ ನೊಂದಿಗೆ

ಮೂಲ: [https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform](https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform)

ಈ ಉದಾಹರಣೆಯು ಸಣ್ಣ-ಗಾತ್ರದ infrastructure ಗಾಗಿ ಟೆರಾಫಾರ್ಮ್ ಕಾಂಫಿಗುರೇಷನ್ ಗಳನ್ನು ರಚಿಸುವ ಕೋಡ್ ಅನ್ನು ಒಳಗೊಂಡಿದೆ, ಅಲ್ಲಿ ಯಾವುದೇ ಬಾಹ್ಯ ಅವಲಂಬನೆಗಳನ್ನು ಬಳಸಲಾಗಿಲ್ಲ .

{% hint style="success" %}
* ಪ್ರಾರಂಭಿಸಲು ಉತ್ತಮ ಹಾಗು ಮುಂದುವರಿಸುತ್ತಿದ್ದಂತೆಯೇ ಮರು -ಪರಿಶೀಲಿಸಬಹುದು
* ಸಣ್ಣ ಸಂಪನ್ಮೂಲ ಮಾಡ್ಯೂಲ್‌ಗಳಿಗೆ ಉತ್ತಮ
* ಸಣ್ಣ ಮತ್ತು ಲೀನಿಯರ್ infrastructure ಮಾಡ್ಯೂಲ್‌ಗಳಿಗೆ ಉತ್ತಮವಾಗಿದೆ (ಉದಾ, [terraform-aws-atlantis](https://github.com/terraform-aws-modules/terraform-aws-atlantis))
* ಸಣ್ಣ ಸಂಖ್ಯೆಯ ಸಂಪನ್ಮೂಲಗಳಿದ್ದಾಗ ಒಳ್ಳೆಯದುಸಣ್ಣ ಸಂಖ್ಯೆಯ ಸಂಪನ್ಮೂಲಗಳಿದ್ದಾಗ ಒಳ್ಳೆಯದು (20-30ಗಿಂತ ಕಡಿಮೆ)
{% endhint %}

{% hint style="warning" %}
ಸಂಪನ್ಮೂಲಗಳ ಸಂಖ್ಯೆಯು ಹೆಚ್ಚಿದ್ದಾಗ , ಎಲ್ಲಕ್ಕೂ ಸೇರಿ ಒಂದೇ ಸಿಂಗಲ್ -ಸ್ಟೇಟ್ ಫೈಲ್ ಇದ್ದರೆ, ಟೆರಾಫಾರ್ಮ್‌ನೊಂದಿಗೆ ಕೆಲಸ ಮಾಡುವ ಪ್ರಕ್ರಿಯೆಯನ್ನು ನಿಧಾನಗೊಳಿಸುತ್ತದೆ (ಸಂಪನ್ಮೂಲಗಳ ಸಂಖ್ಯೆಯನ್ನು ಮಿತಿಗೊಳಿಸಲು `-target` ಎಂಬ ಆರ್ಗ್ಯುಮೆಂಟ್ ಬಳಸುವುದನ್ನು ಪರಿಗಣಿಸಿ)
{% endhint %}
