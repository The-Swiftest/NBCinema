//
//  MyPageViewController.swift
//  NBCinema
//
//  Created by seongjun cho on 7/17/25.
//

import UIKit

class MyPageViewController: UIViewController {

    let myPageView = MyPageView()

    override func loadView() {
        view = myPageView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        var mockData = [ReservationDetail]()

        mockData.append(ReservationDetail(movieTitle: "a", reservationTime: Date(), runtime: 2, numberOfPeople: 3, amount: 4))
        mockData.append(ReservationDetail(movieTitle: "b", reservationTime: Date(), runtime: 3, numberOfPeople: 4, amount: 5))
        mockData.append(ReservationDetail(movieTitle: "a", reservationTime: Date(), runtime: 2, numberOfPeople: 3, amount: 4))
        mockData.append(ReservationDetail(movieTitle: "b", reservationTime: Date(), runtime: 3, numberOfPeople: 4, amount: 5))
        myPageView.makeReservationView(items: mockData)
    }
}

@available(iOS 18.0, *)
#Preview {
    MyPageViewController()
}
