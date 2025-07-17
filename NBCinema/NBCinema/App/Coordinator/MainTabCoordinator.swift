//
//  MainTabCoordinator.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import UIKit

protocol MainTabCoordinatorDelegate: AnyObject {
    func didLogout(_ coordinator: MainTabCoordinator)
}

/// TabBar와 각 탭의 Coordinator들을 관리하는 Coordinator
class MainTabCoordinator: BaseCoordinator {
    private var tabBarController: CustomTabBarController?
    weak var delegate: MainTabCoordinatorDelegate?
    
    override func start() {
        setUPTabBar()
    }
    
    private func setUPTabBar() {
        let tabBarController = CustomTabBarController()
        
        // TODO: 추후 MovieRepository로 교체
        let movieRepository: MovieRepository = NetworkMovieRepository()
        
        // 영화목록 탭
        let movieListNav = UINavigationController()
        let movieListCoordinator = MovieListCoordinator(
            navigationController: movieListNav,
            movieRepository: movieRepository
        )
        addChildCoordinator(movieListCoordinator)
        movieListCoordinator.start()
        
        // 검색 탭
        let searchNav = UINavigationController()
        let searchCoordinator = SearchCoordinator(
            navigationController: searchNav,
            movieRepository: movieRepository
        )
        addChildCoordinator(searchCoordinator)
        searchCoordinator.start()
        
        // 마이페이지 탭
        let myPageNav = UINavigationController()
        let myPageCoordinator = MyPageCoordinator(navigationController: myPageNav)
        myPageCoordinator.delegate = self
        addChildCoordinator(myPageCoordinator)
        myPageCoordinator.start()
        
        tabBarController.viewControllers = [movieListNav, searchNav, myPageNav]
        tabBarController.setItems()
        self.tabBarController = tabBarController
        navigationController.setViewControllers([tabBarController], animated: true)
    }
}

extension MainTabCoordinator: MyPageCoordinatorDelegate {
    func myPageCoordinatorDidLogout(_ coordinator: MyPageCoordinator) {
        delegate?.didLogout(self)
    }
}
