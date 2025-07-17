//
//  MovieListCoordinator.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import UIKit

/// 영화목록 화면들을 관리하는 Coordinator
class MovieListCoordinator: BaseCoordinator {
    
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
        
        // MockRepository 전체 테스트
//        Task {
//            await testAllMockRepositoryMethods()
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
    
    // MARK: - MockRepository 테스트용 메서드
    private func testAllMockRepositoryMethods() async {
        print("\n🎬 ========== MockRepository 테스트 시작 ==========")
        
        // 1. 영화 목록 테스트
        await testMovieLists()
        
        // 2. 영화 상세 정보 테스트
        await testMovieDetails()
        
        // 3. 검색 기능 테스트
        await testSearchFunctionality()
        
        // 4. 장르 기능 테스트
        await testGenreFunctionality()
        
        // 5. 크레딧 정보 테스트
        await testMovieCredits()
        
        print("🎬 ========== MockRepository 테스트 완료 ==========\n")
    }
    
    private func testMovieLists() async {
        print("\n📋 === 영화 목록 테스트 ===")
        
        do {
            // 현재 상영중
            let nowPlaying = try await movieRepository.fetchNowPlayingMovies()
            print("✅ 현재 상영중: \(nowPlaying.count)개")
            print("   첫 번째 영화: \(nowPlaying.first?.title ?? "없음")")
            
            // 인기 영화
            let popular = try await movieRepository.fetchPopularMovies()
            print("✅ 인기 영화: \(popular.count)개")
            print("   첫 번째 영화: \(popular.first?.title ?? "없음")")
            
            // 개봉 예정
            let upcoming = try await movieRepository.fetchUpcomingMovies()
            print("✅ 개봉 예정: \(upcoming.count)개")
            print("   첫 번째 영화: \(upcoming.first?.title ?? "없음")")
            
            // 높은 평점
            let topRated = try await movieRepository.fetchTopRatedMovies()
            print("✅ 높은 평점: \(topRated.count)개")
            print("   첫 번째 영화: \(topRated.first?.title ?? "없음")")
            
        } catch {
            print("❌ 영화 목록 테스트 실패: \(error)")
        }
    }
    
    private func testMovieDetails() async {
        print("\n🎭 === 영화 상세 정보 테스트 ===")
        
        let testMovieIds = [1, 2, 3, 999] // 999는 존재하지 않는 ID
        
        for movieId in testMovieIds {
            do {
                let movieDetail = try await movieRepository.fetchMovieDetail(id: movieId)
                print("✅ 영화 ID \(movieId): \(movieDetail.title)")
                print("   장르: \(movieDetail.genreNames)")
                print("   평점: \(movieDetail.voteAverage)/10")
                print("   러닝타임: \(movieDetail.runtimeString)")
            } catch {
                print("❌ 영화 ID \(movieId) 상세 정보 실패: \(error)")
            }
        }
    }
    
    private func testSearchFunctionality() async {
        print("\n🔍 === 검색 기능 테스트 ===")
        
        let searchQueries = ["", "킹", "어벤져스", "존재하지않는영화", "액션"]
        
        for query in searchQueries {
            do {
                let searchResults = try await movieRepository.searchMovies(query: query)
                let displayQuery = query.isEmpty ? "(빈 검색어)" : query
                print("✅ 검색어 '\(displayQuery)': \(searchResults.count)개 결과")
                
                if !searchResults.isEmpty {
                    print("   첫 번째 결과: \(searchResults.first?.title ?? "없음")")
                    if searchResults.count > 1 {
                        print("   마지막 결과: \(searchResults.last?.title ?? "없음")")
                    }
                }
            } catch {
                print("❌ 검색어 '\(query)' 실패: \(error)")
            }
        }
    }
    
    private func testGenreFunctionality() async {
        print("\n🎭 === 장르 기능 테스트 ===")
        
        do {
            // 장르 목록 테스트
            let genres = try await movieRepository.fetchGenres()
            print("✅ 장르 목록: \(genres.count)개")
            print("   전체 장르: \(genres.map { $0.name }.joined(separator: ", "))")
            
            // 장르별 영화 테스트 (만약 구현되어 있다면)
            if let firstGenre = genres.first {
                // fetchMoviesByGenre가 구현되어 있는지 확인
                // let moviesByGenre = try await movieRepository.fetchMoviesByGenre(genreId: firstGenre.id)
                // print("✅ \(firstGenre.name) 장르 영화: \(moviesByGenre.count)개")
                print("📝 장르별 영화 검색 기능은 아직 구현되지 않음")
            }
            
        } catch {
            print("❌ 장르 기능 테스트 실패: \(error)")
        }
    }
    
    private func testMovieCredits() async {
        print("\n🎬 === 영화 크레딧 테스트 ===")
        
        let testMovieIds = [1, 2, 3, 999] // 999는 존재하지 않는 ID
        
        for movieId in testMovieIds {
            do {
                let credits = try await movieRepository.fetchMovieCredits(id: movieId)
                print("✅ 영화 ID \(movieId) 크레딧:")
                print("   감독: \(credits.director ?? "정보 없음")")
                print("   출연진: \(credits.cast.joined(separator: ", "))")
            } catch {
                print("❌ 영화 ID \(movieId) 크레딧 실패: \(error)")
            }
        }
    }
}
