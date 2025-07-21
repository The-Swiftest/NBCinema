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

    // MARK: - Lifecycle

    override func loadView() {
        self.view = reserveView
    }

    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
    }
}

@available(iOS 17.0, *)
#Preview {
    ReserveViewController()
}
