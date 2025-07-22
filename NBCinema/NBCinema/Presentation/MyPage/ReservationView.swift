//
//  ReservationView.swift
//  NBCinema
//
//  Created by seongjun cho on 7/17/25.
//

import UIKit

import SnapKit
import Then

class ReservationView: UIView {

    private let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = UIImage(systemName: "person")
    }

    private let movieTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }

    private let informStackView = UIStackView().then {
        $0.axis = .vertical
    }

    private let dateStackView = SymbolLabelStackView(
        symbol: UIImage(named: "calendar") ?? UIImage(systemName: "xmark")!,
        title: ""
    )

    private let peopleStackView = SymbolLabelStackView(
        symbol: UIImage(named: "people") ?? UIImage(systemName: "xmark")!,
        title: ""
    )

    private let amountStackView = SymbolLabelStackView(
        symbol: UIImage(named: "amount") ?? UIImage(systemName: "xmark")!,
        title: ""
    )

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()

        self.backgroundColor = .gray5Dynamic
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.borderDynamic.cgColor
        self.layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
            self.layer.borderColor = UIColor.borderDynamic.cgColor
        }
    }

    func configure(with item: ReservationDetail) {
        posterImageView.loadImage(from: item.posterURL ?? URL(fileURLWithPath: "https://placehold.co/400x600"))
        movieTitleLabel.text = item.movieTitle
        dateStackView.label.text = item.reservationTime.toMonthDayString()
        peopleStackView.label.text = String(item.numberOfPeople) + "명"
        amountStackView.label.text = item.amount.toCommaString() + "원"
    }

    private func setUI() {
        [posterImageView, movieTitleLabel, informStackView].forEach {
            self.addSubview($0)
        }

        [dateStackView, peopleStackView, amountStackView].forEach {
            informStackView.addArrangedSubview($0)
        }

        self.snp.makeConstraints {
            $0.height.equalTo(130)
        }

        posterImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(130)
            $0.width.equalTo(100)
        }

        movieTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(20)
            $0.height.equalTo(movieTitleLabel.font.lineHeight)
        }

        informStackView.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(movieTitleLabel)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}

