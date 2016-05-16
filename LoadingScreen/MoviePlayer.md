#MoviePlayer을 이용해서 Loading Screen 만들기
####작성기간 : 2016.05.09
###목표 : 로딩스크린을 만든다. 스크린에는 ProgressBar가 존재하며 로딩 상태를 Percentage로 나타낸다.

###MoviePlayer이란??
1. 개발자가 쉽게 레벨 전환시 그 사이에 Movie나 LoadingScreen을 띄울수 있게 만들어 주는 라이브러리 인듯하다.  
2. 

###구현 방향
1. 로딩할 때 Screen으로 쓸 Wdiget을 만든다
  - SCompoundWidget을 상속받은 Widget이다.
2. 맵 로딩이 시작하기 전 시점 즉, PreLoadMap 델리게이트에 이벤트를 달아 호출되게 만든다.
3. 위 이벤트에서 MoviePlayer을 가져와 위젯을 달아준다.
  > GetMoviePlayer()->SetupLoadingScreen();
  > ~~EGine->GameViewport->AddViewportWidgetContent();~~ AddViewPort를 하지 않아도 보여진다.

4. 맵 로딩이 끝나는 시점 즉, PostLoadMap 델리게이트에 이벤트를 달아 호출되게 만든다.
  > AddViewPort를 안했기 때문에 따로 Detach??떼낼 필요가 없다.

5. Percentage를 표현해야한다.
  - Loadlevel의 부분을 분석하면 답이 보일듯 하다.

###안되는 거
1. Entry -> Lobby 로 이동시에는 적용되지 않는다.
  - 에디터 프리뷰에서는 적용되지 않음
  - 하지만, 별도 프로세서를 통한 프리뷰에서는 적용됨
  - 결론 : Load

2. 스크린 위젯이 로딩중 일때 보여지는게 아니라 로딩이 끝날때 보여지는 것 같다
  - AddViewportWidget을 할때 음... Viewport가 애매한 느낌?? 어딘지 파악해야함.
