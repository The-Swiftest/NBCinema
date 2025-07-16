//
//  CustomTabBarController.swift
//  NBCinema
//
//  Created by seongjun cho on 7/16/25.
//

import UIKit

class CustomTabBarController: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()

		setValue(CustomTabBar(), forKey: "tabBar")
		customizeTabBarAppearance()
	}

	private func customizeTabBarAppearance() {
		tabBar.tintColor = .nbcMain
		tabBar.unselectedItemTintColor = .tabBarItem
		tabBar.backgroundColor = .systemBackground

		let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .bold)]
		UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
	}

	func setItems() {
		let items = [UITabBarItem(title: "영화 목록", image: UIImage(named: "movie"), tag: 0),
					 UITabBarItem( title: "영화 검색", image: UIImage(named: "search"), tag: 1),
					 UITabBarItem(title: "마이페이지", image:  UIImage(named: "person"), tag: 2)
		]
		for (idx, vc) in (viewControllers ?? []).enumerated() {
			vc.tabBarItem = items[idx]
		}
	}
}
