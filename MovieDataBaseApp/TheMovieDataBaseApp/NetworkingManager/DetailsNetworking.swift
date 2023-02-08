//
//  DetailsNetworking.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 26.01.2023.
//

import Foundation

class TrailersNetworking {
    static let shared = TrailersNetworking()
    private init() {}
    // fetch trailers
    
    func fetchTrailer(movieID: Int, type: String) async throws -> [Result]? {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/\(type)/\(movieID)/videos?api_key=67f032f64d08b9fef26884d7cef4153f") else { return nil}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "get"
        do {
            let result = try await
            StatusResponce.shared.statusResponce(request: urlRequest, responce: Trailers.self )
            return result.results
        } catch {
            throw error
        }
    }
}
