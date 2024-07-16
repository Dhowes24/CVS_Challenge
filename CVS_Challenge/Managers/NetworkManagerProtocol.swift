//
//  NetworkManagerProtocol.swift
//  CVS_Challenge
//
//  Created by Derek Howes on 7/13/24.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<T: Codable>(_ endpoint: String, resultType: T.Type) async throws -> T
}
