//
//  NetworkError.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(Int)
    case networkError(String)
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "잘못된 URL입니다."
        case .noData:
            return "데이터를 찾을 수 없습니다."
        case .decodingError:
            return "데이터 파싱에 실패했습니다."
        case .serverError(let statuscode):
            return "서버 오류: \(statuscode)"
        case .networkError(let message):
            return "네트워크 오류: \(message)"
        case .unknown:
            return "알 수 없는 오류가 발생했습니다."
        }
    }
}
