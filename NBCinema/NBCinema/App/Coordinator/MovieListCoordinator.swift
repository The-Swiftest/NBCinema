//
//  MovieListCoordinator.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import UIKit

/// 영화목록 화면들을 관리하는 Coordinator
class MovieListCoordinator: BaseCoordinator {
    // MARK: - 테스트용 프로퍼티
    private var testGenres: [Genre]?
    private var testMovieId: Int?
    
    private let movieRepository: MovieRepository
    
    init(navigationController: UINavigationController, movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        showMovieList()
    }
    
    /// 영화목록 화면 표시
    private func showMovieList() {
        let movieListVC = UIViewController()
        movieListVC.view.backgroundColor = .systemRed
        movieListVC.title = "영화목록"
        
        //  API 테스트
//        Task {
//            await testAllRepositoryMethods()
//        }
        
        navigationController.setViewControllers([movieListVC], animated: false)
    }
    
    // 영화 상세 화면으로 이동 (나중에 구현)
    func showMovieDetail(movieId: Int) {
        let movieDetailVC = UIViewController()
        movieDetailVC.view.backgroundColor = .systemPurple
        movieDetailVC.title = "영화 상세"
        
        navigationController.pushViewController(movieDetailVC, animated: true)
    }
    
    /// 영화 예매 화면으로 이동
    func showBooking(movieId: Int) {
        // TODO: 예매 Coordinator 구현 후 연결
        print("영화 예매 화면 이동: \(movieId)")
    }
}

extension MovieListCoordinator {
    private func testAllRepositoryMethods() async {
        print("\n🚀 ===== TMDB API 전체 테스트 시작 =====")
        
        // 1. 영화 목록 API 테스트
        await testMovieListAPIs()
        
        // 2. 장르 API 테스트
        await testGenreAPI()
        
        // 3. 영화 상세 정보 테스트
        await testMovieDetailAPI()
        
        // 4. 영화 크레딧 테스트
        await testMovieCreditsAPI()
        
        // 5. 검색 API 테스트
        await testSearchAPI()
        
        // 6. 장르별 영화 조회 테스트
        await testGenreFilterAPI()
        
        print("\n🎯 ===== 전체 테스트 완료 =====\n")
    }
    
    // MARK: - 1. 영화 목록 API 테스트
    private func testMovieListAPIs() async {
        print("\n📱 1. 영화 목록 API 테스트")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        
        // 현재 상영중
        await testSingleAPI(
            name: "현재 상영중",
            operation: { try await self.movieRepository.fetchNowPlayingMovies() }
        )
        
        // 인기 영화
        await testSingleAPI(
            name: "인기 영화",
            operation: { try await self.movieRepository.fetchPopularMovies() }
        )
        
        // 개봉 예정
        await testSingleAPI(
            name: "개봉 예정",
            operation: { try await self.movieRepository.fetchUpcomingMovies() }
        )
        // 높은 평점
        await testSingleAPI(
            name: "높은 평점",
            operation: { try await self.movieRepository.fetchTopRatedMovies() }
        )
    }

    // MARK: - 2. 장르 API 테스트
    private func testGenreAPI() async {
        print("\n🎭 2. 장르 API 테스트")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        
        do {
            let genres = try await movieRepository.fetchGenres()
            print("✅ 장르 목록 로드 성공: \(genres.count)개")
            
            // 상위 5개 장르 출력
            let topGenres = genres.prefix(5)
            for (index, genre) in topGenres.enumerated() {
                print("   \(index + 1). \(genre.name) (ID: \(genre.id))")
            }
            
            // 전역 변수에 저장 (다른 테스트에서 사용)
            self.testGenres = genres
            
        } catch {
            print("❌ 장르 목록 로드 실패: \(error)")
        }
    }
    
