# UnrealEd.cpp
## EditorInit()
### 큰그림 : 엔진관련 초기화 작업이 이루어 진다.
1. EngineLoop.Init()  
> EngineLoop 초기화  
  에디터 모드인지 게임 모드인지에 따라서 EngineClass 생성  
  NewObject<\UEngine>() or NewObject<\UnrealEdEngine>  
>> InitTime() : 사용될 TickTime들을 초기화한다.  
   UUnrealEdEngine::Init() : 엔진을 초기화 한다.(이거 내용 다시 자세히 정리해야함)  
   IProjectManager::Get().LoadModulesForProject(ELoadingPhase::PostEngineInit) : 이거 또나왔네 PostEngineInit관련 모듈 로드  
   AutomationWorker 로드  
   AutomationController 로드  
   ProfillerClinet 로드  
2. FUnrealEdMisc::Get().OnInit()  
> misc editor 초기화 작업 (misc miscellaneous 잡무 잡다한 일인데 여기의 의미랑 맡나?? 일단 자세히 정리 필요)  
3. MainFrame 모듈 로드

---
EnginePreInit() 와 다른점이라면... 음... 엔진이 생성되지 전에 세팅되어야 하는 것들은 PreInit()에 있고  
엔진이 세팅되어야 하는 부분은 EditorInit()에 존재하는 것 같다.  