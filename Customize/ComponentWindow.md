# 동적 추가된 Component를 ComponentWindow에 추가하기
#### 작성기간 : 2016.07.13 - 
---
## 목적 : 에디터에서 AddComponent를 사용하여 컴포넌트를 만들면 될 것인데 왜 이렇게 할까?? 음... 구지 이렇게 할 필요하 없겠다 그래도 연구용으로 작성해보자.

##### 목표
1. Actor에셋을 Edior하는 창에서 디테일창에 버튼이 존재하여야 한다.
2. 버튼을 클릭하면 WidgetComponent가 생성되며 ComponentWindow에 추가되어야 한다.
3. 이 Component는 게임상에서 설정된 값을 유지하며 동작하여야 한다.

##### 준비과정
1. 디테일 커스텀마이즈를 통해서 디테일창에 버튼을 하나 만들었다.
2. 이 버튼을 클릭할 시에 호출할 함수를 만들었다.
3. 이 함수에서 WidgetComponent를 생성하고 ComponentWindow에 추가할 것이다.

##### 개발과정
1. 에디터에서 컴포넌트 추가 버튼으로 Component를 생성할 때 어떤 과정이 일어날까??
- 키 입력 이벤트 -> DropDownMenu에서 키 입력 처리 -> 델리게이트로 묶인 함수 호출 -> 그 중 SComponentClassCombo의 OnAddComponentSelectionChanged 호출 -> OnAddComponentSelectionChanged함수안에서 OnComponentClassSelected에 묶인 함수들 호출 -> 그 중 SSCEditor에 있는 PerformComboAddClass 함수 호출

##### SSCSEditor 클래스
1. 이 클래스가 직접적으로 Component들을 만들어 내고 Node에 추가하는 작업까지 한다.
2. 이 클래스는 어디에서 왔을까???
  - 
