#패치
####작성기간 2016.03.11
---
###주내용 : 
####1.패치시스템에 대해서 알아본다.
####2.언리얼의 패치시스템을 분석하여 그 장단점을 알아본다.
####3.프로젝트에 적용할 패치시스템을 설계한다.
---
###패치 시스템
1.형상관리(Configuration Management) : 시스템 형상 요소의 기능적 특성이나 물리적 특성을 문서화하고 그들 특성의 변경을 관리하며, 변경의 과정이나 실현 상황을 기록·보고하여 지정된 요건이 충족되었다는 사실을 검증하는 것, 또는 그 과정.
- Version, Reversion
- Release
- Commit
  - Modify(*)
    - Merge자동형
    - Merge수동형(Conflict)
    - 3way Merge : 기반A1, 수정본A2, 수정본A3 가 있을 경우 최봉 생성될 A 파일은 A1-2, A1-3 --> A(1-2)-(1-3)의 비교로 이루어진 결과이다.
      - Binary Diff : Binary정보를 특정 단위로 나누어서 비교한 후 차이점을 반영한다.
      
        > 파일 동기화 및 전송 유틸리티
        > - rsync
        > - RTPatch
  - Add(+)
  - Remove(-)

2.소프트웨어 형상관리 프로그램
- 분산저장소 타입(서버가 유동적) : Git, Mercurial, Bitbucket
- Clinet/Server 타입(서버가 고정) : Subversion, Perforce, CVS, ClearCase

3.패치
- Version단위(집합적) : 집합체를 생성하고 해제하는 추가 작업이 들어간다.
- Difference단위(개별적) : 개별 단위의 패치의 경우 다운받을 시 수량이 많아질수 있으므로 다운도루 효율상 좋지 못하다.

###언리얼 패치 시스템(윈도우 플랫폼에 한정됨)
1.Launching UAT(Unreal Automation Tool)

2.컨텐츠 쿠킹
- 에디터에서 만든 .uasset 파일을 각 플랫폼에 맞는 .uasset 파일로 변환
- Saved/Cooked/[Platform]/[ProjectName] 경로에 저장

3.Pak파일 생성
- 설정해준 릴리즈 버전의 pak(Releases폴더에서 관리)에서 부터 .uasset 파일들 추출 (TempFiles폴더에 저장됨)
  - **패치가 적용되어 있지 않다. 단순히 릴리즈해준 버전으로만 비교!!!**
- 2번 쿠킹 단계에서 만든 .uasset 파일들과 비교
- 변경된 .uasset 파일들만 .pak파일로 묶음

4.단점
- 최종형상 = 클라이언트 = {Release.pak + Patch.pak} or {Release.pak}
  - 릴리즈 버전 : 게임에 필요한 소스 및 컨텐츠 모두를 패키지한 형태
  - 패치 파일은 릴리즈.pak랑만 비교해서 생성된다.
  - 릴리즈 버전을 새로만들어 주지 않으면 패치파일이 계속 커진다.
- C++ 코드의 변경 사항이 적용되지 않는다.
  - [ProjectName]\Binaries 경로에 생성된 실행파일을 단순히 복사해 온다.
  - 직접 빌드를 실행한 후 패치를 진행해야한다.

###IR 패치 시스템 요구사항
1.Version으로 관리

2.최종형상정의 = 클라이언트 = {A.uasset, B.uasset, C.uasset ...}

3.패치파일 = {A*.uasset, D+.uasset, C-.uasset ...}의 묶음 파일 = .pak or .zip. or ...

4.설치 알고리즘 포함(.apk, Latest Version Client)

5.다운로드 기능

6.실행 및 로드 기능

7.패치파일의 구성하는 파일 중 크기가 큰 것이 있다면 Binary Diff 기능 추가
