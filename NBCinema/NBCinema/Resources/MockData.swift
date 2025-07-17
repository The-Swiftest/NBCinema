//
//  MockData.swift
//  NBCinema
//
//  Created by Milou on 7/17/25.
//

import Foundation

/// 목데이터 정의
enum MockData {

    // MARK: - 영화 기본 정보 (Movie)
    // 실제 TMDB popularity와 유사한 높은 값 포함
    static let mockMovie1 = Movie(id: 1, title: "킹 오브 킹스", posterPath: "/eU0Kx4WpXfV20oXf5Q9pYjK7M.jpg", popularity: 875.0, voteAverage: 9.9)
    static let mockMovie2 = Movie(id: 2, title: "어벤져스: 엔드게임", posterPath: "/mock_poster_2.jpg", popularity: 9520.0, voteAverage: 8.4)
    static let mockMovie3 = Movie(id: 3, title: "탑건: 매버릭", posterPath: "/mock_poster_3.jpg", popularity: 897.0, voteAverage: 8.2)
    static let mockMovie4 = Movie(id: 4, title: "스파이더맨: 노 웨이 홈", posterPath: "/mock_poster_4.jpg", popularity: 9210.0, voteAverage: 8.5)
    static let mockMovie5 = Movie(id: 5, title: "토르: 러브 앤 썬더", posterPath: "/mock_poster_5.jpg", popularity: 783.0, voteAverage: 7.1)
    static let mockMovie6 = Movie(id: 6, title: "닥터 스트레인지 2", posterPath: "/mock_poster_6.jpg", popularity: 846.0, voteAverage: 7.8)
    static let mockMovie7 = Movie(id: 7, title: "블랙 위도우", posterPath: "/mock_poster_7.jpg", popularity: 769.0, voteAverage: 7.5)
    static let mockMovie8 = Movie(id: 8, title: "미션 임파서블 7", posterPath: "/mock_poster_8.jpg", popularity: 884.0, voteAverage: 8.1)
    static let mockMovie9 = Movie(id: 9, title: "패스트 앤 퓨리어스 10", posterPath: "/mock_poster_9.jpg", popularity: 827.0, voteAverage: 7.3)
    static let mockMovie10 = Movie(id: 10, title: "존 윅 4", posterPath: "/mock_poster_10.jpg", popularity: 902.0, voteAverage: 8.6)
    
    static let mockMovie11 = Movie(id: 11, title: "아바타: 물의 길", posterPath: "/mock_poster_11.jpg", popularity: 9850.0, voteAverage: 8.9)
    static let mockMovie12 = Movie(id: 12, title: "타이타닉", posterPath: "/mock_poster_12.jpg", popularity: 9470.0, voteAverage: 8.7)
    static let mockMovie13 = Movie(id: 13, title: "스타워즈: 새로운 희망", posterPath: "/mock_poster_13.jpg", popularity: 9130.0, voteAverage: 8.8)
    static let mockMovie14 = Movie(id: 14, title: "해리포터와 마법사의 돌", posterPath: "/mock_poster_14.jpg", popularity: 896.0, voteAverage: 8.3)
    static let mockMovie15 = Movie(id: 15, title: "반지의 제왕: 왕의 귀환", posterPath: "/mock_poster_15.jpg", popularity: 9320.0, voteAverage: 9.1)
    static let mockMovie16 = Movie(id: 16, title: "인터스텔라", posterPath: "/mock_poster_16.jpg", popularity: 879.0, voteAverage: 8.6)
    static let mockMovie17 = Movie(id: 17, title: "인셉션", posterPath: "/mock_poster_17.jpg", popularity: 864.0, voteAverage: 8.8)
    static let mockMovie18 = Movie(id: 18, title: "다크 나이트", posterPath: "/mock_poster_18.jpg", popularity: 9280.0, voteAverage: 9.0)
    static let mockMovie19 = Movie(id: 19, title: "펄프 픽션", posterPath: "/mock_poster_19.jpg", popularity: 851.0, voteAverage: 8.9)
    static let mockMovie20 = Movie(id: 20, title: "쇼생크 탈출", posterPath: "/mock_poster_20.jpg", popularity: 9430.0, voteAverage: 9.3)
    
    static let mockMovie21 = Movie(id: 21, title: "가디언즈 오브 갤럭시 3", posterPath: "/mock_poster_21.jpg", popularity: 857.0, voteAverage: 8.2)
    static let mockMovie22 = Movie(id: 22, title: "플래시", posterPath: "/mock_poster_22.jpg", popularity: 794.0, voteAverage: 7.6)
    static let mockMovie23 = Movie(id: 23, title: "인디아나 존스 5", posterPath: "/mock_poster_23.jpg", popularity: 821.0, voteAverage: 7.8)
    static let mockMovie24 = Movie(id: 24, title: "트랜스포머: 라이즈 오브 더 비스트", posterPath: "/mock_poster_24.jpg", popularity: 768.0, voteAverage: 7.2)
    static let mockMovie25 = Movie(id: 25, title: "쥬라기 월드: 도미니언", posterPath: "/mock_poster_25.jpg", popularity: 815.0, voteAverage: 7.4)
    static let mockMovie26 = Movie(id: 26, title: "블랙 아담", posterPath: "/mock_poster_26.jpg", popularity: 789.0, voteAverage: 7.1)
    static let mockMovie27 = Movie(id: 27, title: "원더우먼 3", posterPath: "/mock_poster_27.jpg", popularity: 836.0, voteAverage: 7.9)
    static let mockMovie28 = Movie(id: 28, title: "배트맨 2", posterPath: "/mock_poster_28.jpg", popularity: 872.0, voteAverage: 8.3)
    static let mockMovie29 = Movie(id: 29, title: "아쿠아맨 2", posterPath: "/mock_poster_29.jpg", popularity: 804.0, voteAverage: 7.5)
    static let mockMovie30 = Movie(id: 30, title: "캡틴 마블 2", posterPath: "/mock_poster_30.jpg", popularity: 841.0, voteAverage: 7.7)
    
