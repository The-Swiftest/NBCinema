//
//  String+.swift
//  NBCinema
//
//  Created by Milou on 7/17/25.
//

import Foundation

extension String {
    /// "2025-07-16" 형태의 날짜를 "2025.07.16" 형태로 변환
    func toDotDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: self) else {
            return self
        }
        
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
    
    /// "2025-07-16" 형태의 날짜를 "07월 16일 (수)" 형태로 변환
    func toMonthDayString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: self) else {
            return self
        }
        
        formatter.dateFormat = "MM월 dd일 (EEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}
