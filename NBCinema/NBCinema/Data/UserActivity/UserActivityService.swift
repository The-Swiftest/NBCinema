//
//  UserActivityService.swift
//  NBCinema
//
//  Created by seongjun cho on 7/17/25.
//

import Foundation

import RealmSwift

class UserActivityService {
	// 예매 내역 정보 저장
	func saveReservationDetails(data: ReservationDetail) throws {
		do {
			let realm = try Realm()
			try realm.write {
				realm.add(data)
			}
		} catch {
			print("Error new, save realm \(error)")
		}
	}

	// 에매 내역 정보 가져오기
	func readReservationDetails() throws -> [ReservationDetail] {
		do {
			let realm = try Realm()
			return Array(realm.objects(ReservationDetail.self))
		} catch {
			print("Error new realm \(error)")
			throw error
		}
	}
}
