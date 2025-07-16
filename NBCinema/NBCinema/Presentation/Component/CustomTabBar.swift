//
//  CustomTabBar.swift
//  NBCinema
//
//  Created by seongjun cho on 7/16/25.
//

import UIKit

class CustomTabBar: UITabBar {
	private let customHeight: CGFloat = 60

	override func sizeThatFits(_ size: CGSize) -> CGSize {
		var size = super.sizeThatFits(size)
		size.height = customHeight + safeAreaInsets.bottom
		return size
	}
}
