#로딩 과정 분석(1차)
##큰그림 그리기
###엔진의 시작을 훝어본다
1.LaunchWindows.cpp
- Main Entry Point for Windows
- WinMain();
   - SetupWindowsEnvironment();	// 윈도우의 환경을 셋업하는 듯하다.
   - GuardedMain(); 		// 여기를 지나니깐 엔진의 초기화 과정이 시작된다.
   - AppExit();			// 플랫폼의 정리? 먼가 엔진을 마무리하면서 플랫폼 세팅을 원상복구? 그런느낌임

2.Launch.cpp
- GuardedMain();
  - EnginPreInit();		// 초기화 79%까지 완료
   >**LaunchEngineLoop::EnginePreInit()**
   > - FPlateformMisc::SetUTFOutput();	// UTF8??이걸로 세팅하는 듯(.csv 파일 읽을 때 UTF8 인코딩만(?) 먹히는 이유가 여기에 있을까??)
   > - FPlatformProcess::SetCurrnetWorkingDirectoryToBaseDir();	// 현재 작업폴더를 Base폴더로 설정
   > - FStatsMallocProfillerProxy::HasMemoryProfilerToken();	// Param을 생성하던데..일단 프로파일러를 위한 메모리 관련 일을 한다.
  
  - EditorInit();		// 초기화 100% 완료
  - EngineTick();		// 엔진의 Loop부분
  - EditorExit();		// 엔진의 종료
  
