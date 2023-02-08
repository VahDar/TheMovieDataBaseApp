//
//  FavoriteModel.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 30.01.2023.
//
import RealmSwift
import Foundation

// MARK: - FavoriteBodyModel
struct FavoriteBodyModel: Codable {
    let mediaType: String
    let mediaID: Int
    let favorite: Bool
    
    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case mediaID = "media_id"
        case favorite
    }
}

// MARK: - FavoriteResponce
struct FavoriteResponce: Codable {
    let success: Bool
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}


class MovieRealm: Object {
    
    
    @Persisted var backdropPath: String?
    @Persisted(primaryKey: true) var id: Int
    @Persisted var posterPath: String?
    @Persisted var name: String?
    @Persisted var voteAverage: Double
    @Persisted var overview: String
    @Persisted var title: String?
    
}

class TVRealm: Object {
    
    
    @Persisted var backdropPath: String?
    @Persisted(primaryKey: true) var id: Int
    @Persisted var posterPath: String?
    @Persisted var name: String?
    @Persisted var voteAverage: Double
    @Persisted var overview: String
    @Persisted var title: String?
    
}


