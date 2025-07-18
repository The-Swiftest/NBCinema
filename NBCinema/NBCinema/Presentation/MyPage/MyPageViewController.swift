//
//  MyPageViewController.swift
//  NBCinema
//
//  Created by seongjun cho on 7/17/25.
//

import UIKit

class MyPageViewController: UIViewController {
    weak var coordinator: MyPageCoordinator?
    let myPageView = MyPageView()
    let myPageViewModel = MyPageViewModel()

    override func loadView() {
        view = myPageView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        refreshReservations()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        myPageView.logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }

    private func refreshReservations() {
        var reservationData = [ReservationDetail]()

        myPageViewModel.onStateChanged = { state in
            for (idx, item) in state.reservationData.enumerated() {
                if idx < 4 {
                    reservationData.append(item)
                } else {
                    break
                }
            }
        }

        myPageViewModel.onError = { [weak self] error in
            print(error)
            let alert = UIAlertController(
                title: "오류",
                message: "데이터 갱신에 실패하였습니다.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self?.present(alert, animated: true, completion: nil)
        }

        myPageViewModel.action(.fetchData)
        myPageView.makeReservationView(items: reservationData)
    }
}

extension MyPageViewController {
    @objc private func logoutTapped() {
        guard coordinator != nil else {
            print("Mypage coordinator is nil")
            return
        }
        coordinator!.delegate?.myPageCoordinatorDidLogout(coordinator!)
    }
}

@available(iOS 18.0, *)
#Preview {
    MyPageViewController()
}
