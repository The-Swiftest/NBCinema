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
}
