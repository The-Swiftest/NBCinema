//
//  MyPageViewModel.swift
//  NBCinema
//
//  Created by seongjun cho on 7/17/25.
//

import Foundation

class MyPageViewModel: ViewModelProtocol {
    enum Action {
        case fetchReservationData
        case fetchFavoriteData
        case deleteFavorite(movieTitle: String)
    }

    struct State {
        var reservationData: [ReservationDetail]
        var favoriteData: [FavoriteMovie]
    }

    // state
    private(set) var state: State {
        didSet {
            onStateChanged?(state)
        }
    }

    init() {
        self.state = State(
            reservationData: [ReservationDetail](),
            favoriteData: [FavoriteMovie]()
        )
    }

    private let userActivityService = UserActivityService()
    // 클로저
    var onStateChanged: ((State) -> Void)? // 데이터 변화 감지
    var onError: ((Error) -> Void)? // 에러 발생 전달

    // action
    func action(_ action: Action) {
        do {
            switch action {
            case .fetchReservationData:
                try fetchReservationData()
            case .fetchFavoriteData:
                try fetchFavoriteData()
            case .deleteFavorite(let movieTitle):
                try deleteFavorite(movieTitle: movieTitle)
            }
        } catch {
            print(error)
            onError!(error)
        }
    }

    private func deleteFavorite(movieTitle: String) throws {
        do {
            try userActivityService.deleteFavorite(movieTitle: movieTitle)
            try fetchFavoriteData() // 삭제 후 데이터 다시 로드
        } catch {
            throw error
        }
    }

    private func fetchReservationData() throws {
        do {
            state.reservationData = try userActivityService.readReservationDetails()
        } catch {
            throw error
        }
    }

    func getReservationData() -> [ReservationDetail] {
        return state.reservationData
    }

    private func fetchFavoriteData() throws {
        do {
            state.favoriteData = try userActivityService.readFavorites()
        } catch {
            throw error
        }
    }

    func getFavoriteData() -> [FavoriteMovie] {
        return state.favoriteData
    }
}
