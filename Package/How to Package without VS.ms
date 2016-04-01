#VS없는 PC에서 패키지하는 방법
####2016.04.01
---
###패키지 환경
1.VS는 없다.
2.프로젝트는 Blueprint + C++로 구성되어있다.
3.Android Package를 진행할 것이다.
4.CodeWork로 Android Package에 필요한 SDK, NDK, ANT, JDK 등은 설치되어 있다.

###Android Package 순서
1.

2.Intermediate\Android .JAVA .xml등 NDK가 파일들을 만들어 낸다.

###패키지 진행
1.RunUAT BuildCookRun 명령어에 -build가 빠져있다
- -cook명령어는 있지만 VS가 있는 컴과 비교했을 때 빠져있었다
- -build명령어 추가하면 Complier가 지원되지 않는 프로젝트라는 경고창이 나온다.
- VS를 설치할 생각은 없다.

2.
