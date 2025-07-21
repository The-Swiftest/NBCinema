//
//  ReserveViewController.swift
//  NBCinema
//
//  Created by seongjun cho on 7/18/25.
//

import UIKit

class ReserveViewController: UIViewController {
    //weak var coordinator: ReserveCoodinator?
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
        tabBarController?.tabBar.isHidden = true
        bindingData()
        reserveViewModel.action(.fetchData(id: id))
        reserveView.delegate = self
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
        reserveViewModel.action(.saveData(inform))
    }
}

@available(iOS 17.0, *)
#Preview {
    ReserveViewController(id: 154)
}