    static let mockMovie31 = Movie(id: 31, title: "시민 케인", posterPath: "/mock_poster_31.jpg", popularity: 897.0, voteAverage: 9.5)
    static let mockMovie32 = Movie(id: 32, title: "카사블랑카", posterPath: "/mock_poster_32.jpg", popularity: 872.0, voteAverage: 9.4)
    static let mockMovie33 = Movie(id: 33, title: "대부", posterPath: "/mock_poster_33.jpg", popularity: 918.0, voteAverage: 9.6)
    static let mockMovie34 = Movie(id: 34, title: "대부 2", posterPath: "/mock_poster_34.jpg", popularity: 903.0, voteAverage: 9.5)
    static let mockMovie35 = Movie(id: 35, title: "위대한 개츠비", posterPath: "/mock_poster_35.jpg", popularity: 856.0, voteAverage: 9.2)
    static let mockMovie36 = Movie(id: 36, title: "로마의 휴일", posterPath: "/mock_poster_36.jpg", popularity: 839.0, voteAverage: 9.1)
    static let mockMovie37 = Movie(id: 37, title: "버티고", posterPath: "/mock_poster_37.jpg", popularity: 864.0, voteAverage: 9.3)
    static let mockMovie38 = Movie(id: 38, title: "사운드 오브 뮤직", posterPath: "/mock_poster_38.jpg", popularity: 827.0, voteAverage: 9.0)
    static let mockMovie39 = Movie(id: 39, title: "바람과 함께 사라지다", posterPath: "/mock_poster_39.jpg", popularity: 881.0, voteAverage: 9.4)
    static let mockMovie40 = Movie(id: 40, title: "선라이즈", posterPath: "/mock_poster_40.jpg", popularity: 845.0, voteAverage: 9.2)
    
    // MARK: - 현재 상영중 영화
    static let nowPlayingMovies: [Movie] = [
        mockMovie1, mockMovie2, mockMovie3, mockMovie4, mockMovie5,
        mockMovie6, mockMovie7, mockMovie8, mockMovie9, mockMovie10
    ]

    // MARK: - 인기 영화
    static let popularMovies: [Movie] = [
        mockMovie11, mockMovie12, mockMovie13, mockMovie14, mockMovie15,
        mockMovie16, mockMovie17, mockMovie18, mockMovie19, mockMovie20
    ]

    // MARK: - 개봉 예정 영화
    static let upcomingMovies: [Movie] = [
        mockMovie21, mockMovie22, mockMovie23, mockMovie24, mockMovie25,
        mockMovie26, mockMovie27, mockMovie28, mockMovie29, mockMovie30
    ]

    // MARK: - 높은 평점 영화
    static let topRatedMovies: [Movie] = [
        mockMovie31, mockMovie32, mockMovie33, mockMovie34, mockMovie35,
        mockMovie36, mockMovie37, mockMovie38, mockMovie39, mockMovie40
    ]

    // MARK: - 전체 영화 목록 (검색용)
    static let allMovies: [Movie] = nowPlayingMovies + popularMovies + upcomingMovies + topRatedMovies

    // MARK: - 장르 목록
    static let genres: [Genre] = [
        Genre(id: 28, name: "액션"),
        Genre(id: 12, name: "모험"),
        Genre(id: 16, name: "애니메이션"),
        Genre(id: 35, name: "코미디"),
        Genre(id: 80, name: "범죄"),
        Genre(id: 99, name: "다큐멘터리"),
        Genre(id: 18, name: "드라마"),
        Genre(id: 10751, name: "가족"),
        Genre(id: 14, name: "판타지"),
        Genre(id: 36, name: "역사"),
        Genre(id: 27, name: "공포"),
        Genre(id: 10402, name: "음악"),
        Genre(id: 9648, name: "미스터리"),
        Genre(id: 10749, name: "로맨스"),
        Genre(id: 878, name: "SF"),
        Genre(id: 10770, name: "TV 영화"),
        Genre(id: 53, name: "스릴러"),
        Genre(id: 10752, name: "전쟁"),
        Genre(id: 37, name: "서부")
    ]

