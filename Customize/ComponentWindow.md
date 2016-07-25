# 동적 추가된 Component를 ComponentWindow에 추가하기
#### 작성기간 : 2016.07.13 - 
---
## 목적 : 에디터에서 AddComponent를 사용하여 컴포넌트를 만들면 될 것인데 왜 이렇게 할까?? 음... 구지 이렇게 할 필요는 없겠다 그래도 연구용으로 작성해보자.

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
- 키 입력 이벤트 -> DropDownMenu에서 키 입력 처리 -> 델리게이트로 묶인 함수 호출 -> 그 중 SComponentClassCombo의 OnAddComponentSelectionChanged 호출 -> OnAddComponentSelectionChanged함수안에서 OnComponentClassSelected에 묶인 함수들 호출 -> 그 중 SSCSEditor에 있는 PerformComboAddClass 함수 호출 -> SSCSEditor::AddNewComponent() 호출, 이 함수에서 노드에 추가되는 부분이 존재한다.
2. SSCSEditor을 가져온다.
- 위에서 CustomizeDetails을 통해서 버튼을 생성했듯이 CustomizeDetails에서 DetailBuilder에서 SSEditor을 가져 올수 있는지 확인
  > DetailBuilder에서 가져오기  
  > 실패

- KismetEditorUtilities::AddComponentToBlueprint() 이용
  > 가능은 하지만 GetRootNode()에서 RootNode를 블루프린터편집창에서 생성한 Component 중에서 최상단 Node를 루트로 잡는다.  
  > 즉, C++코드상에서 생성자에서 추가한 Component는 GetAllNode()에서 빠져있다.  
  > 사용하기 애매함  

- 그럼다면 SSCSEditor에는 C++에서 추가한 Node와 블루프린터편집창에서 추가한 Node를 모두 가지고 있으며 그중에 최상단 Node도 알고있따.
  > SSCSEditor을 가져온다.  
  > FBlueprinteditor 클래스를 통해서 SSCSEditor을 가져올수 있다.  
  > FBlueprinteditor은 어떻게??  

3. SSCSEditor::PerformComboAddClass() 함수를 호출시키겠다.
4. 끝

##### SSCSEditor 클래스
1. 이 클래스가 직접적으로 Component들을 만들어 내고 Node에 추가하는 작업까지 한다.
2. 이 클래스는 어디에서 왔을까???
  - 
