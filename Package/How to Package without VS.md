#VS없는 PC에서 패키지하는 방법
####2016.04.01
---
###패키지 환경
1.VS는 없다.

2.프로젝트는 Blueprint + C++로 구성되어있다.

3.Android Package를 진행할 것이다.

4.CodeWork로 Android Package에 필요한 SDK, NDK, ANT, JDK 등은 설치되어 있다.

###Android Package 순서
1.Intermediate\Build\Android .h .generated.h .bin Makefile.ubt 파일들을 만들어 낸다.

2.Intermediate\Android .JAVA .xml등 NDK가 파일들을 만들어 낸다.

3.Build\Android 와 Build\Receipts .target.xml 파일들이 생긴다.

4.Cooking

5..obb 생성, .apk 생성, .bat생성


###패키지 진행
1.RunUAT BuildCookRun 명령어에 -build가 빠져있다
- -cook명령어는 있지만 VS가 있는 컴과 비교했을 때 빠져있었다
- -build명령어 추가하면 Complier가 지원되지 않는 프로젝트라는 경고창이 나온다.
- VS를 설치할 생각은 없다.

2.UHT와 NDK가 하는 일을 미리 하여 파일을 만들어 놓는다.(VS가 있는 컴에서)
- Android Package과정의 1,2,3번에 해당하는 파일 넘긴후 -build 명령어는 빼고 진행
- Package가 정상적으로 진행이 되었다.

###결론
1.UHT와 NDK가 만든 파일이 준비되어 있어야한다.
- 그럼 잘된다.

2.VS프로젝트라고 인식을 못하기 때문에 -build라는 명령어가 빠진것 같다.
- -build 명령어가 적용시 에러가 뜨는 것은 VS프로젝트가 아니라고 판단했기 때문이다.
- 위 두 문장이 똑같은거 같다

3.Cook가 끝나면 .obb파일이 생성할 때 base가 되는 .apk를 찾는다
-이 Base가 되는 .apk는 처음 NDK와 HUT에서 빌드가 진행될때 생긴다.
-즉, 이파일도 넘겨줘야함

4..obb파일이 생성되고나면 .apk파일이 생성이 진행되는데 이 때도 NDK에서 만든 파일들이 필요하다.

5.그 이후 작업에서도 NDK에서 만든 파일들이 필요하다.

###의문점
1.Blueprint만 사용한 프로젝트에서는 패키지할때 성공적으로 진행이 될것인가??
- apk가 만들어 질때 NDK에서 만든 파일들이 필요로 하는데 애초에 Blueprint 프로젝트는 NDK가 필요가 없다(Unreal Documentation에 나와있음ㅋ)
- 그럼 apk파일이 만들어 질때 필요로 하는 파일을 어딘가에서 복사해 주는 과정이 있을것 같다.
- 신기한건 왜 테스트한 프로젝트에서는 그런 복사과정이 없었을까?!

2.Blueprint프로젝트로 테스트를 진행해 봐야 명확해 질것같다.