    // MARK: - 영화 상세 정보 (모든 mockMovie ID에 대응하도록 추가)
    static let movieDetails: [MovieDetail] = [
        MovieDetail(
            id: 1, title: "킹 오브 킹스", posterPath: "/mock_poster_1.jpg", backdropPath: "/mock_backdrop_1.jpg",
            releaseDate: "2025-07-16", popularity: 875.0, voteAverage: 9.9, runtime: 140,
            overview: "어린 시절 고양이로 변신하는 능력을 얻은 주인공의 모험을 그린 감동적인 이야기입니다. 가족과 우정, 그리고 성장을 다룬 따뜻한 영화입니다.",
            genres: [Genre(id: 28, name: "액션"), Genre(id: 16, name: "애니메이션")]
        ),
        MovieDetail(
            id: 2, title: "어벤져스: 엔드게임", posterPath: "/mock_poster_2.jpg", backdropPath: "/mock_backdrop_2.jpg",
            releaseDate: "2019-04-24", popularity: 9520.0, voteAverage: 8.4, runtime: 181,
            overview: "타노스에 의해 절반의 생명이 사라진 지 5년 후, 어벤져스가 우주의 균형을 되돌리기 위해 최후의 전투를 벌이는 이야기입니다.",
            genres: [Genre(id: 28, name: "액션"), Genre(id: 12, name: "모험"), Genre(id: 878, name: "SF")]
        ),
        MovieDetail(
            id: 3, title: "탑건: 매버릭", posterPath: "/mock_poster_3.jpg", backdropPath: "/mock_backdrop_3.jpg",
            releaseDate: "2022-05-24", popularity: 897.0, voteAverage: 8.2, runtime: 130,
            overview: "최고의 파일럿 매버릭이 차세대 파일럿들을 훈련시키며 펼치는 스카이 액션 드라마입니다.",
            genres: [Genre(id: 28, name: "액션"), Genre(id: 18, name: "드라마")]
        ),
        MovieDetail(
            id: 4, title: "스파이더맨: 노 웨이 홈", posterPath: "/mock_poster_4.jpg", backdropPath: "/mock_backdrop_4.jpg",
            releaseDate: "2021-12-15", popularity: 9210.0, voteAverage: 8.5, runtime: 148,
            overview: "정체가 탄로난 스파이더맨 '피터 파커'가 시공간을 넘어 빌런들과 조우하며 벌어지는 일들을 그린 영화.",
            genres: [Genre(id: 28, name: "액션"), Genre(id: 12, name: "모험"), Genre(id: 878, name: "SF")]
        ),
        MovieDetail(
            id: 5, title: "토르: 러브 앤 썬더", posterPath: "/mock_poster_5.jpg", backdropPath: "/mock_backdrop_5.jpg",
            releaseDate: "2022-07-06", popularity: 783.0, voteAverage: 7.1, runtime: 119,
            overview: "토르와 제인 포스터, 그리고 발키리가 고르라는 새로운 위협에 맞서는 이야기.",
            genres: [Genre(id: 28, name: "액션"), Genre(id: 12, name: "모험"), Genre(id: 35, name: "코미디")]
        ),
        MovieDetail(
            id: 6, title: "닥터 스트레인지 2", posterPath: "/mock_poster_6.jpg", backdropPath: "/mock_backdrop_6.jpg",
            releaseDate: "2022-05-04", popularity: 846.0, voteAverage: 7.8, runtime: 126,
            overview: "닥터 스트레인지가 멀티버스 세계를 탐험하며 예상치 못한 위기에 빠지는 이야기.",
            genres: [Genre(id: 14, name: "판타지"), Genre(id: 27, name: "공포"), Genre(id: 878, name: "SF")]
        ),
        MovieDetail(
            id: 7, title: "블랙 위도우", posterPath: "/mock_poster_7.jpg", backdropPath: "/mock_backdrop_7.jpg",
            releaseDate: "2021-07-07", popularity: 769.0, voteAverage: 7.5, runtime: 134,
            overview: "블랙 위도우 나타샤 로마노프의 과거와 그녀가 어떻게 복수자로 변모했는지를 그린 이야기.",
            genres: [Genre(id: 28, name: "액션"), Genre(id: 12, name: "모험"), Genre(id: 878, name: "SF")]
        ),
        MovieDetail(
            id: 8, title: "미션 임파서블 7", posterPath: "/mock_poster_8.jpg", backdropPath: "/mock_backdrop_8.jpg",
            releaseDate: "2023-07-12", popularity: 884.0, voteAverage: 8.1, runtime: 163,
            overview: "이단 헌트와 그의 팀이 인류를 위협하는 새로운 무기를 추적하며 펼치는 액션 블록버스터.",
            genres: [Genre(id: 28, name: "액션"), Genre(id: 12, name: "모험"), Genre(id: 53, name: "스릴러")]
        ),
        MovieDetail(
            id: 9, title: "패스트 앤 퓨리어스 10", posterPath: "/mock_poster_9.jpg", backdropPath: "/mock_backdrop_9.jpg",
            releaseDate: "2023-05-17", popularity: 827.0, voteAverage: 7.3, runtime: 141,
            overview: "돔 토레토와 그의 패밀리가 새로운 위협에 맞서 싸우는 이야기.",
            genres: [Genre(id: 28, name: "액션"), Genre(id: 80, name: "범죄"), Genre(id: 53, name: "스릴러")]
        ),
        MovieDetail(
            id: 10, title: "존 윅 4", posterPath: "/mock_poster_10.jpg", backdropPath: "/mock_backdrop_10.jpg",
            releaseDate: "2023-03-22", popularity: 902.0, voteAverage: 8.6, runtime: 169,
            overview: "존 윅이 전 세계 암살자들의 표적이 된 가운데, 자유를 얻기 위한 최후의 전쟁을 시작한다.",
            genres: [Genre(id: 28, name: "액션"), Genre(id: 53, name: "스릴러"), Genre(id: 80, name: "범죄")]
        ),
        MovieDetail(
            id: 11, title: "아바타: 물의 길", posterPath: "/mock_poster_11.jpg", backdropPath: "/mock_backdrop_11.jpg",
            releaseDate: "2022-12-14", popularity: 9850.0, voteAverage: 8.9, runtime: 192,
            overview: "판도라 행성에서 '제이크 설리'와 '네이티리'가 가족을 이루며 겪게 되는 갈등과 그들이 살아남기 위해 싸우는 이야기.",
            genres: [Genre(id: 878, name: "SF"), Genre(id: 12, name: "모험"), Genre(id: 14, name: "판타지")]
        ),
        MovieDetail(
            id: 12, title: "타이타닉", posterPath: "/mock_poster_12.jpg", backdropPath: "/mock_backdrop_12.jpg",
            releaseDate: "1997-12-19", popularity: 9470.0, voteAverage: 8.7, runtime: 194,
            overview: "호화 유람선 타이타닉호의 침몰 사고를 배경으로 한 잭과 로즈의 비극적인 사랑 이야기.",
            genres: [Genre(id: 18, name: "드라마"), Genre(id: 10749, name: "로맨스")]
        ),
        MovieDetail(
            id: 13, title: "스타워즈: 새로운 희망", posterPath: "/mock_poster_13.jpg", backdropPath: "/mock_backdrop_13.jpg",
            releaseDate: "1977-05-25", popularity: 9130.0, voteAverage: 8.8, runtime: 121,
            overview: "은하 제국에 맞서 싸우는 반란군과 제다이 기사의 모험을 그린 SF 서사극.",
            genres: [Genre(id: 878, name: "SF"), Genre(id: 12, name: "모험")]
        ),
        MovieDetail(
            id: 14, title: "해리포터와 마법사의 돌", posterPath: "/mock_poster_14.jpg", backdropPath: "/mock_backdrop_14.jpg",
            releaseDate: "2001-11-16", popularity: 896.0, voteAverage: 8.3, runtime: 152,
            overview: "어머니와 아버지를 잃은 후 외로운 삶을 살던 해리포터가 마법 세계로 들어서며 겪는 이야기.",
            genres: [Genre(id: 14, name: "판타지"), Genre(id: 10751, name: "가족")]
        ),
        MovieDetail(
            id: 15, title: "반지의 제왕: 왕의 귀환", posterPath: "/mock_poster_15.jpg", backdropPath: "/mock_backdrop_15.jpg",
            releaseDate: "2003-12-17", popularity: 9320.0, voteAverage: 9.1, runtime: 201,
            overview: "절대반지를 파괴하기 위한 여정의 마지막 장. 프로도와 샘이 모험을 끝내기 위해 모르도르로 향한다.",
            genres: [Genre(id: 12, name: "모험"), Genre(id: 14, name: "판타지")]
        ),
        MovieDetail(
            id: 16, title: "인터스텔라", posterPath: "/mock_poster_16.jpg", backdropPath: "/mock_backdrop_16.jpg",
            releaseDate: "2014-11-05", popularity: 879.0, voteAverage: 8.6, runtime: 169,
            overview: "인류의 마지막 희망을 찾아 우주로 떠나는 탐험대의 이야기.",
            genres: [Genre(id: 878, name: "SF"), Genre(id: 18, name: "드라마")]
        ),
        MovieDetail(
            id: 17, title: "인셉션", posterPath: "/mock_poster_17.jpg", backdropPath: "/mock_backdrop_17.jpg",
            releaseDate: "2010-07-16", popularity: 864.0, voteAverage: 8.8, runtime: 148,
            overview: "꿈속에서 꿈을 훔치는 특수 요원 코브가 마지막 임무를 수행하는 이야기.",
            genres: [Genre(id: 28, name: "액션"), Genre(id: 878, name: "SF"), Genre(id: 53, name: "스릴러")]
        ),
        MovieDetail(
            id: 18, title: "다크 나이트", posterPath: "/mock_poster_18.jpg", backdropPath: "/mock_backdrop_18.jpg",
            releaseDate: "2008-07-16", popularity: 9280.0, voteAverage: 9.0, runtime: 152,
            overview: "고담시의 영웅 배트맨이 조커라는 새로운 악당과 맞서 싸우는 이야기.",
            genres: [Genre(id: 28, name: "액션"), Genre(id: 80, name: "범죄"), Genre(id: 18, name: "드라마")]
        ),
        MovieDetail(
            id: 19, title: "펄프 픽션", posterPath: "/mock_poster_19.jpg", backdropPath: "/mock_backdrop_19.jpg",
            releaseDate: "1994-10-14", popularity: 851.0, voteAverage: 8.9, runtime: 154,
            overview: "세 개의 서로 다른 범죄 이야기가 복잡하게 얽히면서 벌어지는 사건들을 그린 영화.",
            genres: [Genre(id: 80, name: "범죄"), Genre(id: 18, name: "드라마")]
        ),
        MovieDetail(
            id: 20, title: "쇼생크 탈출", posterPath: "/mock_poster_20.jpg", backdropPath: "/mock_backdrop_20.jpg",
            releaseDate: "1994-09-23", popularity: 9430.0, voteAverage: 9.3, runtime: 142,
            overview: "억울하게 수감된 앤디 듀프레인이 쇼생크 교도소에서 희망을 찾아가는 이야기.",
            genres: [Genre(id: 18, name: "드라마")]
        ),
        MovieDetail(
            id: 21, title: "가디언즈 오브 갤럭시 3", posterPath: "/mock_poster_21.jpg", backdropPath: "/mock_backdrop_21.jpg",
            releaseDate: "2023-05-03", popularity: 857.0, voteAverage: 8.2, runtime: 150,
            overview: "가디언즈 팀이 로켓의 과거와 관련된 미스터리를 풀기 위해 우주를 여행하는 이야기.",
            genres: [Genre(id: 28, name: "액션"), Genre(id: 12, name: "모험"), Genre(id: 35, name: "코미디")]
        ),
        MovieDetail(
            id: 22, title: "플래시", posterPath: "/mock_poster_22.jpg", backdropPath: "/mock_backdrop_22.jpg",
            releaseDate: "2023-06-16", popularity: 794.0, voteAverage: 7.6, runtime: 144,
            overview: "시간 여행을 통해 과거를 바꾸려는 플래시가 예상치 못한 결과를 초래하며 벌어지는 이야기.",
            genres: [Genre(id: 28, name: "액션"), Genre(id: 12, name: "모험"), Genre(id: 878, name: "SF")]
        ),
        MovieDetail(
            id: 23, title: "인디아나 존스 5", posterPath: "/mock_poster_23.jpg", backdropPath: "/mock_backdrop_23.jpg",
            releaseDate: "2023-06-30", popularity: 821.0, voteAverage: 7.8, runtime: 154,
            overview: "전설적인 고고학자 인디아나 존스가 새로운 모험에 나서는 이야기.",
            genres: [Genre(id: 12, name: "모험"), Genre(id: 28, name: "액션")]
        ),
        MovieDetail(
            id: 24, title: "트랜스포머: 라이즈 오브 더 비스트", posterPath: "/mock_poster_24.jpg", backdropPath: "/mock_backdrop_24.jpg",
            releaseDate: "2023-06-09", popularity: 768.0, voteAverage: 7.2, runtime: 127,
            overview: "오토봇과 새로운 로봇 종족 맥시멀이 고대 전쟁에 휘말리며 지구를 구하는 이야기.",
            genres: [Genre(id: 878, name: "SF"), Genre(id: 28, name: "액션")]
        ),
        MovieDetail(
            id: 25, title: "쥬라기 월드: 도미니언", posterPath: "/mock_poster_25.jpg", backdropPath: "/mock_backdrop_25.jpg",
            releaseDate: "2022-06-10", popularity: 815.0, voteAverage: 7.4, runtime: 147,
            overview: "공룡들이 전 세계로 퍼져나간 후, 인간과 공룡이 공존하는 세상에서 벌어지는 이야기.",
            genres: [Genre(id: 12, name: "모험"), Genre(id: 878, name: "SF")]
        ),
        MovieDetail(
            id: 26, title: "블랙 아담", posterPath: "/mock_poster_26.jpg", backdropPath: "/mock_backdrop_26.jpg",
            releaseDate: "2022-10-21", popularity: 789.0, voteAverage: 7.1, runtime: 124,
            overview: "고대 칸다크의 영웅 블랙 아담이 현대에 깨어나 정의를 실현하는 이야기.",
            genres: [Genre(id: 28, name: "액션"), Genre(id: 14, name: "판타지")]
        ),
        MovieDetail(
            id: 27, title: "원더우먼 3", posterPath: "/mock_poster_27.jpg", backdropPath: "/mock_backdrop_27.jpg",
            releaseDate: "2025-07-17", popularity: 836.0, voteAverage: 7.9, runtime: 150,
            overview: "원더우먼 다이애나 프린스가 새로운 위협으로부터 세상을 구하는 이야기.",
            genres: [Genre(id: 28, name: "액션"), Genre(id: 14, name: "판타지")]
        ),
        MovieDetail(
            id: 28, title: "배트맨 2", posterPath: "/mock_poster_28.jpg", backdropPath: "/mock_backdrop_28.jpg",
            releaseDate: "2025-07-17", popularity: 872.0, voteAverage: 8.3, runtime: 180,
            overview: "고담시를 지키는 배트맨의 새로운 모험과 빌런과의 대결.",
            genres: [Genre(id: 28, name: "액션"), Genre(id: 80, name: "범죄"), Genre(id: 18, name: "드라마")]
        ),
        MovieDetail(
            id: 29, title: "아쿠아맨 2", posterPath: "/mock_poster_29.jpg", backdropPath: "/mock_backdrop_29.jpg",
            releaseDate: "2023-12-20", popularity: 804.0, voteAverage: 7.5, runtime: 124,
            overview: "아쿠아맨 아서 커리가 심해의 위협으로부터 아틀란티스를 지키는 이야기.",
            genres: [Genre(id: 28, name: "액션"), Genre(id: 14, name: "판타지"), Genre(id: 12, name: "모험")]
        ),
        MovieDetail(
            id: 30, title: "캡틴 마블 2", posterPath: "/mock_poster_30.jpg", backdropPath: "/mock_backdrop_30.jpg",
            releaseDate: "2023-11-10", popularity: 841.0, voteAverage: 7.7, runtime: 105,
            overview: "캡틴 마블 캐럴 댄버스가 새로운 팀과 함께 우주를 수호하는 이야기.",
            genres: [Genre(id: 28, name: "액션"), Genre(id: 878, name: "SF"), Genre(id: 12, name: "모험")]
        ),
        MovieDetail(
            id: 31, title: "시민 케인", posterPath: "/mock_poster_31.jpg", backdropPath: "/mock_backdrop_31.jpg",
            releaseDate: "1941-09-05", popularity: 897.0, voteAverage: 9.5, runtime: 119,
            overview: "신문왕 찰스 포스터 케인의 파란만장한 일대기를 그린 영화.",
            genres: [Genre(id: 18, name: "드라마"), Genre(id: 9648, name: "미스터리")]
        ),
        MovieDetail(
            id: 32, title: "카사블랑카", posterPath: "/mock_poster_32.jpg", backdropPath: "/mock_backdrop_32.jpg",
            releaseDate: "1942-11-26", popularity: 872.0, voteAverage: 9.4, runtime: 102,
            overview: "제2차 세계대전 중 카사블랑카에서 펼쳐지는 로맨스와 스파이 이야기.",
            genres: [Genre(id: 18, name: "드라마"), Genre(id: 10749, name: "로맨스"), Genre(id: 10752, name: "전쟁")]
        ),
        MovieDetail(
            id: 33, title: "대부", posterPath: "/mock_poster_33.jpg", backdropPath: "/mock_backdrop_33.jpg",
            releaseDate: "1972-03-24", popularity: 918.0, voteAverage: 9.6, runtime: 175,
            overview: "뉴욕의 마피아 코를레오네 패밀리의 권력 승계 과정을 그린 걸작.",
            genres: [Genre(id: 80, name: "범죄"), Genre(id: 18, name: "드라마")]
        ),
        MovieDetail(
            id: 34, title: "대부 2", posterPath: "/mock_poster_34.jpg", backdropPath: "/mock_backdrop_34.jpg",
            releaseDate: "1974-12-20", popularity: 903.0, voteAverage: 9.5, runtime: 202,
            overview: "마이클 코를레오네가 패밀리를 이끄는 과정과 비토 코를레오네의 젊은 시절을 교차하여 보여주는 이야기.",
            genres: [Genre(id: 80, name: "범죄"), Genre(id: 18, name: "드라마")]
        ),
        MovieDetail(
            id: 35, title: "위대한 개츠비", posterPath: "/mock_poster_35.jpg", backdropPath: "/mock_backdrop_35.jpg",
            releaseDate: "2013-05-10", popularity: 856.0, voteAverage: 9.2, runtime: 143,
            overview: "젊은 백만장자 제이 개츠비와 그의 사랑을 그린 화려하고 비극적인 이야기.",
            genres: [Genre(id: 18, name: "드라마"), Genre(id: 10749, name: "로맨스")]
        ),
        MovieDetail(
            id: 36, title: "로마의 휴일", posterPath: "/mock_poster_36.jpg", backdropPath: "/mock_backdrop_36.jpg",
            releaseDate: "1953-09-02", popularity: 839.0, voteAverage: 9.1, runtime: 118,
            overview: "로마를 탈출한 공주와 미국 기자의 로맨스를 그린 고전 로맨틱 코미디.",
            genres: [Genre(id: 10749, name: "로맨스"), Genre(id: 35, name: "코미디")]
        ),
        MovieDetail(
            id: 37, title: "버티고", posterPath: "/mock_poster_37.jpg", backdropPath: "/mock_backdrop_37.jpg",
            releaseDate: "1958-05-09", popularity: 864.0, voteAverage: 9.3, runtime: 128,
            overview: "고소공포증을 앓는 형사가 미스터리한 사건에 휘말리는 히치콕 감독의 스릴러 걸작.",
            genres: [Genre(id: 9648, name: "미스터리"), Genre(id: 53, name: "스릴러")]
        ),
        MovieDetail(
            id: 38, title: "사운드 오브 뮤직", posterPath: "/mock_poster_38.jpg", backdropPath: "/mock_backdrop_38.jpg",
            releaseDate: "1965-03-02", popularity: 827.0, voteAverage: 9.0, runtime: 174,
            overview: "오스트리아 알프스를 배경으로 한 마리아 수녀와 본 트랩 가족의 이야기.",
            genres: [Genre(id: 10402, name: "음악"), Genre(id: 10751, name: "가족")]
        ),
        MovieDetail(
            id: 39, title: "바람과 함께 사라지다", posterPath: "/mock_poster_39.jpg", backdropPath: "/mock_backdrop_39.jpg",
            releaseDate: "1939-12-15", popularity: 881.0, voteAverage: 9.4, runtime: 238,
            overview: "미국 남북전쟁을 배경으로 스칼렛 오하라의 사랑과 삶을 그린 대서사시.",
            genres: [Genre(id: 18, name: "드라마"), Genre(id: 10749, name: "로맨스"), Genre(id: 36, name: "역사")]
        ),
        MovieDetail(
            id: 40, title: "선라이즈", posterPath: "/mock_poster_40.jpg", backdropPath: "/mock_backdrop_40.jpg",
            releaseDate: "1927-09-23", popularity: 845.0, voteAverage: 9.2, runtime: 94,
            overview: "유혹에 빠진 남편과 아내의 관계를 그린 무성 영화 시대의 걸작 드라마.",
            genres: [Genre(id: 18, name: "드라마"), Genre(id: 10749, name: "로맨스")]
        )
    ]

