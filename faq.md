---
description: FTP (Frequent Terraform Problems)
---

# सामान्य प्रश्न

## मुझे किन उपकरणों के बारे में पता होना चाहिए और उनका उपयोग करने पर विचार करना चाहिए?

* [**Terragrunt**](https://terragrunt.gruntwork.io/) - Orchestration tool (ऑर्केस्ट्रेशन टूल)
* [**tflint**](https://github.com/terraform-linters/tflint) - Code linter (कोड लिंटर)
* [**tfenv**](https://github.com/tfutils/tfenv) - Version manager (संस्करण प्रबंधक)
* [**Atlantis**](https://www.runatlantis.io/) - Pull Request automation (पुल अनुरोध स्वचालन)
* [**pre-commit-terraform**](https://github.com/antonbabenko/pre-commit-terraform) - उपयोग किए जाने वाले टेराफॉर्म के लिए गिट हुक का संग्रह [pre-commit framework](https://pre-commit.com/)
* [**Infracost**](https://www.infracost.io) - टेराफॉर्म इन पुल अनुरोधों के लिए क्लाउड लागत अनुमान। Terragrunt, Atlantis और  pre-commit-terraform के साथ भी काम करता है.

## मॉड्यूल के साथ  [dependency hell](https://en.wikipedia.org/wiki/Dependency\_hell) के समाधान क्या हैं?&#x20;

संसाधन और आधारभूत संरचना मॉड्यूल के संस्करण निर्दिष्ट किए जाने चाहिए। प्रदाताओं को मॉड्यूल के बाहर कॉन्फ़िगर किया जाना चाहिए, लेकिन केवल संरचना में। प्रदाताओं के संस्करण और टेराफॉर्म को भी लॉक किया जा सकता है।

कोई मास्टर निर्भरता प्रबंधन उपकरण नहीं है, लेकिन निर्भरता विनिर्देशों को कम समस्याग्रस्त बनाने के लिए कुछ सुझाव हैं। उदाहरण के लिए, [Dependabot](https://dependabot.com/) निर्भरता अद्यतनों को स्वचालित करने के लिए उपयोग किया जा सकता है। Dependabot आपकी निर्भरताओं को सुरक्षित और अद्यतित रखने के लिए पुल अनुरोध बनाता है। डिपेंडाबॉट टेराफॉर्म कॉन्फ़िगरेशन का समर्थन करता है।
