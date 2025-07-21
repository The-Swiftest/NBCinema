//
//  UserActivityService.swift
//  NBCinema
//
//  Created by seongjun cho on 7/17/25.
//

import Foundation

import RealmSwift
import UIKit

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
			throw error
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

    /// 찜하기 저장
    func saveFavorite(data: FavoriteMovie) throws {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("Error new, save realm \(error)")
            throw error
        }
    }

    /// 찜빼기
    func deleteFavorite(movieTitle: String) throws {
        do {
            let realm = try Realm()
            let favoritedMovie = realm.objects(FavoriteMovie.self).filter { $0.movieTitle == movieTitle }

            try realm.write {
                realm.delete(favoritedMovie)
            }
        } catch {
            print("Error deleting object \(error)")
            throw error
        }
    }


    /// 찜하기 내역 정보 가져오기
    func readFavorites() throws -> [FavoriteMovie] {
        do {
            let realm = try Realm()
            return Array(realm.objects(FavoriteMovie.self))
        } catch {
            print("Error new realm \(error)")
            throw error
        }
    }
}
