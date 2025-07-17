//
//  ReservationDetail.swift
//  NBCinema
//
//  Created by seongjun cho on 7/17/25.
//

import Foundation

import RealmSwift

class ReservationDetail: Object {
	@Persisted var movieTitle: String
	@Persisted var reservationTime: Date
	@Persisted var runtime: Int
	@Persisted var numberOfPeople: Int
	@Persisted var amount: Int

	convenience init(movieTitle: String,
					 reservationTime: Date,
					 runtime: Int,
					 numberOfPeople: Int,
					 amount: Int) {
		self.init()
		self.movieTitle = movieTitle
		self.reservationTime = reservationTime
		self.runtime = runtime
		self.numberOfPeople = numberOfPeople
		self.amount = amount
	}
}
