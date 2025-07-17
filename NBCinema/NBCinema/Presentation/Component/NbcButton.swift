//
//  NbcButton.swift
//  NBCinema
//
//  Created by seongjun cho on 7/16/25.
//

import UIKit

// 활성, 비활성에 따라 배경색이 변합니다.
// 크기 설정 안할시, 가로: 텍스트 너비 + 10, 세로: 텍스트 높이 + 32이 됩니다.
class NbcButton: UIButton {
	override var isEnabled: Bool {
		willSet(newValue) {
			if newValue {
				self.backgroundColor = .nbcMain
			} else {
				self.backgroundColor = .nbcDisable
			}
		}
	}

	override var intrinsicContentSize: CGSize {
		let textSize = titleLabel?.intrinsicContentSize ?? .zero
		return CGSize(width: textSize.width + 10, height: textSize.height + 32)
	}

	init(title: String) {
		super.init(frame: .zero)
		self.setTitle(title, for: .normal)
		setUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setUI() {
		self.backgroundColor = .nbcMain
		self.tintColor = .white
		self.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
		self.layer.cornerRadius = 10
		self.layer.masksToBounds = true
	}
}