    // MARK: - 영화 크레딧 정보
    // 모든 MovieDetail ID에 대응하는 credits 추가
    static let movieCredits: [Int: (director: String?, cast: [String])] = [
        1: (director: "홍길동", cast: ["김철수", "이영희", "박성민", "최유리"]),
        2: (director: "안소니 루소", cast: ["로버트 다우니 주니어", "크리스 에반스", "마크 러팔로", "크리스 헴스워스", "스칼릿 요한슨"]),
        3: (director: "조셉 코신스키", cast: ["톰 크루즈", "마일즈 텔러", "제니퍼 코넬리", "존 햄", "글렌 포웰"]),
        4: (director: "존 왓츠", cast: ["톰 홀랜드", "젠데이아", "베네딕트 컴버배치", "제이콥 배덜런", "마리사 토메이"]),
        5: (director: "타이카 와이티티", cast: ["크리스 헴스워스", "나탈리 포트만", "테사 톰슨", "크리스찬 베일", "러셀 크로우"]),
        6: (director: "샘 레이미", cast: ["베네딕트 컴버배치", "엘리자베스 올슨", "치웨텔 에지오포", "베네딕트 웡", "소치틀 고메즈"]),
        7: (director: "케이트 쇼트랜드", cast: ["스칼릿 요한슨", "플로렌스 퓨", "데이빗 하버", "레이첼 와이즈", "O. T. 패그벤레이"]),
        8: (director: "크리스토퍼 맥쿼리", cast: ["톰 크루즈", "헤일리 앳웰", "빙 라메스", "사이먼 페그", "레베카 퍼거슨"]),
        9: (director: "루이 르테리에", cast: ["빈 디젤", "미셸 로드리게즈", "타이레스 깁슨", "루다크리스", "제이슨 모모아"]),
        10: (director: "채드 스타헬스키", cast: ["키아누 리브스", "견자단", "빌 스카스가드", "로렌스 피시번", "사나다 히로유키"]),
        11: (director: "제임스 카메론", cast: ["샘 워싱턴", "조 샐다나", "시고니 위버", "스티븐 랭", "케이트 윈슬렛"]),
        12: (director: "제임스 카메론", cast: ["레오나르도 디카프리오", "케이트 윈슬렛", "빌리 제인", "케이시 베이츠", "글로리아 스튜어트"]),
        13: (director: "조지 루카스", cast: ["마크 해밀", "해리슨 포드", "캐리 피셔", "피터 메이휴", "데이비드 프로우즈"]),
        14: (director: "크리스 콜럼버스", cast: ["다니엘 래드클리프", "루퍼트 그린트", "엠마 왓슨", "리처드 해리스", "매기 스미스"]),
        15: (director: "피터 잭슨", cast: ["일라이저 우드", "이안 맥켈런", "비고 모텐슨", "올랜도 블룸", "숀 애스틴"]),
        16: (director: "크리스토퍼 놀란", cast: ["매튜 맥커너히", "앤 해서웨이", "제시카 차스테인", "마이클 케인", "캐시 애플렉"]),
        17: (director: "크리스토퍼 놀란", cast: ["레오나르도 디카프리오", "조셉 고든-레빗", "엘리엇 페이지", "톰 하디", "켄 와타나베"]),
        18: (director: "크리스토퍼 놀란", cast: ["크리스찬 베일", "히스 레저", "아론 에크하트", "마이클 케인", "매기 질렌할"]),
        19: (director: "쿠엔틴 타란티노", cast: ["존 트라볼타", "사무엘 L. 잭슨", "우마 서먼", "브루스 윌리스", "하비 케이틀"]),
        20: (director: "프랭크 다라본트", cast: ["팀 로빈스", "모건 프리먼", "밥 건턴", "윌리엄 새들러", "클랜시 브라운"]),
        21: (director: "제임스 건", cast: ["크리스 프랫", "조 샐다나", "데이브 바티스타", "빈 디젤", "브래들리 쿠퍼"]),
        22: (director: "앤디 무시에티", cast: ["에즈라 밀러", "벤 애플렉", "마이클 키튼", "사샤 칼레", "마이클 섀넌"]),
        23: (director: "제임스 맨골드", cast: ["해리슨 포드", "피비 월러-브리지", "매즈 미켈슨", "보이드 홀브룩", "안토니오 반데라스"]),
        24: (director: "스티븐 케이플 주니어", cast: ["안소니 라모스", "도미니크 피시백", "론 펄먼", "피터 딘클리지", "양자경"]),
        25: (director: "콜린 트레보로우", cast: ["크리스 프랫", "브라이스 달라스 하워드", "로라 던", "제프 골드블룸", "샘 닐"]),
        26: (director: "자움 콜렛-세라", cast: ["드웨인 존슨", "알디스 호지", "피어스 브로스넌", "사라 샤이", "퀸테사 스윈델"]),
        27: (director: "패티 젠킨스", cast: ["갈 가돗", "크리스 파인", "크리스틴 위그"]), // 임의 배우
        28: (director: "맷 리브스", cast: ["로버트 패틴슨", "조 크라비츠", "폴 다노"]), // 임의 배우
        29: (director: "제임스 완", cast: ["제이슨 모모아", "앰버 허드", "패트릭 윌슨"]), // 임의 배우
        30: (director: "니아 다코스타", cast: ["브리 라슨", "테요나 패리스", "이만 벨라니"]), // 임의 배우
        31: (director: "오손 웰스", cast: ["오손 웰스", "조셉 코튼", "도로시 쿰고어"]),
        32: (director: "마이클 커티즈", cast: ["험프리 보가트", "잉그리드 버그만", "폴 헨레이드"]),
        33: (director: "프랜시스 포드 코폴라", cast: ["말론 브란도", "알 파치노", "제임스 칸"]),
        34: (director: "프랜시스 포드 코폴라", cast: ["알 파치노", "로버트 드 니로", "로버트 듀발"]),
        35: (director: "바즈 루어만", cast: ["레오나르도 디카프리오", "캐리 멀리건", "토비 맥과이어"]),
        36: (director: "윌리엄 와일러", cast: ["오드리 헵번", "그레고리 펙", "에디 앨버트"]),
        37: (director: "알프레드 히치콕", cast: ["제임스 스튜어트", "킴 노박", "바바라 벨 게디스"]),
        38: (director: "로버트 와이즈", cast: ["줄리 앤드류스", "크리스토퍼 플러머", "엘레노어 파커"]),
        39: (director: "빅터 플레밍", cast: ["비비안 리", "클라크 게이블", "레슬리 하워드"]),
        40: (director: "F.W. 무르나우", cast: ["조지 오브라이언", "자넷 게이너", "보딜 로징"])
    ]

