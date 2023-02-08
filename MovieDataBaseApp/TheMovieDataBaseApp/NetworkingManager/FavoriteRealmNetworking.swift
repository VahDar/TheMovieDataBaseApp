//
//  FavoriteRealmNetworking.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 02.02.2023.
//

import RxRealm
import Foundation
import RealmSwift
import RxSwift
import RxCocoa
import RxRelay

struct FavoriteRealmNetworking {
    let disposeBag = DisposeBag()
    static let shared = FavoriteRealmNetworking()
    private init() {}
    
    // MARK: - Save data (movie)
    func saveDataMovie(movie medias: [Media]) {
        DispatchQueue.main.async {
            let realm = try? Realm()
            var realmMovie = [MovieRealm]()
            medias.forEach { media in
                let movieRealm = MovieRealm()
                movieRealm.overview = media.overview
                movieRealm.voteAverage = media.voteAverage
                movieRealm.name = media.name
                movieRealm.posterPath = media.posterPath
                movieRealm.id = media.id
                movieRealm.backdropPath = media.backdropPath
                movieRealm.title = media.title
                realmMovie.append(movieRealm)
            }
            try? realm?.write ({
                realm?.add(realmMovie, update: .modified)
            })
        }
    }
    
    
    func getMovie() -> Observable<[Media]> {
        let result = BehaviorRelay(value: [Media]())
        DispatchQueue.main.async {
            let realm = try? Realm()
            guard let movieResult = realm?.objects(MovieRealm.self) else { return }
            Observable.collection(from: movieResult)
                .map {
                convert(movies: $0) }
            .subscribe { resultSave in
                result.accept(resultSave.element ?? [])
            }.disposed(by: disposeBag)
            
        }
        return result.asObservable()
    }
    
    private func convert(movies: Results<MovieRealm>) -> [Media] {
        var medias: [Media] = []
        movies.forEach { movie in
            let media = Media(backdropPath: movie.backdropPath,
                              id: movie.id,
                              name: movie.name,
                              overview: movie.overview,
                              posterPath: movie.posterPath,
                              title: movie.title,
                              voteAverage: movie.voteAverage)
            medias.append(media)
        }
        return medias
    }
    
    // MARK: - Save data (TV)
    func saveDataTV(TV medias: [Media]) {
        DispatchQueue.main.async {
            let realm = try? Realm()
            var realmTV = [TVRealm]()
            medias.forEach { media in
                let TVRealm = TVRealm()
                TVRealm.overview = media.overview
                TVRealm.voteAverage = media.voteAverage
                TVRealm.name = media.name
                TVRealm.posterPath = media.posterPath
                TVRealm.id = media.id
                TVRealm.backdropPath = media.backdropPath
                TVRealm.title = media.title
                realmTV.append(TVRealm)
            }
            try? realm?.write ({
                realm?.add(realmTV, update: .modified)
            })
        }
    }
    
    func getTV() -> Observable<[Media]> {
        let result = BehaviorRelay(value: [Media]())
        DispatchQueue.main.async {
            let realm = try? Realm()
            guard let tvResult = realm?.objects(TVRealm.self) else { return }
            Observable.collection(from: tvResult)
                .map {
                convert(tvs: $0) }
            .subscribe { resultSave in
                result.accept(resultSave.element ?? [])
            }.disposed(by: disposeBag)
            
        }
        return result.asObservable()
    }
    
    private func convert(tvs: Results<TVRealm>) -> [Media] {
        var medias: [Media] = []
        tvs.forEach { tv in
            let media = Media(backdropPath: tv.backdropPath,
                              id: tv.id,
                              name: tv.name,
                              overview: tv.overview,
                              posterPath: tv.posterPath,
                              title: tv.title,
                              voteAverage: tv.voteAverage)
            medias.append(media)
        }
        return medias
    }
    
    func deleteCache() {
        let realm = try? Realm()
        try? realm?.write({
            realm?.deleteAll()
        })
    }
}
