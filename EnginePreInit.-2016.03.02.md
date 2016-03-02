# LaunchEngineLoop.cpp

## EngineProInit() ## 
### 요약 : Commanline 처리, 모듈(Core, Startup)로드, 중간중간에 쓰레드 생성
1. FPlateformMisc::SetUIFOutPut();
> UTF8??이걸로 세팅하는 듯(.csv 파일 읽을 때 UTF8 인코딩만(?) 먹히는 이유가 여기에 있을까??)
2. FPlatformProcess::SetCurrnetWorkingDirectoryToBaseDir();
> 현재 작업폴더를 Base폴더로 설정
3. FCommandLine::Set(CmdLine); 
> 음... 에디터와 프로젝트의 실행파일 경로 및 추가 명령어를 가지고 나중에 필요한 곳에 쓸것 같다.
4. FStatsMallocProfillerProxy::HasMemoryProfilerToken();
> Param을 생성하던데..일단 프로파일러를 위한 메모리 관련 일을 한다.
5. LaunchSetGameName();
> 프로젝트의 이름을 설정한다.
6. FWindowsPlatformOutputDevice();
> OutputDeviecConsole를 하나 생성한다(Singleton 형식)
7. LaunchCheckForOverride();
> 플랫폼의 파일들을 처리할수 있는 모듈을 생성한다. PakFile, SandboxFile, nerwork, profiling, timings stats, open log  
  각각 ConditionallyCreateFileWrapper() 함수를 통해서 IPlatformFile* 형을 반환받는다.
8. IFileManager::Get().ProcessCommandLineOption();
> 파일매니저 초기화 작업 수행  
  빌드 모드와 CommandLine의 조건에 따라 추가 작업을 해준다.
9. LaunchHasInxompleteGameName()
> GameName이 불완전하거나 프로젝트 파일이 없다면 에디터 초기화 종료
10. main thread의 ID를 저장해 둔다, 추가 쓰레드 세팅하는 함수를 호출하지만 용도가 애매하다...
> FPlatformProcess::SetThreadAffinityMask();  
  FPlatformProcess::SetupGameOrRenderThread();
11. CommandLine을 통해서 Editor, Ucc??, The Game인지를 파악하는 구문.
~~~
const SIZE_T CommandLineSize = FCString::Strlen(CmdLine)+1;
...
...
~~~
12. SetBenchmarking();
> 벤치마킹?? 이게 나중에 어떻게 쓰일까..??
13. FTaskGraphInterface::Startup(FPlatformMise::NumberOfCourse());
> 플랫폼에서 사용가능한?? Core를 체크를 한다음 그 수에 맡게 쓰레드를 생성 시킨다. Main thread 포함 4개 생성된다.
14. FThreadStats::StartThread();
> Stats Thread 생성시킨다.
15. LoadCoreModules();
> 위에서 만든 Stats Thread에서 CoreModule들을 Load하는 것 같다.  
  CoreUObject 모듈만 로드한다.
16. InitializeRenderingCVarCaching();
> 렌더링할 해상도의 크기를 미리 캐싱한는 작업을 하는 듯..
17. PoolThread 3개를 생성한다.
~~~
if(FPlatformProcess::SupportsMultithreading())
...
...
~~~
18. LoadPreInitModules();
> CoreModule를 제외한 나머지 모튤을 Load한다. (함수 앞에 Pre가 붙었으니 이 함수가 호출하고 난 뒤에 또 모듈을 Load하는 함수가 호출될 수도 있겠지..아마)  
  Engine, Renderer, AnimFraphRuntime, OpenGL, D3Direct, SlateRHIRenderer, Landscape, ShaderCore, TextureCompressor 
19. AppInit();
> 어플리케이션 초기화 작업
20. FSystemSettings::Initialize();  
ApplyCVarSettingsFromIni(RendererSerrting); , StreamingSerrting, GarbageCollectionSerrting
> .ini의 설정대로 System 을 초기화한다.
21. PreloadResolutionSettings()
> GameUserSettings.ini에서 설정한 해상도로 세팅한다.  
  이전에 해상도 크기만큼 캐싱작업을 한것 같은데 함수 내부의 RequestResolutionChange() 호출로 다시 변경되지 않을까??
22. 계속 .ini로딩하고 그걸로 초기화 하는 작업이 진행된다.
> FPlatFormMisc::PlatformInit();  
  FPlatformMemory::Init();  
  InitializeStdOutDevice();  
  InitGamePhy();  
23. FSlateApplixation::Create();
> Editor 로딩창을 만든다.(로딩바 같은거 막 퍼센트 올라가고 그런 창을 생선한다.)
24. RHIInit();
> 중요해 보이지만 일단 패스
25. GetGlobalShaderMap()
> 글로벌 세이더맵을 가져옵니다.
26. UObject관련 Load처리
> FPackageName::RegisterShortPackageNamesForUObjectModules()  
  SlowTask::EnterProgressFrame();  
  ProcessNewlyLoadedUObjects();  
27. Material관련 Load처리
> UMaterialInterface::InitDefaultMaterials();  
  UMaterialInterface::AssertDefaultMaterialsExist();
  UMaterialInterface::AssetDefaultMaterialsPostLoaded();  
28. FStartupPackages::LoadAll()
> Startup에 필요한 package들을 Load한다.
29. LoadStartupCoreModules()
> 위에 나온 LoadCoreModules()와의 차이점을 구분해볼 필요가 있다.  
  Core, Networking, XAudio2, HeadMountedDisplay, SourceCodeAccess, Messaging??, SessionServices, EditorStyle  
  Slate, UMG, MessageLog, CollisionAnalyzer, FunctionalTesting, BehaviorTreeEditor, GameplayTasksEditor, GamepolayAbilitiesEdior  
  EnvironmentQueryEditor, OnlineBlueprintWupport, IntroTutorials, Blutility  
30. PreLoadingScreen 에서 필요로한 모듈 로딩
> IProjectManager::Get().LoadModulesForProgect(ELoadingPhase::PreLoadingScreen)  
  IPluginManager::Get().LoadModulesForEnavledPlugins(ELoadingPhase::PreLoadingScreen)  
31. GHIPostInit()
> RHI가 Render관련된 놈 같은데... Post초기화가 이루어진다.
32. StartRenderingThread();
> 렌더링 처리는 쓰레드를 통해서 처리되는가 보다.  
  RenderThread가 생성되었다.  
33. LoadStartupModules()
> PreDefault, Default, PostDefault에 필요한 모듈 로딩  
  위에서 등장한 함수사용  
  IProjectManager::Get().LoadModulesForProgect(ELoadingPhase::PreDefault)  
  IPluginManager::Get().LoadModulesForEnavledPlugins(ELoadingPhase::PreDefault)  
34. MarkObjectsToDisregardForGC()
> 가비지 컬렉터 관리 밖의 Object를 분류하는 듯. (UCLASS 매크로를 통한 class 정의가 아닌 경우가 되지 않을까??)
35. 갑자기 몇백줄을 그냥 넘어감... 당황하지말고 다음줄을 읽겠음. 오히려 이득 ㅋㅋ
36. TaskGraph, ProfilerService 모듈 로드

---
**FParse::Param(); , FParse::Value();**
- 인자값들이 서로 같은지 다른지 또는 포함관계인지를 파악해준다. 은근 자주 등장함.