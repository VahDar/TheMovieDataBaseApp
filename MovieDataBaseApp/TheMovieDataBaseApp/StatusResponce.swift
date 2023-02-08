//
//  statusResponce.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 14.01.2023.
//

import Foundation

enum httpError : Error {
    case jsonDecoding
    case noData
    case nonSuccessStatusCode
    case serverError
    case emptyCollection
    case emptyObject
    
}


class StatusResponce {
    
    static let shared = StatusResponce()
    private init() {}
    
     func statusResponce<T:Decodable>(request: URLRequest, responce: T.Type) async throws -> T {
        
        do {
            let (serverData, urlResponce) = try await URLSession.shared.data(for: request)
            
            guard let statusCode = (urlResponce as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else { throw httpError.nonSuccessStatusCode
            }
            
            return try JSONDecoder().decode(responce.self, from: serverData)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
}
