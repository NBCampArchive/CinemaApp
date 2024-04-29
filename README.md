# Twelve Cinema
## ✏️ 프로젝트 개요

- ### 프로젝트명
  $Twelve Cinema$
- ### 프로젝트의 목적과 목표
  TheMovie DB API를 활용한 영화 앱 만들기
- ### 개발 기간
  '24.04.22(월) ~ 04.28(일)
- ### 참여 인원
  |<img src="https://avatars.githubusercontent.com/u/157277372?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/112539563?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/161591832?v=4" width="150" height="150"/>|<img src="https://avatars.githubusercontent.com/u/160442827?v=4" width="150" height="150"/>|
  |:-:|:-:|:-:|:-:|
  |Yurim<br/>[@yurim830](https://github.com/yurim830)|HyunRyeol Park<br/>[@devpark435](https://github.com/devpark435)|yejin<br/>[@yeggrrr](https://github.com/yeggrrr)|[@taeng-k](https://github.com/taeng-k)|
 
## 🌐 Stacks & Tools
### Develop
<div>
  <img src="https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=Swift&logoColor=white">
  <img src="https://img.shields.io/badge/uikit-2396F3?style=for-the-badge&logo=Swift&logoColor=white">
</div>

### Communication
<div>
  <img src="https://img.shields.io/badge/Github-181717?style=for-the-badge&logo=Github&logoColor=white">  
  <img src="https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white"> 
  <img src="https://img.shields.io/badge/Slack-4A154B?style=for-the-badge&logo=slack&logoColor=white">  
  <img src="https://img.shields.io/badge/Figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white">
</div>

## 📦 Packages
- ### Snapkit
    - 코드 기반의 **Auto Layout** 작성을 간편하게 하기 위해 사용했습니다.
- ### Then
    - **초기화 코드**를 간결하게 작성하기 위해 사용했습니다.
- ### Alamofire
    - **네트워크** 요청을 간편하고 직관적으로 처리하기 위해 사용했습니다.
- ### Kingfisher
    - **이미지 캐싱과 비동기 로딩**을 효과적으로 처리하기 위해 사용했습니다.
- ### Mapkit
    - **지도** 기능을 앱에 통합하고 위치 기반 서비스를 제공하기 위해 사용했습니다.
- ### FloatingPanel
    - 앱 내에서 **슬라이드 업 패널 UI**를 쉽게 구현하기 위해 사용했습니다.

## 📷 ScreenShot
|로그인|회원가입|영화검색|마이페이지|
|:-:|:-:|:-:|:-:|
|<img src="https://github.com/NBCampArchive/CinemaApp/assets/112539563/6f36d34a-7e36-4911-8bf6-1f6b6a5da893" width="150"/>|<img src="https://github.com/NBCampArchive/CinemaApp/assets/112539563/5f6a0983-b204-4b36-9633-585baf463ac7" width="150"/>|<img src="https://github.com/NBCampArchive/CinemaApp/assets/112539563/4e3d7510-eb46-4852-87b9-5a05f433258d" width="150"/>|<img src="https://github.com/NBCampArchive/CinemaApp/assets/112539563/54d8495d-1cf9-4402-bb64-a2cc8f9712d6" width="150"/>|
|영화목록|영화상세|영화예매|지도|
|<img src="https://github.com/NBCampArchive/CinemaApp/assets/112539563/6a4256ce-9f8b-4935-ac5c-1895b971f53e" width="150"/>|<img src="https://github.com/NBCampArchive/CinemaApp/assets/112539563/ff179e1f-0238-41db-baff-7b52675a6810" width="150"/>|<img src="https://github.com/NBCampArchive/CinemaApp/assets/112539563/fd289ea2-c7c2-441b-8fb2-afe0d3817476" width="150"/>|<img src="https://github.com/NBCampArchive/CinemaApp/assets/112539563/f06cdb30-6703-46dc-b023-d0579b2a8130" width="150"/>|


## 📁 Project Directory Tree
  ```
  📦 
  ├─ CinemaApp
  │  ├─ AppDelegate.swift
  │  ├─ Info.plist
  │  ├─ Model
  │  │  ├─ MovieList
  │  │  │  ├─ LikedMovie.swift
  │  │  │  ├─ MovieDetail.swift
  │  │  │  ├─ MovieListResponse.swift
  │  │  │  └─ Reservation.swift
  │  │  ├─ MyPage
  │  │  │  └─ MyPageCellType.swift
  │  │  └─ SearchMovie
  │  │     ├─ Genre.swift
  │  │     └─ Movie.swift
  │  ├─ Network
  │  │  └─ MovieList
  │  │     └─ MovieListApiManager.swift
  │  ├─ Presentation
  │  │  ├─ BottomTab
  │  │  │  ├─ BottomTab.storyboard
  │  │  │  └─ BottomTabController.swift
  │  │  ├─ Map
  │  │  │  ├─ MovieMap.storyboard
  │  │  │  ├─ MovieMapFloatingPanel.swift
  │  │  │  └─ MovieMapViewController.swift
  │  │  ├─ MovieDetails
  │  │  │  ├─ StoryBoard
  │  │  │  │  └─ MovieDetails.storyboard
  │  │  │  └─ ViewController
  │  │  │     ├─ MovieDetailsViewController.swift
  │  │  │     └─ ReservationViewController.swift
  │  │  ├─ MovieList
  │  │  │  ├─ StoryBoard
  │  │  │  │  └─ Base.lproj
  │  │  │  │     └─ MovieList.storyboard
  │  │  │  ├─ View
  │  │  │  │  └─ MovieCollectionViewCell.swift
  │  │  │  └─ ViewController
  │  │  │     └─ MovieListViewController.swift
  │  │  ├─ MyPage
  │  │  │  ├─ StoryBoard
  │  │  │  │  ├─ LikeMovie.storyboard
  │  │  │  │  ├─ MyPage.storyboard
  │  │  │  │  └─ ReservationList.storyboard
  │  │  │  ├─ View
  │  │  │  │  ├─ LikeMovieTableCell.swift
  │  │  │  │  ├─ MyProfileTableViewCell.swift
  │  │  │  │  ├─ ReservationListViewCell.swift
  │  │  │  │  └─ myMenuTableViewCell.swift
  │  │  │  └─ ViewController
  │  │  │     ├─ LikeMovieViewController.swift
  │  │  │     ├─ MyPageViewController.swift
  │  │  │     └─ ReservationListViewController.swift
  │  │  ├─ SearchMovie
  │  │  │  ├─ Cell
  │  │  │  │  └─ MovieListCollectionViewCell.swift
  │  │  │  ├─ StoryBoard
  │  │  │  │  └─ SearchMovie.storyboard
  │  │  │  └─ ViewController
  │  │  │     └─ SerachMovieViewController.swift
  │  │  └─ login
  │  │     ├─ StoryBoard
  │  │     │  └─ Login.storyboard
  │  │     └─ ViewController
  │  │        ├─ EasyAlert.swift
  │  │        ├─ LoginNotificationCenter.swift
  │  │        ├─ LoginStatus.swift
  │  │        ├─ LoginViewController.swift
  └─ └─       └─ RegisterViewController.swift
  
  ```


## 🎥 YouTube
[![YouTube](https://github.com/NBCampArchive/CinemaApp/assets/112539563/c345f731-0071-4d39-a682-376e5c8edca4)](https://www.youtube.com/watch?v=CUdNbOpRV14)
