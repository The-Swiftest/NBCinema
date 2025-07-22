//
//  ReserveListCell.swift
//  NBCinema
//
//  Created by seongjun cho on 7/21/25.
//

import UIKit

import SnapKit

final class ReserveListCell: UITableViewCell {
    // MARK: - Properties

    static let identifier = "ReservListCell"

    // MARK: - UI Components

    private let reservationView = ReservationView()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(reservationView)
        reservationView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func configure(with data: ReservationDetail ) {
        reservationView.configure(with: data)
    }
}
