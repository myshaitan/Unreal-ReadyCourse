#MoviePlayer을 이용해서 Loading Screen 만들기
####작성기간 : 2016.05.09
###MoviePlayer이란??
1. 

###구현 방향
1. 로딩할 때 Screen으로 쓸 Wdiget을 만든다
  - SCompoundWidget을 상속받은 Widget이다.
2. 맵 로딩이 시작하기 전 시점 즉, PreLoadMap 델리게이트에 이벤트를 달아 호출되게 만든다.
3. 위 이벤트에서 MoviePlayer을 가져와 위젯을 달아준다.
  > GetMoviePlayer()->SetupLoadingScreen();
  > EGine->GameViewport->AddViewportWidgetContent();

4. 맵 로딩이 끝나는 시점 즉, PostLoadMap 델리게이트에 이벤트를 달아 호출되게 만든다.

###안되는 거
1. Entry -> Lobby 로 이동시에는 적용되지 않는다.
2. 스크린 위젯이 로딩중 일때 보여지는게 아니라 로딩이 끝날때 보여지는 것 같다
  - AddViewportWidget을 할때 음... Viewport가 애매한 느낌?? 어딘지 파악해야함.
