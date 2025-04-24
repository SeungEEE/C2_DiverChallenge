# 🚀 프로젝트 이름

<img width="1529" alt="C2_무드보드" src="https://github.com/user-attachments/assets/d0754da2-13b1-426b-a20c-1085c644db55" />


> 목표와 다짐, 그리고 회고를 바로바로 기록할 수 있는 앱

[![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)]()
[![Xcode](https://img.shields.io/badge/Xcode-16.0-blue.svg)]()
[![License](https://img.shields.io/badge/license-MIT-green.svg)]()

---

## 📋 목차
- [멤버](#👥-멤버)
- [소개](#📱-소개)
- [프로젝트 기간](#📆-프로젝트-기간)
- [개발환경](#⚒️-개발-환경)
- [기술 스택](#🔎-기술-스택)
- [화면 구성](#📱-화면-구성)
- [브랜치 컨벤션](#🔖-브랜치-컨벤션)
- [코딩 컨벤션](#🌀-코딩-컨벤션)
- [PR 컨벤션](#📁-pr-컨벤션)
- [커밋 컨벤션](#📑-커밋-컨벤션)
- [폴더 컨번센](#🗂️-폴더-컨벤션)

<br>

## 👥 멤버
| 이안 |
|:----:|
| <img src="https://github.com/user-attachments/assets/201fb40c-af08-4044-a3e4-8d3a029436fb" width="150"/> |
| Design, PM, iOS |
| [GitHub](https://github.com/SeungEEE) |

<br>


## 📱 소개
> Diver Challenge는 사용자가 하나의 장기 목표(챌린지)를 설정하고,
그 목표를 달성하기 위한 하루 단위의 목표, 다짐, 감정 상태를 기록하는 루틴 기반 자기 관리 앱입니다.
간단한 입력으로도 꾸준한 자기 성찰과 동기 부여를 가능하게 하며,
기록 데이터를 바탕으로 사용자 맞춤형 리포트 및 습관 형성을 유도합니다.
자기계발, 멘탈케어, 루틴 추적 시장을 겨냥한 새로운 일상 기록 플랫폼입니다.

<br>

## 📆 프로젝트 기간
- 전체 기간: `2025.04.07 - 2025.04.25`
- 개발 기간: `2025.04.18 - 2025.04.25`

<br>

## 🤔 요구사항
For building and running the application you need:

iOS 18.2 <br>
Xcode 16.2 <br>
Swift 6.0

<br>

## ⚒️ 개발 환경
* Front : SwiftUI
* 버전 및 이슈 관리 : Github, Github Issues

<br>

## 🔎 기술 스택
### Envrionment
<div align="left">
<img src="https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white" />
<img src="https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white" />

</div>

### Development
<div align="left">
<img src="https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white" />
<img src="https://img.shields.io/badge/SwiftUI-42A5F5?style=for-the-badge&logo=swift&logoColor=white" />
</div>

<br>

## 📱 화면 구성
<img width="1013" alt="스크린샷 2025-04-24 오후 3 45 15" src="https://github.com/user-attachments/assets/071a1c4a-c7fd-4cf5-8f5d-db57762a8d32" />


## 🔖 브랜치 컨벤션
* `main` - 제품 출시 브랜치
* `develop` - 출시를 위해 개발하는 브랜치
* `feat/xx` - 기능 단위로 독립적인 개발 환경을 위해 작성
* `refac/xx` - 개발된 기능을 리팩토링 하기 위해 작성
* `hotfix/xx` - 출시 버전에서 발생한 버그를 수정하는 브랜치
* `chore/xx` - 빌드 작업, 패키지 매니저 설정 등
* `design/xx` - 디자인 변경
* `bugfix/xx` - 버그 수정하는 브랜치



<br>

## 🌀 코딩 컨벤션
* 파라미터 이름을 기준으로 줄바꿈 한다.
```swift
let actionSheet = UIActionSheet(
  title: "정말 계정을 삭제하실 건가요?",
  delegate: self,
  cancelButtonTitle: "취소",
  destructiveButtonTitle: "삭제해주세요"
)
```

<br>

* if let 구문이 길 경우에 줄바꿈 한다
```swift
if let user = self.veryLongFunctionNameWhichReturnsOptionalUser(),
   let name = user.veryLongFunctionNameWhichReturnsOptionalName(),
  user.gender == .female {
  // ...
}
```

* 나중에 추가로 작업해야 할 부분에 대해서는 `// TODO: - xxx 주석을 남기도록 한다.`
* 코드의 섹션을 분리할 때는 `// MARK: - xxx 주석을 남기도록 한다.`
* 함수에 대해 전부 주석을 남기도록 하여 무슨 액션을 하는지 알 수 있도록 한다.

<br>


## 📁 PR 컨벤션
* PR 시, 템플릿이 등장한다. 해당 템플릿에서 작성해야할 부분은 아래와 같다
    1. `PR 유형 작성`, 어떤 변경 사항이 있었는지 [] 괄호 사이에 x를 입력하여 체크할 수 있도록 한다.
    2. `작업 내용 작성`, 작업 내용에 대해 자세하게 작성을 한다.
    3. `추후 진행할 작업`, PR 이후 작업할 내용에 대해 작성한다.
    4. `리뷰 포인트`, 본인 PR에서 꼭 확인해야 할 부분을 작성한다.

<br>

## 📑 커밋 컨벤션

| 아이콘 | 코드 | 설명 | 원문 |
| :---: | :---: | :---: | :---: |
| 🐛 | bug | 버그 수정 | Fix a bug |
| ✨ | sparkles | 새 기능 | Introduce new features |
| 💄 | lipstick | UI/스타일 파일 추가/수정 | Add or update the UI and style files |
| ♻️ | recycle | 코드 리팩토링 | Refactor code |
| ➕ | heavy_plus_sign | 의존성 추가 | Add a dependency |
| 🔀 | twisted_rightwards_arrows | 브랜치 합병 | Merge branches |
| 💡 | bulb | 주석 추가/수정 | Add or update comments in source code |
| 🔥 | fire | 코드/파일 삭제 | Remove code or files |
| 🚑 | ambulance | 긴급 수정 | Critical hotfix |
| 🎉 | tada | 프로젝트 시작 | Begin a project |
| 🔒 | lock | 보안 이슈 수정 | Fix security issues |
| 🔖 | bookmark | 릴리즈/버전 태그 | Release / Version tags |
| 📝 | memo | 문서 추가/수정 | Add or update documentation |
| 🔧| wrench | 구성 파일 추가/삭제 | Add or update configuration files.|
| ⚡️ | zap | 성능 개선 | Improve performance |
| 🎨 | art | 코드 구조 개선 | Improve structure / format of the code |
| 🙈 | see_no_evil | .gitignore 추가/수정 | Add or update a .gitignore file |



<br>

## 🗂️ 폴더 컨벤션
```
Sources/
├── App/ # 앱의 진입점 및 생명주기
│ ├── DiverChallengeApp.swift # @main 진입점
│ └── ContentView.swift # 루트 뷰
├── Core/ # 앱의 기본 구성요소
│ └── Extensions/ # Swift 확장 기능
│   ├── HideKeyboard.swift
│   └── RoundedCorner.swift
├── Data/ # 데이터 계층
│ ├── Models/ # 도메인 모델 (Entity)
│ ├── DivingBook.swift
│ ├── DivingDailyLog.swift
│ └── Emotion.swift
├── Presentation/ # UI 계층
│ ├── Navigation/ # 커스텀 네비게이션 바
│ │ └── CustomNavigationBar.swift
│ ├── Components/ # 공통 UI 컴포넌트
│ │ └── MainButton.swift
│ └── Screens/ # 기능별 화면 구성
│   ├── BookFeature/ # 도감 관련 화면
│   │ ├── HomeView.swift
│   │ ├── CreateDivingView.swift
│   │ └── DivingCardView.swift
│   ├── ListFeature/ # 일지 리스트
│   │ └── DivingListView.swift
│   ├── LogFeature/ # 개별 일지 상세
│   │ └── DivingLogView.swift
│   └── SplashFeature/ # 앱 시작 스플래시
│     └── SplashView.swift
├── Resources/ # 폰트, 컬러, 에셋 등 정적 리소스
│ ├── Asset/ # Xcode Assets
│ │ └── Assets.xcassets
│ └── Fonts/ # Pretendard 커스텀 폰트
│   ├── Pretendard-Bold.ttf
│   ├── Pretendard-Medium.ttf
│   ├── Pretendard-Regular.ttf
│   └── Font+.swift
└── PreviewContent/ # SwiftUI Preview 리소스
```
