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
	}
}
