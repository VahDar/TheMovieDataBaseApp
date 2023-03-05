//
//  DetailsViewModel.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 26.01.2023.
//

import Foundation
import RxCocoa
import RxSwift

class DetailsViewModel {
    
    private let disposeBag = DisposeBag()
    private let trailerVideo = BehaviorRelay<String>(value: "")
    var movie: Media
    
    var video: Driver<String> {
        return trailerVideo.asDriver(onErrorJustReturn: "")
    }
    init(movie: Media) {
        self.movie = movie
        Task {
            try? await dataDetails()
        }
    }
    
    func dataDetails () async throws {
        Task {
            guard let result = try await TrailersNetworking.shared.fetchTrailer(movieID: movie.id, type: GenresViewModel.positionSegmental.rawValue) else {return}
            var trailerKey = ""
            result.forEach { video in
                if video.type == "Trailer" {
                    trailerKey = video.key
                }
            }
            trailerVideo.accept(trailerKey)
        }
    }
    
    func updateFavorite(add: Bool, complition: @escaping (FavoriteResponce) -> ()) {
        FavoriteNetworking
            .shared
            .favoriteUpdate(media: GenresViewModel.positionSegmental.rawValue,
                            user: AuthenticalNetworking.shared.userID,
                            add: add,
                            mediaID: movie.id,
                            sessionID: AuthenticalNetworking.shared.sessionID) { responce in
                complition(responce)
            }
    }
}
