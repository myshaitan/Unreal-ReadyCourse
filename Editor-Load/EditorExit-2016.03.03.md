#Launch.cpp
##EditorExit()
###큰그림 : Editor 모드 저장, 언리얼 종료, 아직 종료되지 않은 쓰레드가 있다.(ntdll-윈도우 코어 모듈, msvcr120-visual c++ 런타임 라이브러리)  
1.GLevelEditorModeTools().SetDefaultMode();  
- 레벨에디터 Default모드로 설정.  

2.GLevelEditorModeTools().DeactivateAllModes();
- Default모드를 제외한 다른 모드는 비활성화  

3.Config에 Editor Mode저장 -> 디렉토리 저장 -> UnrealIEMisc::Get().OnExit() -> 콘솔창 닫기

4.UnrealIEMisc::Get().OnExit()  
- 업데이트 되어서 저장되어야 하는 에셋 목록을 띄운다. (아마도??)  
- Message log에 등록된 것들을 해제시킨다.  
- events를 해제시킨다.  
- Delegat에 등록된 것들도 해제시킨다.  
- 함수 마지막 구문에서 실행파일로 저장하는 일을 하는 것 같다.  
