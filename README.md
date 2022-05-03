# MetaWeather

## 1. 시뮬레이터 실행 화면

#### iPhone 13 mini

<img src="https://user-images.githubusercontent.com/61342175/166468144-867bfae6-d0e7-42da-b7f1-b89d8a5f2a54.gif" width = 250 align = left>  

#### iPhone 13

<img src="https://user-images.githubusercontent.com/61342175/166468451-c75a3636-8f17-4133-b865-13b14a4c6451.gif" width = 250 align = left>  

#### iPhone 13 Pro Max

스토리보드에서 아이폰 13 프로 맥스를 선택하지 않으면, 왼쪽 두 번째 경계선이 두 줄로 나옵니다.

<img src="https://user-images.githubusercontent.com/61342175/166468529-5cdba98f-f0c5-486d-98f5-6622a73dd8e8.gif" width = 250 align = left>

## 2. 아키텍처 관련

1. 네트워크 레이어 및 데이터 레이어에서 데이터 요청 및 도메인 변환을 위한 DTO(Data Transfer Object)가 있습니다.
2. 작은 규모의 프로젝트이기 때문에 MVC로도 충분하지만, MVVM으로 구현했으며 UseCase 레이어가 있습니다. 레포지토리 패턴이나 코디네이터 패턴까지 활용하지는 않았습니다.
3. Observable 객체를 만들어 binding하고 있습니다.

## 3. 커스텀 뷰

1. WeatherInformationTableHeaderView

테이블뷰의 헤더를 나타내기 위한 커스텀 뷰입니다.

2. WeatherInformationView

오늘 및 내일 날씨의 정보를 표현할 수 있는 커스텀 뷰입니다.

3. CustomImageView

테이블뷰 셀에서 표시되는 이미지(네트워크를 통한 이미지)의 깜빡임 및 정확한 이미지를 나타내지 않는 것을 방지하기 위해 캐시를 활용하는 커스텀 뷰입니다.
