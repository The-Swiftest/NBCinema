//
//  MyPageViewModel.swift
//  NBCinema
//
//  Created by seongjun cho on 7/17/25.
//

import Foundation

class MyPageViewModel: ViewModelProtocol {
    enum Action {
        case fetchData
    }

    struct State {
        var reservationData: [ReservationDetail]
    }

    // state
    private(set) var state: State {
        didSet {
            onStateChanged?(state)
        }
    }

    init() {
        self.state = State(reservationData: [ReservationDetail]())
    }

    private let userActivityService = UserActivityService()
    // 클로저
    var onStateChanged: ((State) -> Void)? // 데이터 변화 감지
    var onError: ((Error) -> Void)? // 에러 발생 전달

    // action
    func action(_ action: Action) {
        do {
            switch action {
            case .fetchData:
                try fetchData()
            }
        } catch {
            print(error)
            onError!(error)
        }
    }

    private func fetchData() throws {
        do {
            state.reservationData = try userActivityService.readReservationDetails()
        } catch {
            throw error
        }
    }
}

protocol ViewModelProtocol {
    associatedtype Action
    associatedtype State

    func action(_ action: Action)
    var state: State { get }
}


