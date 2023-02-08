//
//  TheMovieDBAPIs.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 11.01.2023.
//

import Foundation
import UIKit



struct TheMDBAPIs {
    static let apiKey: URL = URL(string: "67f032f64d08b9fef26884d7cef4153f")!
    static let baseAPIURL: URL = URL(string: "https://api.themoviedb.org/3/")!
    static let newToken: URL = URL(string: "https://api.themoviedb.org/3/authentication/token/new?api_key=67f032f64d08b9fef26884d7cef4153f")!
    static let validateUser: URL = URL(string: "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=67f032f64d08b9fef26884d7cef4153f")!
    static let createSession: URL = URL(string: "https://api.themoviedb.org/3/authentication/session/new?api_key=67f032f64d08b9fef26884d7cef4153f")!
    static let deleteSession: URL = URL(string: "https://api.themoviedb.org/3/authentication/session?api_key=67f032f64d08b9fef26884d7cef4153f")!
    static let guestSession: URL = URL(string: "https://api.themoviedb.org/3/authentication/guest_session/new?api_key=67f032f64d08b9fef26884d7cef4153f")!
    static let getDetails: URL = URL(string: "https://api.themoviedb.org/3/account?api_key=67f032f64d08b9fef26884d7cef4153f&")!
}
enum Favorit: String {
    case apiKey = "67f032f64d08b9fef26884d7cef4153f"
    case account = "https://api.themoviedb.org/3/account"
    case favorite = "/favorite"
}
enum GetDetails: String {
    case apiKey = "67f032f64d08b9fef26884d7cef4153f"
    case account = "https://api.themoviedb.org/3/account"
    
}

enum MultuSearch: String {
    
    case multiSearch = "https://api.themoviedb.org/3/search/multi"
    case search = "https://api.themoviedb.org/3/search/movie"
    case apiKey = "67f032f64d08b9fef26884d7cef4153f"
}

enum GenresUrl: String {
    
    case getGenres = "https://api.themoviedb.org/3/genre/movie/list?api_key=67f032f64d08b9fef26884d7cef4153f"
    case getTVGenres = "https://api.themoviedb.org/3/genre/tv/list?api_key=67f032f64d08b9fef26884d7cef4153f"
    case getMovie = "https://api.themoviedb.org/3/discover/movie?api_key=67f032f64d08b9fef26884d7cef4153f"
    case getTV = "https://api.themoviedb.org/3/discover/tv?api_key=67f032f64d08b9fef26884d7cef4153f"
    case imagePoster = "https://image.tmdb.org/t/p/original"
}

enum SwichType: String {
    case movie
    case movies
    case tv
}

enum SearchError: Error {
    case underlyingError(Error)
    case notFound
    case unknowed
}
