//
//  ReserveViewModel.swift
//  NBCinema
//
//  Created by seongjun cho on 7/21/25.
//

import Foundation

struct UserChoiceInform {
    let reservationTime: Date
    let numOfPeople: Int
    let amount: Int
}

final class ReserveViewModel: ViewModelProtocol {
    enum Action {
        case fetchData(id: Int)
        case saveData(UserChoiceInform)
    }

    struct State {
        var movieData: MovieDetail?
    }

    // state
    private(set) var state: State {
        didSet {
            onStateChanged?(state)
        }
    }

    init(movieService: MovieRepository, userActivityService: UserActivityRepository) {
        self.state = State(movieData: nil)
        self.movieService = movieService
        self.userActivityService = userActivityService
    }

    private let movieService: MovieRepository
    private let userActivityService: UserActivityRepository

    // 클로저
    var onStateChanged: ((State) -> Void)? // 데이터 변화 감지
    var onError: ((Error) -> Void)? // 에러 발생 전달

    // action
    func action(_ action: Action) {
        do {
            switch action {
            case .fetchData(let id):
                try fetchData(id: id)
            case .saveData(let userChoiceData):
                try saveData(data: userChoiceData)
            }
        } catch {
            print(error)
            onError!(error)
        }
    }

    private func fetchData(id: Int) throws {
        Task {
            do {
                state.movieData = try await movieService.fetchMovieDetail(id: id)
            } catch {
                throw error
            }
        }
    }

    private func saveData(data: UserChoiceInform) throws {
        let reservationDetail = ReservationDetail(movieTitle: state.movieData?.title ?? "",
                                                  reservationTime: data.reservationTime,
                                                  runtime: state.movieData?.runtime ?? 0,
                                                  numberOfPeople: data.numOfPeople,
                                                  amount: data.amount,
                                                  posterPath: state.movieData?.posterPath ?? ""
            )
        do {
            try userActivityService.saveReservationDetails(data: reservationDetail)
        } catch {
            throw error
        }
    }
}
