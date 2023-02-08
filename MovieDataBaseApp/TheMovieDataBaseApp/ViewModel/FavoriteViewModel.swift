//
//  FavoriteViewModel.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 02.02.2023.
//


import Foundation
import RealmSwift
import RxSwift
import RxRelay
import RxCocoa

class FavoriteViewModel {
    var swichType: SwichType = .movies
    private let disposeBag = DisposeBag()
    private let favoriteSubject = PublishSubject<[Media]>()
    var content: Driver<[Media]> {
        return favoriteSubject
            .asDriver(onErrorJustReturn: [])
    }
    
        func favList() {
            
            FavoriteFechData.shared.fetchData(media: swichType)
                .subscribe { [weak self] elements in
                    self?.favoriteSubject.onNext(elements)
                }.disposed(by: disposeBag)
        }
            func updateFav(mediaID: Int, complition: @escaping (FavoriteResponce) -> ()) {
                var someMedia = ""
                if swichType.rawValue == "movies" {
                    someMedia = "movie"
                } else {
                    someMedia = "tv"
                }
                FavoriteNetworking
                    .shared
                    .favoriteUpdate(media: someMedia,
                user: AuthenticalNetworking.shared.userID,
                add: false,
                mediaID: mediaID,
                sessionID: AuthenticalNetworking.shared.sessionID) {
                    responce in
                    complition(responce)
                    FavoriteRealmNetworking.shared.deleteCache()
        }
    }
}

