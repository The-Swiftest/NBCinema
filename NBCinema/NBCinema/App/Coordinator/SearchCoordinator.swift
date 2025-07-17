//
//  SearchCoordinator.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import UIKit

/// 검색 화면들을 관리하는 Coordinator
class SearchCoordinator: BaseCoordinator {
    
    private let movieRepository: MovieRepository
    
    init(navigationController: UINavigationController, movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        showSearch()
    }
    
    /// 검색 화면 표시
    private func showSearch() {
        let searchVC = UIViewController()
        searchVC.view.backgroundColor = .systemYellow
        searchVC.title = "검색"
        
        //  API 테스트
//        Task {
//            await testSearchFeatures()
//        }
        navigationController.setViewControllers([searchVC], animated: false)
    }
    
    /// 검색된 영화 상세 화면으로 이동
    func showMovieDetail(movieId: Int) {
        // TODO: MovieListViewController 구현 후 연결
        let movieDetailVC = UIViewController()
        movieDetailVC.view.backgroundColor = .systemPurple
        movieDetailVC.title = "영화 상세 (검색에서)"
        
        navigationController.pushViewController(movieDetailVC, animated: true)
    }
}

extension SearchCoordinator {
    private func testSearchFeatures() async {
        print("\n🔍 검색 화면 - API 테스트")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        
        // 1. 장르 목록 로드 테스트
        do {
            let genres = try await movieRepository.fetchGenres()
            print("✅ 장르 버튼용 데이터 로드 성공: \(genres.count)개")
            
            // 장르별 영화 개수 확인
            for genre in genres.prefix(3) {
                let movies = try await movieRepository.fetchMoviesByGenre(genreId: genre.id)
                print("   🎭 \(genre.name): \(movies.count)개 영화")
            }
            
        } catch {
            print("❌ 검색 화면 데이터 로드 실패: \(error)")
        }
        
        // 2. 빈 검색어 테스트
        do {
            let emptyResult = try await movieRepository.searchMovies(query: "")
            print("✅ 빈 검색어 처리: \(emptyResult.count)개 결과")
        } catch {
            print("❌ 빈 검색어 처리 실패: \(error)")
        }
    }
}
