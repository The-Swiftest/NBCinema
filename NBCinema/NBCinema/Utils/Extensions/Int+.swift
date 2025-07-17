//
//  Int+.swift
//  NBCinema
//
//  Created by Milou on 7/17/25.
//

import Foundation

extension Int {
    /// 분 단위 시간을 "1시간 40분" 형태로 반환
    func toTimeString() -> String {
        let hours = self / 60
        let minutes = self % 60
        
        if hours > 0 && minutes > 0 {
            return "\(hours)시간 \(minutes)분"
        } else if hours > 0 {
            return "\(hours)시간"
        } else if minutes > 0 {
            return "\(minutes)분"
        } else {
            return "-"
        }
    }

    func toCommaString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "ko_KR")
        return numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
