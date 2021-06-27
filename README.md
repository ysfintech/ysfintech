# Yonsei-Financial-Technology-Center
Web page build by Flutter, Yonsei University Center for Financial-Technology

**published beta version** 🚀

[Go to link 👉](https://ysfintech-homepage.web.app/#/) 

**published release version** 🚀

[Go to link 👉](https://fintech.yonsei.ac.kr/#/)

# Usage
[Notion link](https://www.notion.so/Guideline-99d08d08c7b24403b1813cd735000468)

# Add assets
Flutter에서의 문제로 확인이 되고 있습니다.
우선 아래의 명령어를 통해서 웹 페이지를 배포하게 되는데,
``` bash
flutter build web
```

배포가 됐을 때, `build > web > assets` 안에 `assets` 폴더가 중복적으로 생기는 문제로 인해 배포된 웹에서 assets 내 포함된 내용이 에러가 발생합니다.

## Solution

현재 `lib > assets` 에 있는 `assets`를 `lib > web` 디렉토리 안으로 복사를 해줍니다.

![](https://user-images.githubusercontent.com/22142225/123533617-c0173000-d751-11eb-8dd8-87796f96aed5.png)
