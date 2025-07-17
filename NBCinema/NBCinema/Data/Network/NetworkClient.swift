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
            // 성공 로그
            #if DEBUG
            print("✅ API 호출 성공: \(url)")
            print("📊 응답 데이터 크기: \(data.count) bytes")
            #endif
            return result
        }
        
        catch let decodingError as DecodingError {
            throw NetworkError.decodingError  // 디코딩 에러
        } catch let networkError as NetworkError {
            throw networkError  // 이미 NetworkError인 경우 그대로 던지기
        } catch {
            throw NetworkError.networkError(error.localizedDescription)  // 기타 에러
        }
    }
}
