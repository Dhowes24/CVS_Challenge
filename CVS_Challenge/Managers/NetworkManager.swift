//
//  NetworkManager.swift
//  CVS_Challenge
//
//  Created by Derek Howes on 7/13/24.
//

import Foundation

final class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    
    private init() {}
    
    
    func request<T:Codable>(_ endpoint: String, resultType: T.Type) async throws -> T{
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }
            
            do {
                let result = try JSONDecoder().decode(resultType.self, from: data)
                return result
            } catch {
                throw NetworkError.decodingFailed(description: error.localizedDescription)
            }
            
        } catch {
            throw NetworkError.requestFailed(description: error.localizedDescription)
        }
    }
}


enum NetworkError: Error, LocalizedError, Equatable {
    case invalidURL
    case requestFailed(description: String)
    case invalidResponse
    case decodingFailed(description: String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .requestFailed(let description):
            return "The request failed with error: \(description)"
        case .invalidResponse:
            return "The server response was invalid."
        case .decodingFailed(let description):
            return "Failed to decode the response: \(description)"
        }
    }
}
