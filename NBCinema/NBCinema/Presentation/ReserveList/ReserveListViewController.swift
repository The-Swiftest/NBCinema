//
//  ReserveListViewController.swift
//  NBCinema
//
//  Created by seongjun cho on 7/21/25.
//

import UIKit

final class ReserveListViewController: UIViewController {

    // MARK: - UI Components

    private let reserveListView = ReserveListView()

    // MARK: - Properties

    weak var coordinator: MyPageCoordinator?
    private let reservationData: [ReservationDetail]

    // MARK: - Initializers

    init(reservationData: [ReservationDetail]) {
        self.reservationData = reservationData
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = reserveListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        reserveListView.tabelView.delegate = self
        reserveListView.tabelView.dataSource = self
        reserveListView.headerView.backButton.addTarget(
            self,
            action: #selector(backButtonTapped),
            for: .touchUpInside
        )
    }
}

// MARK: - Extensions

extension ReserveListViewController {
    @objc func backButtonTapped() {
        self.coordinator?.navigationController.popViewController(animated: true)
    }
}

extension ReserveListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reservationData.count
    }

    internal func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ReserveListCell.identifier,
            for: indexPath
        ) as! ReserveListCell

        cell.configure(with: reservationData[indexPath.row])

        return cell
    }
}
