#디테일 패널 커스터마이징하기
####작성기간 : 2016.05.02 - 2016.05.04
---
##구현 목표 : A클래스를 Has a 관계로 상속 받음. 상속 받은 B클래스는 Detail_Panel에 A클래스에서 구현한 버튼을 쓴다.
1. A클래스는 SWidget를 이용하여 Slate형으로 만들어야 한다.
2. 버튼 클릭시 B클래스의 함수를 호출하여야 한다.

##1단계 : (기초) 단순한 변수 추가
1. UCLASS() 매크로를 이용하여 클래스 만들었을 경우
  - UPROPERTY() 변수는 자동 등록
  - 이건 그냥 에디터에서 해주니깐 PASS~

##2단계 : (기초) Slate를 이용하여 간단한 Widget 만들기
1. SCompundWidget를 상속받은 C클래스 만들기
> SLATE_BEGIN_ARGS(C클래스)
>  : ..
>  , ..
> {}
> SLATE_ARGUMENT(타입, 변수명)
> SLATE_END_ARGS()
>
> void Construct(const FArguments& InArgs);
2. Construct 함수 안에서 UI의 틀을 만들어 낼수 있다.

##3단계 : (본격개발) Detail_Panel에 이벤트 등록
1. PropertyEditorModule 가 Detail_Panel에 등록되는 Slate?? 구성품?? 들을 가지고 있다
2. 그리고 Detail이 필요로하는 .uasset 파일이 열릴때 PropertyEditorModule에 등록된 모든 구성품(FOnGetDetailCustomizationInstance)을 뒤져서 로드한다.
3. 즉 우리도 PropertyEdtor에 등록해주고 로드하게 할 것이다.
4. PropertyEdotorModule::RegisterCustomClassLatout(FName ClassName, ); ClassName은 내가 어떤 .uasset(클래스를 상속받은)의 Detail에 따라 설정해주면 된다 ex) CharacterBase, Hound, Bowman
5. 2번째 인자값에 맞는 오브젝트를 넣어야한다.
  - FOnGetDetailCustomizationInstance::CreateStatic(&A클래스::MakeInstance)
  - A클래스에 MakeInstance()함수 만들어야함
  - A클래스는 IDetailCustomization를 상속받아야함
  - A클래스에 void CustomizeDetails() 함수가 override 되어야함
    - 그럼 로드될때 CustomizeDetail()함수가 호출되며 이 함수 안에서 Slate or 틀 을 제작해주면 된다.

6. Slate or 틀 제작법은 2단계를 참조하면 편하고, 여기 사이트에 전반적인 내용이 있다.[참고 사이트](https://wiki.unrealengine.com/Customizing_detail_panels)
