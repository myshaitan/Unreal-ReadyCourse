#TableDataGenerator And TableTypeGenerator
####작성기간 : 2016.04.04
---
###TableTypeGenerator
1. 기획문서의 내용을 데이터화하기 위한 .h/.cpp파일을 자동화 생성해 준다.
2. 문서가 하나 늘어나면 클래스가 하나 더 생긴다.
3. 문서안에 칼럼이 하나 늘어나면 문서에 해당하는 클래스의 맴버변수가 하나 더 생긴다.
4. 문서안에 행이 하나 늘어나면 변화가 없다. ㅋ

###TableDataGenerator
1. 기획문서의 내용을 데이터화(메모리에 할당) 한다.
2. 문서안의 각 행마다 객체할당을 받고 그 객체를 관리하는 Container에 Add시킨다.
3. 키값을 통해서 해당하는 행을 찾아 참조할수 있다.
4. 정의될 클래스는 현재 프로젝트의 UDataDirector의 역할과 비슷할 수 있다.
5. UDataDirector 클래스는 이 클래스를 포함 또는 상속 또는 Wrap 될 것이다.
6. 이 클래스는 TableTypeGenerator에서 정의될 것이다.

###언리얼에 추가할 기능
1. 기획문서의 내용을 .uasset파일로 생성한다.
2. .uasset의 형태는 DataTable, Skill, Charater, Monster 등등 다양하게 존재할수 있다.
3. 위의 형태를 만족시키기 위해서는 각각의 클래스가 정의되어야 한다.
4. 위 작업은 에디터에서 제공해주는 기능이어야 한다.
  - 즉, 새로운 모듈 또는 플러그인 형태로 존재해야하며 게임 RunTime시에는 동작할 필요가 없다.
5. 처음에는 .csv파일을 읽어서 Create기능
  - Factory를 추가해야한다.
  - Asset화 시키는 것은 ImportAsset쪽을 참고한다.
6. 그다음은 .csv파일에 저장하는 기능
  - .uasset파일의 변경사항을 .csv파일에 반영되도록한다.
  - 근대 이거 잘될수 있을지가 걱정이다.
