//
//  GenresViewModel.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 22.01.2023.
//

import Foundation
import RxCocoa
import RxSwift
import RxDataSources

class GenresViewModel {
    

    static var positionSegmental: SwichType = .tv
    var genreTv = BehaviorRelay<[Genre]>(value: [])
    var genreMovie = BehaviorRelay<[Genre]>(value: [])
    
    var sourceDataTableView = PublishSubject<Observable<[Genre]>>()
    
    //MARK: - Get movi genres list
    func movieGenres() async throws {
        do {
            guard let genre =  try await GenresNetWorking.shared.getMovieGenres() else { return }
            genreMovie.accept(genre)
            sourceDataTableView.onNext(genreMovie.asObservable())
            }
        }
    
    //MARK: - Get TV genres list
    func tvGenres() async throws {
        do {
            guard let genre =  try await
                    GenresNetWorking.shared.getTVGenre() else {
                return }
            genreTv.accept(genre)
            sourceDataTableView.onNext(genreTv.asObservable())
        }
    }
    
    let data = BehaviorRelay<[GenreAnimatedSectionModel]>(value: [GenreAnimatedSectionModel(header: "movie", items: [])])
    
    //MARK: - Get movi by genres
    func getMovieByGenre(genre: Int) async throws {
            guard let genreR = try await
                    GenresNetWorking.shared.getMovie(with: String(genre)) else {return}
        DispatchQueue.main.async {
            self.data.accept([GenreAnimatedSectionModel(header: "movie result", items: genreR)])
        }


    }
    
    //MARK: - Get TV by genres
    func getTVByGenre(genre: Int) async throws {
        do {
            guard let genre = try await
                    GenresNetWorking.shared.getTV(with: String(genre)) else {return}
            data.accept([GenreAnimatedSectionModel(header: "tv result", items: genre)])
        }
    }
}

