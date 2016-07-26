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
  > FBlueprinteditor은 OpenAssetEditor()에서 생성된다. 즉, 에셋을 열어 에디터 창을 띄울때 생성한다.  
  > FBlueprinteditor가 생성될때 SCSEditorCustomizations에 있는 것들을 FBlueprinteditor쪽에 등록하는게 있는데 이걸로 접근할수 있을듯  
  > TMap<FName, FSCSEditorCustomizationBuilder> SCSEditorCustomizations 요거다  
  > 즉, FSCSEditorCustomizationBuilder를 만들어서 SCSEditorCustomizations에 등록하면 BlueprintEditor창이 오픈할때 이벤트를 받을수 있다.  
  > 음... 이벤트에 의해 MakeInstance()함수가 호출되면 그 반환값이 Builder에 등록되는데  
  > FSCSEditorCustomizationBuilder과 FOnGetDetailCustomizationInstance 쪽과 다르므로 우리가 사용해야할 DetailPanel에서 SSCSEditor을 사용하려면 FSCSEditorCustomizationBuilder에서 등록해놓은 객체를 통해서 SSCSEditor을 가져와야하는 번거로움이 존재한다.  

- 그렇다면 번거로움을 쫌더 개선할수 있는 방법이 없을까??
  > FSCSEditorSustomizationBuilder에 등록되어 이벤트가 호출되면 BlueprintEditor 객체를 인자값으로 받을 수있는데 이 BlueprintEditor에는  
  > Inspector라는 SKismetInspector 타입의 변수가 존재한다.  
  > 이 SKismetInspector 클래스가 하는 일은 BlueprintEditor의 Slate구조를 형성?가지고? 있는 데 클래스의 변수중 DetailsView 타입의 PropertyView가 존재한다.  
  > PropertyView에는 DetailCustomize를 위해 DetailCustomize 클래스를 등록시킬수 있다(첨에 버튼 만든 것 처럼)  
  > 여기에 등록하기 위해서는 makeinstance(TWeakPtr<FBlueprintEditor> BlueprintEditor) 형식으로 함수를 구성하고 등록하면 된다.
  > 이렇게 등록을 하면 어떤 에셋을 편집하기 위해 편집창을 열면 PropertyView에 커스텀마이즈한 클래스가 등록이 되고 편집창에서 Detail창이 열릴 때 커스텀마이즈한 클래스에서 CustomizeDatail() 함수가 호출되면서 우리가 커스텀마이즈한 Slate구조가 형성된다.  

3. SSCSEditor::PerformComboAddClass() 함수를 호출시키겠다.
4. 끝

##### SSCSEditor 클래스
1. 이 클래스가 직접적으로 Component들을 만들어 내고 Node에 추가하는 작업까지 한다.
2. 이 클래스는 어디에서 왔을까???
  - 
