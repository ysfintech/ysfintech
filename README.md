# Yonsei-Financial-Technology-Center
Web page build by Flutter, Yonsei University Center for Financial-Technology

**published admin version** π

[Go to link π](https://ysfintech-homepage-admin.web.app) 

**published release version** π

[Go to link π](https://fintech.yonsei.ac.kr/#/)


## Recent Update
- WorkingPaperμ WorkingList κ²μν λ΄ μμλ₯Ό μμ νμμ΅λλ€.
  - λ°λΌμ Firebase λ΄ Field κ°μ μ‘°μ νμμ΅λλ€. `String` β `Timestamp`
*07.20.21 seunghwanly updated*

---

# Usage
[Notion link](https://www.notion.so/Guideline-99d08d08c7b24403b1813cd735000468)

# Add assets
Flutterμμμ λ¬Έμ λ‘ νμΈμ΄ λκ³  μμ΅λλ€.
μ°μ  μλμ λͺλ Ήμ΄λ₯Ό ν΅ν΄μ μΉ νμ΄μ§λ₯Ό λ°°ν¬νκ² λλλ°,
``` bash
flutter build web
```

λ°°ν¬κ° λμ λ, `build > web > assets` μμ `assets` ν΄λκ° μ€λ³΅μ μΌλ‘ μκΈ°λ λ¬Έμ λ‘ μΈν΄ λ°°ν¬λ μΉμμ assets λ΄ ν¬ν¨λ λ΄μ©μ΄ μλ¬κ° λ°μν©λλ€.

## Solution

νμ¬ `lib > assets` μ μλ `assets`λ₯Ό `lib > web` λλ ν λ¦¬ μμΌλ‘ λ³΅μ¬λ₯Ό ν΄μ€λλ€.

![](https://user-images.githubusercontent.com/22142225/123533617-c0173000-d751-11eb-8dd8-87796f96aed5.png)
