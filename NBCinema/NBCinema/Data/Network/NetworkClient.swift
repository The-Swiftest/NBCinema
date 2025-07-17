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
    func request<T: Decodable>(url: URL) async throws(NetworkError) -> T {

        // URLRequest 생성
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(Config.tmdbAPIKey)", forHTTPHeaderField: "Authorization")
        
        do {
            // 네트워크 요청 수행
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // HTTP 응답 상태 확인
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknown
            }
            
            guard 200...299 ~= httpResponse.statusCode else {
                throw NetworkError.serverError(httpResponse.statusCode)
            }
            
            guard !data.isEmpty else {
                throw NetworkError.noData
            }
            
            // JSON Decoding
            let decoder = JSONDecoder()
            let result = try decoder.decode(T.self, from: data)
            return result
        }
        catch _ as DecodingError {
            throw NetworkError.decodingError
        }
        
        catch let urlError as URLError {
            throw NetworkError.networkError(urlError.localizedDescription)
        }
        
        catch {
            throw NetworkError.unknown
        }
    }
}