    static let defaultCredits: (director: String?, cast: [String]) = (
        director: "감독 정보 없음",
        cast: ["출연진 정보 없음"]
    )

    // MARK: - 장르별 영화 매핑
    static func getMoviesByGenre(genreId: Int) -> [Movie] {
        switch genreId {
        case 28: // 액션
            return [mockMovie1, mockMovie2, mockMovie3, mockMovie4, mockMovie5, mockMovie7, mockMovie8, mockMovie9, mockMovie10, mockMovie17, mockMovie18, mockMovie21, mockMovie22, mockMovie23, mockMovie24, mockMovie25, mockMovie26, mockMovie27, mockMovie28, mockMovie29, mockMovie30]
        case 12: // 모험
            return [mockMovie1, mockMovie2, mockMovie4, mockMovie5, mockMovie7, mockMovie11, mockMovie13, mockMovie15, mockMovie21, mockMovie22, mockMovie23, mockMovie25, mockMovie29, mockMovie30]
        case 16: // 애니메이션
            return [mockMovie1]
        case 35: // 코미디
            return [mockMovie5, mockMovie21, mockMovie36] // 토르, 가오갤, 로마의 휴일
        case 80: // 범죄
            return [mockMovie9, mockMovie10, mockMovie18, mockMovie19, mockMovie33, mockMovie34] // 패퓨10, 존윅4, 다크나이트, 펄프픽션, 대부, 대부2
        case 99: // 다큐멘터리
            return [] // 임의로 비워둠
        case 18: // 드라마
            return [mockMovie3, mockMovie12, mockMovie16, mockMovie18, mockMovie19, mockMovie20, mockMovie28, mockMovie31, mockMovie32, mockMovie33, mockMovie34, mockMovie35, mockMovie39, mockMovie40]
        case 10751: // 가족
            return [mockMovie1, mockMovie14, mockMovie38] // 킹 오브 킹스, 해리포터, 사운드 오브 뮤직
        case 14: // 판타지
            return [mockMovie1, mockMovie6, mockMovie11, mockMovie14, mockMovie15, mockMovie26, mockMovie27, mockMovie29] // 킹 오브 킹스, 닥스2, 아바타2, 해리포터, 반지의제왕, 블랙아담, 원더우먼3, 아쿠아맨2
        case 36: // 역사
            return [mockMovie39] // 바람과 함께 사라지다
        case 27: // 공포
            return [mockMovie6] // 닥스2
        case 10402: // 음악
            return [mockMovie38] // 사운드 오브 뮤직
        case 9648: // 미스터리
            return [mockMovie37, mockMovie31] // 버티고, 시민 케인
        case 10749: // 로맨스
            return [mockMovie12, mockMovie32, mockMovie35, mockMovie36, mockMovie39, mockMovie40] // 타이타닉, 카사블랑카, 위대한 개츠비, 로마의휴일, 바람과함께사라지다, 선라이즈
        case 878: // SF
            return [mockMovie2, mockMovie4, mockMovie6, mockMovie11, mockMovie13, mockMovie16, mockMovie17, mockMovie22, mockMovie24, mockMovie25, mockMovie30]
        case 10770: // TV 영화
            return [] // 임의로 비워둠
        case 53: // 스릴러
            return [mockMovie8, mockMovie9, mockMovie10, mockMovie17, mockMovie37] // 미션임파서블7, 패퓨10, 존윅4, 인셉션, 버티고
        case 10752: // 전쟁
            return [mockMovie32] // 카사블랑카
        case 37: // 서부
            return [] // 임의로 비워둠
        default:
            // 해당하는 장르 ID가 없을 경우, 빈 배열 반환 (명확한 Mocking)
            return []
        }
    }
}
