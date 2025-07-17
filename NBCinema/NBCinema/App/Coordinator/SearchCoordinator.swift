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
        
        // 검색 기능 테스트
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
        print("\n🔍 ========== 검색 탭 테스트 ==========")
        
        do {
            // 인기 검색어 테스트
            let popularMovies = try await movieRepository.fetchPopularMovies()
            print("✅ 검색 탭 - 인기 영화 로드: \(popularMovies.count)개")
            
            // 장르 필터 테스트
            let genres = try await movieRepository.fetchGenres()
            print("✅ 검색 탭 - 장르 필터: \(genres.count)개")
            print("   장르: \(genres.prefix(5).map { $0.name }.joined(separator: ", "))...")
            
        } catch {
            print("❌ 검색 탭 테스트 실패: \(error)")
        }
        
        print("🔍 ========== 검색 탭 테스트 완료 ==========\n")
    }
}
