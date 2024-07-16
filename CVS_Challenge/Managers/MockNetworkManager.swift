//
//  MockNetworkManager.swift
//  CVS_Challenge
//
//  Created by Derek Howes on 7/14/24.
//

import Foundation

class MockNetworkManager: NetworkManagerProtocol {
    var data: Data?
    var error: Error?
    
    init(data: Data? = nil, error: Error? = nil) {
        self.data = data
        self.error = error
    }
    
    
    func request<T: Codable>(_ endpoint: String, resultType: T.Type) async throws -> T {
        if let error = error {
            throw error
        }
        
        guard let data = data else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let result = try JSONDecoder().decode(resultType.self, from: data)
            return result
        } catch {
            throw NetworkError.decodingFailed(description: error.localizedDescription)
        }
    }
}
