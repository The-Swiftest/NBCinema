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
        refreshDatas()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        myPageView.logoutButton.addTarget(self,
                                          action: #selector(logoutTapped),
                                          for: .touchUpInside
        )
        
        myPageView.reservationsMoreButton.addTarget(
            self,
            action: #selector(reservationMoreTapped),
            for: .touchUpInside
        )
        myPageView.favoriteMoreButton.addTarget(self, action: #selector(favoriteMoreTapped), for: .touchUpInside)
        myPageView.favoriteTrashButtonTapped = { [weak self] movieTitle in
            self?.myPageViewModel.action(.deleteFavorite(movieTitle: movieTitle))
            self?.refreshDatas()
        }
    }

    private func refreshDatas() {
        var reservationData = [ReservationDetail]()
        var favoriteData = [FavoriteMovie]()

        // reservationData 요청 설정
        myPageViewModel.onStateChanged = { state in
            for (idx, item) in state.reservationData.enumerated() {
                if idx < 2 {
                    reservationData.append(item)
                } else {
                    break
                }
            }
        }

        // 에러 설정
        myPageViewModel.onError = { [weak self] error in
            print(error)
            let alert = UIAlertController(
                title: "오류",
                message: "데이터 갱신에 실패하였습니다.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self?.coordinator?.showErrorAlert(alert: alert)
        }

        // 데이터 요청
        myPageViewModel.action(.fetchReservationData)

        // favorite 데이터 요청 설정
        myPageViewModel.onStateChanged = { state in
            for (idx, item) in state.favoriteData.enumerated() {
                if idx < 2 {
                    favoriteData.append(item)
                } else {
                    break
                }
            }
        }

        // 데이터 요청
        myPageViewModel.action(.fetchFavoriteData)

        // 뷰 생성
        myPageView.makeReservationView(items: reservationData)
        myPageView.makeFavoriteView(items: favoriteData)
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

    @objc private func reservationMoreTapped() {
        coordinator?.showBookingHistory(
            reservationData: self.myPageViewModel.getReservationData())
    }

    @objc private func favoriteMoreTapped() {
        coordinator?.showFavoriteMovies(
            favoriteData: self.myPageViewModel.getFavoriteData())
    }
}

@available(iOS 18.0, *)
#Preview {
    MyPageViewController()
}
