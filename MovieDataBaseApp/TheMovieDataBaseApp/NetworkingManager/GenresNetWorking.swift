//
//  GenresNetWorking.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 22.01.2023.
//

import Foundation
class GenresNetWorking {
    
    static let shared = GenresNetWorking()
    private init() {}
    
    //MARK: - Get movie genres
    func getMovieGenres() async throws -> [Genre]? {
        guard let url = URL(string: GenresUrl.getGenres.rawValue) else { return nil}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "get"
        
        do {
            let result = try await
            StatusResponce.shared.statusResponce(request: urlRequest, responce: Genres.self)
            return result.genres
        } catch {
            throw error
        }
    }
    
    //MARK: - Get TVs Genres
    func getTVGenre() async throws -> [Genre]? {
        guard let url = URL(string: GenresUrl.getTVGenres.rawValue) else {return nil}
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        guard let queryURL = urlComponents?.url else {return nil}
        var urlRequest = URLRequest(url: queryURL)
        urlRequest.httpMethod = "get"
        
        do {
            let result = try await
            StatusResponce.shared.statusResponce(request: urlRequest, responce: Genres.self)
            return result.genres
        }catch {
            throw error
        }
    }
    
    //MARK: - Get Movie
    func getMovie(with genre: String) async throws -> [Media]? {
        guard let url = URL(string: GenresUrl.getMovie.rawValue) else {return nil}
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [ URLQueryItem(name: "with_genres", value: genre),
                                      URLQueryItem(name: "api_key", value: "67f032f64d08b9fef26884d7cef4153f")]
        guard let queryURL = urlComponents?.url else {return nil}
        var urlRequest = URLRequest(url: queryURL)
        urlRequest.httpMethod = "get"
        
        do {
            let result = try await
            StatusResponce.shared.statusResponce(request: urlRequest, responce: MoviesByGenre.self)
            return result.results
        }catch{
            print(error.localizedDescription)
            throw error
        }
    }
    
    //MARK: - Get TV
    func getTV(with genre: String) async throws -> [Media]? {
        guard let url = URL(string: GenresUrl.getTV.rawValue) else {return nil}
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [URLQueryItem(name: "with_genres", value: genre),
                                     URLQueryItem(name: "api_key", value: "67f032f64d08b9fef26884d7cef4153f")]
        guard let queryURL = urlComponents?.url else {return nil}
        var urlRequest = URLRequest(url: queryURL)
        urlRequest.httpMethod = "get"
        
        do {
            let result = try await
            StatusResponce.shared.statusResponce(request: urlRequest, responce: MoviesByGenre.self)
            return result.results
        }catch {
            throw error
        }
    }
}
