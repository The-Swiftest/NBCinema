//
//  Date+.swift
//  NBCinema
//
//  Created by seongjun cho on 7/17/25.
//

import Foundation

extension Date {
    /// Date를  "07월 16일 (수) 09:00" 형식의 문자열로 변환
    func toMonthDayString() -> String {
        let formatter = DateFormatter()

        formatter.dateFormat = "MM월 dd일 (EEE) HH:mm"
        formatter.locale = Locale(identifier: "ko_KR")

        let str = formatter.string(from: self)

        return str
    }
}
