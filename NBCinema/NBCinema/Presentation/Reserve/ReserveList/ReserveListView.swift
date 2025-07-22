//
//  ReserveListView.swift
//  NBCinema
//
//  Created by seongjun cho on 7/21/25.
//

import UIKit

import SnapKit
import Then

final class ReserveListView: UIView {
    // MARK: - UI Components

    let headerView = HeaderView(.sub("예매 내역"))

    let tabelView = UITableView().then {
        $0.register(ReserveListCell.self, forCellReuseIdentifier: ReserveListCell.identifier)
        $0.rowHeight = UITableView.automaticDimension
        $0.separatorStyle = .none
        $0.estimatedRowHeight = 130
        $0.allowsSelection = false
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Methods

    private func setUI() {
        addSubview(headerView)
        addSubview(tabelView)

        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }

        tabelView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(15)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
