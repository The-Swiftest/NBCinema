//
//  FavoriteView.swift
//  NBCinema
//
//  Created by seongjun cho on 7/21/25.
//

import UIKit

import SnapKit
import Then

final class FavoriteView: UIView {

    // MARK: - Properties
    var trashButtonTapped: ((String) -> Void)?

    // MARK: - UI Components

    private let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = UIImage(systemName: "person")
    }

    let trashButton = UIButton().then {
        $0.contentMode = .scaleAspectFit
        $0.setImage(UIImage(named: "trash"), for: .normal)
    }

    let movieTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }

    private let informStackView = UIStackView().then {
        $0.axis = .vertical
    }

    private let genreStackView = SymbolLabelStackView(
        symbol: UIImage(named: "slate") ?? UIImage(systemName: "xmark")!,
        title: ""
    )

    private let runTimeStackView = SymbolLabelStackView(
        symbol: UIImage(named: "clockGray") ?? UIImage(systemName: "xmark")!,
        title: ""
    )

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        addTargets()

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

    // MARK: - Methods

    private func addTargets() {
        trashButton.addTarget(self, action: #selector(didTapTrashButton), for: .touchUpInside)
    }

    func configure(with item: FavoriteMovie) {
        posterImageView.loadImage(from: item.posterURL ?? URL(string: "https://placehold.co/400x600")!)
        movieTitleLabel.text = item.movieTitle
        let genres = Array(item.genres)
        genreStackView.label.text = genres.map { $0.name }.joined(separator: ", ")
        runTimeStackView.label.text = item.runtime.toTimeString()
    }

    private func setUI() {
        [posterImageView, movieTitleLabel, trashButton, informStackView].forEach {
            self.addSubview($0)
        }

        [genreStackView, runTimeStackView].forEach {
            informStackView.addArrangedSubview($0)
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

        trashButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }

        informStackView.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(12)
            $0.leading.equalTo(movieTitleLabel)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(12)
        }
    }

    // MARK: - Actions
    @objc private func didTapTrashButton() {
        trashButtonTapped?(movieTitleLabel.text ?? "")
    }
}
