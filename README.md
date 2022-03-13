# EggMeet

**알을 깨고 성장하고 싶은 사람들의 만남을 중개하는 iOS 어플리케이션**

![스크린샷 2022-03-05 오후 11 07 12](https://user-images.githubusercontent.com/64069925/158045554-2a9043a5-f0a8-4744-ae41-d5103ce068d4.png)

### 소개
**에그밋**은, 한가지 분야 (자기계발, 취미생활 등) 에서 상대방에게 튜터링 또는 조언, 코칭을 해줄 수 있는 **'멘토'** 와, 그에게 멘토링을 받고자 하는 **'멘티'** 의 만남을 중개하는 모바일 지식 공유 서비스 입니다.

<br />

### 팀원
|iOS|서버|디자인|기획|
|------|---|---|---|
| [김송아](https://github.com/asong57) [이윤성](https://github.com/2yunseong), [황지우](https://github.com/earlysummer0303) | [권순찬](https://github.com/Kwon770) | [류현지](https://github.com/RyuHyeonji) | [황지우](https://github.com/earlysummer0303) |

<br />

### 코딩 컨벤션

- 모든 ViewController는 `대주제 + 컨트롤러이름+VC.swift` 로 통일한다.
    - 대주제는 해당 뷰 컨트롤러가 구현해야 할 핵심 기능을 뜻한다.(회원 가입 = Sign Up)
    - 컨트롤러 이름은 해당 뷰 컨트롤러가 수행하는 기능으로 명명한다.
    - 뒤에 ViewController를 뜻하는 VC를 붙인다.
- Class 명과 StoryBoardID는 일치 시킨다. (복붙 권장)
- UserDefaults 같은 모든 곳에서 사용하는 싱글톤 객체는 사용시에 변수명을 대문자를 따서 `ud` 로 명명한다.
- Segue ID는 `목적지 이름 + Segue` 로 명명한다.
- 화면 전환 메소드에서, wind, unwind를 수행하는 메소드는 다음과 같이 명명한다.
    - wind 시 : `wind + 목적지 이름 + View()`
    - unwind 시 : `unwind + 목적지 이름 + View()`
- wind와 unwind시 기본 데이터 전달을 전제로 하고, 특수한 액션을 취하는 메소드 명은 다음과 같이 명명한다.
    - 건너뛰기(데이터를 전달하지 않음) : `skip(특수한 행동) + And + Wind + 목적지 이름 + View()`
