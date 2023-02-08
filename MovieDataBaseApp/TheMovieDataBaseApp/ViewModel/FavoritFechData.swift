//
//  FavoritFechData.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 02.02.2023.
//
import RxSwift
import RxRelay
import RxRealm
import Foundation
import RealmSwift

struct FavoriteFechData {
    private let disposeBag = DisposeBag()
    
    static let shared = FavoriteFechData()
    private init() {}
    let realm = try? Realm()
    
    func fetchData(media type: SwichType) -> Observable<[Media]> {
        let result = BehaviorRelay(value: [Media]())
        FavoriteNetworking.shared.fetchFavorite(media: type,
                                                user: AuthenticalNetworking.shared.userID,
                                                sessionID: AuthenticalNetworking.shared.sessionID)
        .subscribe { favMedia in
            guard let media = favMedia.element else {return}
            switch type {
            case .tv:
                FavoriteRealmNetworking.shared.saveDataTV(TV: media)
                FavoriteRealmNetworking.shared.getTV().subscribe { media in
                    result.accept(media)
                }.disposed(by: disposeBag)
            case .movie:
                break
            case .movies:
                FavoriteRealmNetworking.shared.saveDataMovie(movie: media)
                FavoriteRealmNetworking.shared.getMovie().subscribe { media in
                    result.accept(media)
                }.disposed(by: disposeBag)
            }
        }.disposed(by: disposeBag)
        return result.asObservable()
    }
}
