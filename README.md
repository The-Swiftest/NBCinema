# NBCinema
NBCinema는 TMDB API를 활용한 영화 정보 및 예매 서비스를 제공하는 iOS 앱입니다.

## 🗓️ 프로젝트 기간
2025년 7월 15일 ~ 7월 22일

## 📱 주요 기능

- **로그인/회원가입**: Keychain 기반 사용자 인증, 자동 로그인 지원
- **영화 목록**: 현재 상영작, 인기 영화, 개봉 예정, 높은 평점 섹션별 표시
- **영화 검색**: 제목 검색 및 장르별 필터링
- **영화 상세**: 포스터, 줄거리, 감독/출연진, 평점 등 상세 정보 제공
- **찜하기 기능**: Realm 기반 로컬 저장소를 통한 찜한 영화 관리
- **영화 예매**: 날짜/시간/인원을 통한 예매 시스템
- **마이페이지**: 찜한 영화, 예매 내역 관리 및 로그아웃

## 🏗️ 아키텍처

### MVVM-C (Model-View-ViewModel-Coordinator) 패턴

```
AppCoordinator (루트)
├── AuthCoordinator (로그인/회원가입)
└── MainTabCoordinator (탭 기반 메인 화면)
    ├── MovieListCoordinator ↔ MovieListViewController/ViewModel
    │   └── MovieDetailCoordinator ↔ MovieDetailViewController/ViewModel
    ├── SearchCoordinator ↔ SearchViewController/ViewModel
    └── MyPageCoordinator ↔ MyPageViewController/ViewModel
```

#### 주요 설계 원칙
- **Coordinator Pattern**: 화면 전환과 의존성 주입 담당
- **MVVM**: 단방향 데이터 플로우 (Action → ViewModel → State → View)
- **Repository Pattern**: 네트워크와 로컬 데이터 추상화
- **Protocol 기반 설계**: ViewModelProtocol을 통한 일관된 구조
- **API 계층 분리**: Enum 기반 API EndPoint 관리

#### 주요 컴포넌트 역할
**App Layer**
- `AppCoordinator`: 앱 전체 네비게이션 관리
- `SceneDelegate`: 앱 생명주기 및 초기 설정

**Data Layer**
- `NetworkClient`: URLSession 기반 HTTP 클라이언트
- `MovieRepository`: TMDB API 추상화
- `KeychainService`: 로그인 정보 보안 저장
- `UserActivityService`: 사용자 활동 데이터 관리

**Domain Layer**

- `Movie`: 영화 기본 정보 엔티티
- `MovieDetail`: 영화 상세 정보 엔티티
- `ReservationDetail`: 예매 정보 엔티티
- `FavoriteMovie`: 찜한 영화 엔티티

**Presentation Layer**

- `ViewControllers`: 화면 표시 및 사용자 입력 처리
- `ViewModels`: 비즈니스 로직 및 상태 관리
- `Custom Components`: 재사용 가능한 UI 컴포넌트



## 📁 프로젝트 구조

```
NBCinema/
├── App/                          # 앱 설정 및 Coordinator
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   ├── Config.swift
│   └── Coordinator/              # 화면 전환 관리
│       ├── AppCoordinator.swift
│       ├── AuthCoordinator.swift
│       ├── MainTabCoordinator.swift
│       └── ...
├── Data/                         # 데이터 레이어
│   ├── Network/                  # API 통신
│   ├── Repository/               # 데이터 소스 관리
│   ├── KeyChain/                 # 보안 저장소
│   └── UserActivity/             # 사용자 활동 관리
├── Domain/                       # 도메인 레이어
│   └── Entities/                 # 도메인 엔티티
│       ├── Movie.swift
│       ├── MovieDetail.swift
│       └── ...
├── Presentation/                 # 프레젠테이션 레이어
│   ├── Auth/                     # 인증 화면
│   ├── Movie/                    # 영화 관련 화면
│   ├── Search/                   # 검색 화면
│   ├── MyPage/                   # 마이페이지
│   ├── Reserve/                  # 예매 화면
│   ├── Component/                # 공통 UI 컴포넌트
│   └── Base/                     # 기본 프로토콜
├── Resources/                    # 리소스 파일
│   ├── Assets.xcassets
│   └── MockData.swift
└── Utils/                        # 유틸리티
    └── Extensions/               # Swift 확장
```

## 🏃 역할 분담
|      팀원      | 역할                                                       |
|---------------|------------------------------------------------------------|
|     박주하     |     UI 디자인, 로그인/회원가입 기능 구현, 영화 검색 기능 구현 (Login, SignUp, Search)     |
|     양지영     |     아키텍처 설계, 네트워크 통신, Coordinator 패턴, 영화 목록/상세 구현 (MVVM-C, Network, Repository, MovieList, MovieDetail)     |
|     조성준     |     마이 페이지/영화 예매 페이지 구현, 찜하기 기능 구현, 로컬 저장(Realm, Keychain) 관련 기능 작업, TabBar, 상단바 구현     |


## 🛠️ 기술 스택
- Swift 5
- UIKit
- SnapKit
- Then
- Kingfisher
- RealmSwift
- MVVM-C + Repository Pattern
- TMDB API
- URLSession + async/await