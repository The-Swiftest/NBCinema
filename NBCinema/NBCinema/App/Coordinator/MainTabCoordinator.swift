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
    private var tabBarController: UITabBarController?
    weak var delegate: MainTabCoordinatorDelegate?
    
    override func start() {
        setUPTabBar()
    }
    
    private func setUPTabBar() {
        let tabBarController = UITabBarController()
        
        // 영화목록 탭
        let movieListNav = UINavigationController()
        let movieListCoordinator = MovieListCoordinator(navigationController: movieListNav)
        addChildCoordinator(movieListCoordinator)
        movieListCoordinator.start()
        movieListNav.tabBarItem = UITabBarItem(title: "영화목록", image: UIImage(systemName: "film"), tag: 0)
        
        // 검색 탭
        let searchNav = UINavigationController()
        let searchCoordinator = SearchCoordinator(navigationController: searchNav)
        addChildCoordinator(searchCoordinator)
        searchCoordinator.start()
        searchNav.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        // 마이페이지 탭
        let myPageNav = UINavigationController()
        let myPageCoordinator = MyPageCoordinator(navigationController: myPageNav)
        myPageCoordinator.delegate = self 
        addChildCoordinator(myPageCoordinator)
        myPageCoordinator.start()
        myPageNav.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(systemName: "person"), tag: 2)
        
        tabBarController.viewControllers = [movieListNav, searchNav, myPageNav]
        
        self.tabBarController = tabBarController
        navigationController.setViewControllers([tabBarController], animated: true)
    }
}

extension MainTabCoordinator: MyPageCoordinatorDelegate {
    func myPageCoordinatorDidLogout(_ coordinator: MyPageCoordinator) {
        delegate?.didLogout(self)
    }
}
