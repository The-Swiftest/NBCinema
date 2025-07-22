//
//  ReserveViewController.swift
//  NBCinema
//
//  Created by seongjun cho on 7/18/25.
//

import UIKit

class ReserveViewController: UIViewController {
    weak var coordinator: BaseCoordinator?
    private let reserveView = ReserveView()
    private let reserveViewModel = ReserveViewModel(
        movieService: NetworkMovieRepository(),
        userActivityService: UserActivityService()
    )

    private let id: Int

    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func loadView() {
        self.view = reserveView
    }

    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        bindingData()
        reserveViewModel.action(.fetchData(id: id))
        reserveView.delegate = self
        reserveView.headerView.backButton.addTarget(self,
                                                    action: #selector(backButtonTapped),
                                                    for: .touchUpInside
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    private func bindingData() {
        reserveViewModel.onError = { error in
            print(error)
        }
        reserveViewModel.onStateChanged = { [weak self] state in
            self?.reserveView.configure(item: state.movieData!)
        }
    }
}

extension ReserveViewController: ReserveViewDelegate {
    func reserveButtonTapped(inform: UserChoiceInform) {
        let alertMessage = reserveView.getMovieInfoString() + "\n\n결제하겠습니까?"
        let alert = UIAlertController(title: "결제 확인", message: alertMessage, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "예", style: .default) { [weak self] action in
            self?.reserveViewModel.action(.saveData(inform))
            self?.coordinator?.navigationController.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "아니요", style: .cancel) { action in

        }
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)

        coordinator?.showAnyAlert(alert)
    }

    @objc func backButtonTapped() {
        coordinator?.navigationController.popViewController(animated: true)
    }
}

@available(iOS 17.0, *)
#Preview {
    ReserveViewController(id: 154)
}
