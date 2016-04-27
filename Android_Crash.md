#안드로이드에서 크러시 나는 이유들
####작성기간 : 2016.04.26
---
###디버깅 방식
1. Terga Nsight
2. logcat
  - 필터 이용(UE4)

###이유들
1. check()
  - 에디터에서는 쓰레기값은 거르지 않는다.
  - 안드로이드에서는 쓰레기값을 거른다.
  
2. uasset 로드
  - ~~_C 를 통한 로드를 사용해야 파일 로드가 된다.~~
  - 이상한건....... _C 붙일때랑 안붙일때가 확실치 않다...
  - Asset이 로드가 안되는 이유는 Cooking이 되지 않았기 때문이다.
    - 그럼 왜 Cooking이 안되었을까????????
    - [Asset Cooking참고](https://forums.unrealengine.com/showthread.php?60941-StaticLoad-problems-failing-to-find-file)
    - 간단 요약 Cooking 할때 Asset의 레퍼런싱 여부를 판단하는 데 클래스 생성자의 FFindObject or FFindClass의 경우는 참
    - 블루프린터에서의 레퍼런싱도 참
    - 걍 Path를 가져와서 Load 명령어를 통한 로딩의 경우는 안됨(레퍼런싱 되었다고 판단하지를 않는다)
  - 패키지 할때 Content안의 모든 파일을 Cooking하게끔 설정하면 Asset 로딩에 있어 문제가 없는듯 하다.
  - _C를 붙일 것과 뺼 것
    - _C를 붙여서 로드할 에셋 : Class(엔진이든 사용자가 만든거든)를 기반으로 파생된 BP들 ex) Actor, Widget
    - 걍 로드할 애셋 : Class 기반이 아닌 것 ex) Texture

3. OpenLevel 할때 ~~경로를 풀경로로 잡아준다.(.파일명 까지 적어라!@!!!!!!!!)~~ 
  - ~~패키징에 있어 .umap 파일이 빠져있다. 그래서 프로젝트 세팅에서 프로젝트에 필요한 map들을 packaged build 세팅에 추가해야한다.~~
  - ~~위 세팅을 통해서 .umap의 파일에 어떤한 변환(경로 같은거)이 생기는 것 같다.~~
  - ~~그리고 OpenLevel은 저런식으로 변환된 .umap파일들에 한에서 파일명으로 부터 바로 알수 있는 듯 하다.~~
    - 참고
    - DefaultMap에서 설정된 맵들은 OpenLevel을 통해서 로드하는 것이 아니다.
    - LoadMap 함수를 통해서 로드가 된다.
    - 근대 음.... Package할때 Linker Warning 뜨는 .uasset들과 .umap들이 있는데 그런것들도 먼가먼가먼가 수상하다...   
     
  - ~~하... 위에 내용 전부 안된다. 일단 플랫폼 별 경로 지정해서 사용해야겠다.~~
  - 맵도 쿠킹이 되었는지 안되었는지의 차이였다. 즉 2번처럼 한다면 전부 쿠킹이 될것이고 OpenLevel이 될것이다
  - 문제는 디플로이해서 보는건 쫌 이상하다 이건 쫌 이상함 진짜로 ㅋ

4. 
