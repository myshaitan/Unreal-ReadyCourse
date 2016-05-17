#OpenLevel 동작 분석
####작성기간 : 2016.05.17
##목표 : OpenLevel 분석을 통해 Level Load 완료 시점을 파악한다.
---
###UGamePlayStatics::OpenLevel()
1. GEngine->GetWorldFromContextObject() : 현재 월드 가져온다
  - 나중에 로딩 실패했을경우 현재 월드를 재사용하는 것 같다.
2. LevelName : 로드할 레벨의 이름이 사용가능한지 확인
3. GEngine->SetClientTravel()
  - 다음 틱에서 월드를 바꿔주기 위해 설정을 한다.
  - 다음 틱!!!에서 월드가 바뀐다.
  
###UEngine::TickWorldTravel()
1. 여러가지 조건문이 있고 현재 월드의 상태에 따라서 다른방식으로 월드를 로딩한다.
2. if(TravelURL 에 로딩할 월드 이름이 저장되어 있을 경우) 만 분석
3. FURL()
  - URL의 옵션이나, 사용가능 체크 및 로드할 맵의 풀경로 세팅
4. Browse()
  - LoadMap() 함수 호출

###UEngine::LoadMap()
1. PreLoadMap(); : 빈함수이지만 호출
2. PreLoadMap.Broadcast(); : 등록된 이벤트들 호출 
  > (check : 여기에 이벤트 하나 등록하자.)  
  
3. FPostLoadMapCaller : 이 구조체를 하나 생성하는데 이넘의 소멸자에서 PostLoadMap.Broadcast(); 를 호출한다.
  > ~~(check : 여기에 이벤트 하나 등록하자.)~~
  > 밑에 다시 호출하므로 제거
  
4. 현재 월드에서 로드되어 있는 Package 들을 CleanUp 시킨다.
5. Unload the Current World
  - 여기서 Loading Screen이 있으면 Loading Screen을 띄운다.
  - FWorldDelegates::LevelRemoveFromWorld.Broadcast(); 이벤트 호출
    > (check : 여기에 이벤트 하나 등록하자.)
    
  - UWorld::CleanUpWorld()
    > 이 함수 안에서도 CleanUp에 대한 이벤트들이 호출되긴 하는데.... 이벤트등록을 해야할까?!
    
6. 새로운 월드 로드 (여러가지 조건문이 있고 그것에 따라 다르게 로드함)
  - 우리는 Nomal map Loading 방식이다.
7. FindPackage(Map)
8. LoadPackage(Map)
9. FindWorldInPackage() : 여기서 map에 생성해 놓았던 UObject들을 다 생성한다.
10. WorldContext.SetCurrentWorld()
11. WorldContext.World()->InitWorld()
  - FWorldDelegates::OnPreWorldInitializeation.Broadcast();
     > (check : 여기에 이벤트 하나 등록하자.)
    
  - FWorldDelegates::OnPostWorldInitialization.Broadcast();
     > (check : 여기에 이벤트 하나 등록하자.)
    
  - BroadcastLevelsChanged();

12. LoadPackageFully(); : 잘모름
  - 로드가 덜된 패키지 로드??
  - 서브 레벨 로드??

13. AI시스템 만듬
14. GamePlay를 위한 초기화
15. 네비 초기화
16. 여러가지 생성 초기화 등등
17. FCoreUObjectDelegates::PostLoadMap.Broadcast();
  > (check : 여기에 이벤트 하나 등록하자.)
  
