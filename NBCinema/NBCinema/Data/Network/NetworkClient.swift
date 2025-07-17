//
//  NetworkClient.swift
//  NBCinema
//
//  Created by Milou on 7/16/25.
//

import Foundation

final class NetworkClient {
    
    static let shared = NetworkClient()
    private init() {}
    
    /// GET 요청
    func request<T: Decodable>(url: URL) async -> Result<T, NetworkError> {
        do {
            // URLRequest 생성
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(Config.tmdbAPIKey)", forHTTPHeaderField: "Authorization")
            
            // 네트워크 요청 수행
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // HTTP 응답 상태 확인
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.unknown)
            }
            
            guard 200...299 ~= httpResponse.statusCode else {
                return .failure(.serverError(httpResponse.statusCode))
            }
            
            guard !data.isEmpty else {
                return .failure(.noData)
            }
            
            // JSON Decoding
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                return .success(result)
            } catch {
                return .failure(.decodingError)
            }
            
        } catch {
            return .failure(.networkError(error.localizedDescription))
        }
    }
}
