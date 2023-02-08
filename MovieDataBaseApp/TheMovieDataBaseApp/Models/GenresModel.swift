//
//  GenresModel.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 19.01.2023.
//

import Foundation
import RxDataSources

// MARK: - Genres
struct Genres: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

// MARK: - MoviesByGenres
struct MoviesByGenre: Codable {
    let page: Int
    let results: [Media]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
// MARK: - Media
struct Media: Codable, IdentifiableType, Equatable, Hashable {
    var identity: Int { return id }
    
    typealias Identity = Int
    
    let backdropPath: String?
    let id: Int
    let name: String?
    let overview: String
    let posterPath: String?
    let title: String?
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case overview
        case posterPath = "poster_path"
        case title
        case voteAverage = "vote_average"
        case name
    }
}



// MARK: - Section for RxDataSource
struct GenreAnimatedSectionModel {
    let header: String
    var items: [Item]
}

extension GenreAnimatedSectionModel: AnimatableSectionModelType {
    
    typealias Item = Media
    typealias Identity = String
    
    init(original: GenreAnimatedSectionModel, items: [Media]) {
        self.items = items
        self = original
    }
    var identity: String {
        return header
    }
}
