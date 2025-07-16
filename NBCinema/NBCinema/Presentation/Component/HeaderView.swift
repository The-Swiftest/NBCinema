//
//  HeaderView.swift
//  NBCinema
//
//  Created by seongjun cho on 7/16/25.
//

import UIKit

import SnapKit
import Then

// HeaderView(.sub or .logo) 로 생성
// 기본 크기 = (가로: 화면크기, 세로: 60)
class HeaderView: UIView {

	let backButton = UIButton().then {
		let configuration = UIImage.SymbolConfiguration(pointSize: 32, weight: .bold)
		let image = UIImage(systemName: "arrow.left", withConfiguration: configuration)
		$0.setImage(image, for: .normal)
		$0.tintColor = .reverseSystem
	}

	let headLabel = UILabel().then {
		$0.font = .systemFont(ofSize: 20, weight: .bold)
		$0.textColor = .reverseSystem
	}

	let logoImageView = UIImageView().then {
		$0.image = UIImage(named: "logo")
		$0.contentMode = .scaleAspectFit
		$0.setContentHuggingPriority(.defaultLow, for: .vertical)
		$0.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
	}

	override var intrinsicContentSize: CGSize {
		return CGSize(width: UIScreen.main.bounds.width, height: 60)
	}

	init(_ style: Style) {
		super.init(frame: .zero)
		setupUI(style)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupUI(_ style: Style) {
		switch style {
		case .logo:
			self.addSubview(logoImageView)

			logoImageView.snp.makeConstraints { make in
				make.center.height.equalToSuperview()
			}
		case .sub(let title):
			headLabel.text = title
			self.addSubview(backButton)
			self.addSubview(headLabel)

			backButton.snp.makeConstraints { make in
				make.top.bottom.leading.equalToSuperview().inset(15)
			}

			headLabel.snp.makeConstraints { make in
				make.top.bottom.equalToSuperview().inset(21)
				make.centerX.equalToSuperview()
			}
		}
	}
}

extension HeaderView {
	enum Style {
		case logo
		case sub(String)
	}
}