    // MARK: - 3. 영화 상세 정보 테스트
    private func testMovieDetailAPI() async {
        print("\n🎬 3. 영화 상세 정보 테스트")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        
        // 인기 영화 첫 번째로 테스트
        do {
            let popularMovies = try await movieRepository.fetchPopularMovies()
            guard let firstMovie = popularMovies.first else {
                print("❌ 테스트할 영화가 없습니다")
                return
            }
            
            let movieDetail = try await movieRepository.fetchMovieDetail(id: firstMovie.id)
            
            print("✅ 영화 상세 정보 로드 성공")
            print("   📋 제목: \(movieDetail.title)")
            print("   📅 개봉일: \(movieDetail.releaseDateFormatted)")
            print("   ⏰ 러닝타임: \(movieDetail.runtimeString)")
            print("   ⭐ 평점: \(movieDetail.voteAverage)/10")
            print("   🎭 장르: \(movieDetail.genreNames)")
            print("   📝 줄거리: \(String(movieDetail.overview.prefix(100)))...")
            
            // 전역 변수에 저장 (크레딧 테스트에서 사용)
            self.testMovieId = firstMovie.id
            
        } catch {
            print("❌ 영화 상세 정보 로드 실패: \(error)")
        }
    }
    
    // MARK: - 4. 영화 크레딧 테스트
    private func testMovieCreditsAPI() async {
        print("\n🎭 4. 영화 크레딧 테스트")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        
        guard let movieId = testMovieId else {
            print("❌ 테스트할 영화 ID가 없습니다")
            return
        }
        
        do {
            let credits = try await movieRepository.fetchMovieCredits(id: movieId)
            
            print("✅ 영화 크레딧 로드 성공")
            print("   🎬 감독: \(credits.director ?? "정보 없음")")
            print("   🎭 주요 출연진:")
            for (index, actor) in credits.cast.enumerated() {
                print("      \(index + 1). \(actor)")
            }
            
        } catch {
            print("❌ 영화 크레딧 로드 실패: \(error)")
        }
    }
    
    // MARK: - 5. 검색 API 테스트
    private func testSearchAPI() async {
        print("\n🔍 5. 검색 API 테스트")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        
        let searchQueries = ["어벤져스", "스파이더맨", "토르", "아이언맨"]
        
        for query in searchQueries {
            do {
                let movies = try await movieRepository.searchMovies(query: query)
                print("✅ '\(query)' 검색 성공: \(movies.count)개 결과")
                
                // 상위 3개 결과 출력
                for (index, movie) in movies.prefix(3).enumerated() {
                    print("   \(index + 1). \(movie.title) (평점: \(movie.voteAverage))")
                }
                
            } catch {
                print("❌ '\(query)' 검색 실패: \(error)")
            }
        }
    }
    
    // MARK: - 6. 장르별 영화 조회 테스트
    private func testGenreFilterAPI() async {
        print("\n🎯 6. 장르별 영화 조회 테스트")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        
        guard let genres = testGenres else {
            print("❌ 테스트할 장르 목록이 없습니다")
            return
        }
        
        // 주요 장르들로 테스트
        let testGenreIds = [28, 35, 18, 27, 878] // 액션, 코미디, 드라마, 공포, SF
        
        for genreId in testGenreIds {
            guard let genre = genres.first(where: { $0.id == genreId }) else {
                continue
            }
            
            do {
                let movies = try await movieRepository.fetchMoviesByGenre(genreId: genreId)
                print("✅ '\(genre.name)' 장르 영화 조회 성공: \(movies.count)개")
                
                // 상위 3개 결과 출력
                for (index, movie) in movies.prefix(3).enumerated() {
                    print("   \(index + 1). \(movie.title) (평점: \(movie.voteAverage))")
                }
                
            } catch {
                print("❌ '\(genre.name)' 장르 영화 조회 실패: \(error)")
            }
        }
    }
    
    // MARK: - 유틸리티 메서드
    private func testSingleAPI<T>(
        name: String,
        operation: () async throws -> [T]
    ) async where T: Any {
        do {
            let results = try await operation()
            print("✅ \(name) 로드 성공: \(results.count)개")
            
            // Movie 타입인 경우 첫 번째 영화 제목 출력
            if let movies = results as? [Movie], let firstMovie = movies.first {
                print("   🎬 첫 번째: \(firstMovie.title) (평점: \(firstMovie.voteAverage))")
            }
            
        } catch {
            print("❌ \(name) 로드 실패: \(error)")
            if let networkError = error as? NetworkError {
                print("   📝 상세: \(networkError.localizedDescription)")
            }
        }
    }
}
