//
//  UserActivityRepository.swift
//  NBCinema
//
//  Created by seongjun cho on 7/21/25.
//

protocol UserActivityRepository {
    /// 예매 내역 정보 저장
    func saveReservationDetails(data: ReservationDetail) throws

    /// 에매 내역 정보 가져오기
    func readReservationDetails() throws -> [ReservationDetail]
}
