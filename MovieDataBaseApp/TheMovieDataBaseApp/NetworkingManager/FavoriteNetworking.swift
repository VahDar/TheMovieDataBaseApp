//
//  FavoriteNetworking.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 30.01.2023.
//
import RxRealm
import Foundation
import RealmSwift
import RxSwift
import RxCocoa
import RxRelay

struct FavoriteNetworking {
    static let shared = FavoriteNetworking()
    private init() {}
    let disposeBag = DisposeBag()
    
    //MARK: - Fetch favorite (media)
    func fetchFavorite(media type: SwichType,
                       user ID: Int,
                       sessionID: String) -> Observable<[Media]> {
        return Observable.create { observ in
            let url = URL(string: Favorit.account.rawValue + "/\(ID)" +
                          Favorit.favorite.rawValue + "/" + type.rawValue)!
            var urlComponents = URLComponents (url: url, resolvingAgainstBaseURL: false)
            urlComponents?.queryItems = [ URLQueryItem(name: "api_key", value: Favorit.apiKey.rawValue), URLQueryItem(name: "session_id", value: sessionID), URLQueryItem(name: "sort_by", value: "created_at.asc")]
            let queryURl = urlComponents!.url!
            print(queryURl)
            var dataTask: URLSessionDataTask
            dataTask = URLSession.shared.dataTask(with: queryURl) { data, responce, error in
                guard let data = data, error == nil else {return}
                do {
                    let result = try
                    JSONDecoder().decode(MoviesByGenre.self, from: data)
                    observ.onNext(result.results)
                } catch {
                    observ.onError(error)
                }
                observ.onCompleted()
            }
            dataTask.resume()
            return Disposables.create {
                return dataTask.cancel()
            }
            
        }
        
    }
    
    func favoriteUpdate(media type: String,
                        user ID: Int,
                        add: Bool,
                        mediaID: Int,
                        sessionID:
                        String,
                        complition: @escaping (FavoriteResponce) -> ()) {
        let favBody = FavoriteBodyModel(mediaType: type, mediaID: mediaID, favorite: add)
        let favData = try? JSONEncoder().encode(favBody)
        guard let url = URL(string: Favorit.account.rawValue + "/\(ID)" + Favorit.favorite.rawValue),
              let data = favData else {return}
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [ URLQueryItem(name: "api_key", value: Favorit.apiKey.rawValue), URLQueryItem(name: "session_id", value: sessionID)]
        guard let queryURL = urlComponents?.url else {return}
        
        var request = URLRequest(url: queryURL)
        print(queryURL)
        request.httpMethod = "post"
        request.httpBody = data
        request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
                   guard let data = data, error == nil else {
                       print("Error")
                       return
                   }
                   do {
                       let result = try JSONDecoder().decode(FavoriteResponce.self, from: data)
                       complition(result)
                   }
                   catch {
                       print("Error: \(error.localizedDescription)")
                   }
        }.resume()
        
    }
    
}
