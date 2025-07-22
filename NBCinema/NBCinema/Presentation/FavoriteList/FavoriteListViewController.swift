//
//  FavoriteListViewController.swift
//  NBCinema
//
//  Created by seongjun cho on 7/21/25.
//

import UIKit

final class FavoriteListViewController: UIViewController {

    // MARK: - UI Components

    private let favoriteListView = FavoriteListView()

    // MARK: - Properties

    weak var coordinator: MyPageCoordinator?
    private var viewModel: FavoriteListViewModel

    // MARK: - Initializers

    init(favoriteData: [FavoriteMovie]) {
        self.viewModel = FavoriteListViewModel(favoriteMovies: favoriteData)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = favoriteListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
}

// MARK: - Extensions

extension FavoriteListViewController {
    private func setupUI() {
        favoriteListView.tableView.delegate = self
        favoriteListView.tableView.dataSource = self
        favoriteListView.headerView.backButton.addTarget(
            self,
            action: #selector(backButtonTapped),
            for: .touchUpInside
        )
    }

    private func bindViewModel() {
        viewModel.onStateChange = { [weak self] state in
            self?.favoriteListView.tableView.reloadData()
        }

        viewModel.onError = { error in
            print("Error: \(error.localizedDescription)")
            // 사용자에게 오류 알림 표시
        }
    }

    @objc func backButtonTapped() {
        self.coordinator?.navigationController.popViewController(animated: true)
    }
}

extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.state.favoriteMovies.count
    }

    internal func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: FavoriteListCell.identifier,
            for: indexPath
        ) as! FavoriteListCell

        let movie = viewModel.state.favoriteMovies[indexPath.row]
        cell.configure(with: movie)
        cell.trashButtonTapped = { [weak self] movieTitle in
            self?.viewModel.action(.deleteFavorite(movieTitle: movieTitle))
        }

        return cell
    }
}
