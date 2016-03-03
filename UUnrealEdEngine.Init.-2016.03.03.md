#UUnrealEdEngine.cpp
##Init(IEngineLoop* InEngineLoop)
###큰그림 : 엔진 초기화 작업 - 엔진 또는 에디터를 구성하는 모듈들을 로드하고 세팅한다.
1. Super::Init()  
> Super = UEditorEngine 에디터 엔진을 초기화한다 (Engine, Editor, Editor Engine 이 3개가 모두 비슷한 의미인것 같긴하데... 정확한 의미가 무엇일까.. )  
  UEditorEngine::InitEditor()  
  >> UEngine::Init()  
     >>> FURL 초기화  
     >>> FLinkerLoad 초기화  
     >>> UGameMapSettings::SetGameDefaultMap 기본맵세팅  
     >>> InitializeRunningAverageDeltaTime() 100FPS로 세팅  
     >>> InitializeHMDDevice(); HMD장치초기화  
     >>> InitializeMotionControllers();  
     >>> CurrentSlateAppl.InitializeSound(); 사운드 초기화  
     >>> LoadObject<\UClass>(UEngine::StaticClass()->GetOuter()); UEngine 로드? 생성? 이전에 한번 NewObject했으니 이번엔 로드겠지  
     >>> InitializeObjectReferces(); Loads all Engine object regerences
         많은 일들을 한다. 재질도, 텍스처도, 폰트도, DefaultPhysMaterial, ConsoleClass, GameViewportClientClass, LocalPlayerClass, WorldSettingsClass 등등 로드함  
     >>> CreateNewWorldContext(EWorldType::Editor) 월드를 하나 만든다.  
     >>> InitializeAudioDeviceManager() 오디오 장치 초기화  
     >>> FEngineAnalytics::Initialize();  
         FEngineAnalytics는 EngineExit()에서 등장했었는데 아마 파일 변경사항을 분석해주는 넘인것 같다.  
     >>> EngineStats.Add(); stat들을 추가한다. stat_Version, stat_NamedEvents, state_FPS 등등  
     
  >> PrivateInitSelectedSets()  
     SelectedActors, SelectedComponents, SelectedOjects 생성함. 근대 이게 멀까  
  >> FSlateApplication::IsInitialized()  
     Slate로 구성된 에디터에 추가적인 Slate 작업들을 한다.  
  >> UpdateRecentlyLoadedProjectFiles()  
     최신 프로젝트 로드  
       
> Layers = FLayers::Create()  
  레이어 하나 만든다 Actor들 배치할 기본레이어인듯  
> CreateTrans()  
  추적처리 시스템? 추적 시스템 만든다. 어디다 쓸까..  
> LoadRuntimeRngineStartupModules()  
  Game이 Startup 한거나 Editor이 Startup 하거나 할때, 로드되어야 할 모듈들 로드한다.  
  현재는 GameLiveStreaming 만 로드하고 있는데 나중에 여기에다가 추가해서 쓸수있을 것 같다.  
> Load all editor modules 에디터에 들어갈 모튤들을 로딩한다.  
  이전에 Load 했던 모듈들과의 차이라면 에디터 툴?? 에디터 편집툴?? 이런것 관련 모듈들이라는 점인 듯하다.  
> Load platform runtime settings modules 게임을 돌릴 플랫폼관련 모듈들을 로드하는 듯 런타임이니깐  
> Load platform editor modules 플랫폼 에디터 모듈도 로드한다.  
> BSPTexelScale 텍셀 사이즈 지정 (레벨에디터의 뷰포트를 기준으로 텍셀사이즈 정하는듯)  
> VolumeClasses.Add();  
  AVolume 타입의 class들을 한곳에 모아둔다. AVolume타입은 level에 편집가능한 3D형태를 가지는 것들이다.  
> ActorFactory들을 찾아서 위에서 찾은 VolumeClass타입을 생성할수 있는 ActorFactory들을 추가해준다.  
  이런일을 왜 여기서 하지??  
  메뉴에 ActorFactory추가하는데 메뉴에 Actor만드는게 있었나?? 아마 그것 때문인듯  
  
2. Register 먼가 등록을 한다.  
> OnPackageDirtyStateUpdated, OnPostGarbageCollect, OnColorPickerChanged, OnPreWindowsMessage, OnPostEindowMessage  
3. LoadPackage();  
> 패키지들을 로드한다. 에디터에서 쓸 패키지를 로드하는 것 같다. 총 100개인데... 음... 일단 에디터에서 사용하는 Package인듯  
4. sprite관련된 작업  
5. reimportManager 생성  
6. Details panel 세팅  
7. Cooking 관련 세팅  
  
---
모듈들을 굉장히 많이 로드한다. 에디터는 수많은 모듈들의 집합체인듯  
도중에 보니깐 IntroTutorials 모듈도 있던데 이거 빼면 첨에 튜토리얼은 사라지겠지  
---
에디터모드가 아닌 게임모드로 실행을 시켰다면 에디터 관련 로드쪽은 모두 빠지게 된다.