//
//  FavoriteListCell.swift
//  NBCinema
//
//  Created by seongjun cho on 7/21/25.
//

import UIKit

import SnapKit

final class FavoriteListCell: UITableViewCell {
    // MARK: - Properties

    static let identifier = "ReservListCell"
    var trashButtonTapped: ((String) throws -> ())?

    // MARK: - UI Components

    let favoriteView = FavoriteView()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(favoriteView)
        favoriteView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        favoriteView.trashButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func configure(with data: FavoriteMovie) {
        favoriteView.configure(with: data)
    }

    @objc private func buttonTapped() {
        print(self.favoriteView.movieTitleLabel.text ?? "")
        do {
            try trashButtonTapped?(self.favoriteView.movieTitleLabel.text ?? "")
        } catch {
            print(error)
        }
    }
}
