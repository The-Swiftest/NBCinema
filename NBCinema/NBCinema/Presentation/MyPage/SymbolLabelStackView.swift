//
//  SymbolLabelStackView.swift
//  NBCinema
//
//  Created by seongjun cho on 7/17/25.
//

import UIKit

import SnapKit
import Then

final class SymbolLabelStackView: UIStackView {
    let symbolImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .gray3
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
        $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }

    let label = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .gray3
    }

    init(symbol: UIImage, title: String) {
        super.init(frame: .zero)
        self.symbolImageView.image = symbol
        self.label.text = title

        self.axis = .horizontal
        self.spacing = 8

        self.addArrangedSubview(symbolImageView)
        self.addArrangedSubview(label)

        symbolImageView.snp.makeConstraints {
            $0.width.equalTo(symbolImageView.snp.height)
        }
    }


    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
