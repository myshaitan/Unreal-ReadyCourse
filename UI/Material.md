# UI에서 사용할 Material을 편집해본다.
#### 작성기간 : 2016.04.18
---
###Atlas 이용
1.TextureCropping()를 사용하여 자르기를 한다.
2.UVs 값을 정해줘야하는 데 필요한 위치를 알아 오기 위해서는 TextureCoordiate를 조합해야한다.
  - Mutilply함수로 자를 크기를 정해주고 Add함수로 좌상단 위치를 정해준다.
3.오파시티 값을 정해주기 위해서 CropUVs를 이용해 Texture Sample를 잘라내서 A(알파)값만 넣어준다.
  - 이상하게 TextureObject는 알파값이 없다.
  
###Material Instance 이용
1.원본 Material에 인스턴스 생성을 통해서 만든다.
2.Instance로 생성된 Material은 부모의 파마리터를 수정하여 적용할수 있다.
3.Instance의 이용은 속도상 이점이 있다.
  - 쉐이더의 컴파일이 원본 Material만 이루어 지면 되기 때문이다.
  - 작업에 있어서 반복 작업을 줄이는 이점도 있다.
