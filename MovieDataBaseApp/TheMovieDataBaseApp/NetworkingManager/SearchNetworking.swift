//
//  SearchNetworking.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 29.01.2023.
//

import Foundation
import RxCocoa
import RxSwift

class SearchNetworking {
    static let shared = SearchNetworking()
    private init() {}
    
    func fetchSearchApi(movie: String) -> Observable<[Media]> {
        
        return Observable.create { observe in
            
            guard let url = URL(string: MultuSearch.multiSearch.rawValue) else {return Disposables.create()}
            var urlComponetns = URLComponents(url: url, resolvingAgainstBaseURL: false)
            urlComponetns?.queryItems = [ URLQueryItem(name: "api_key", value: MultuSearch.apiKey.rawValue), URLQueryItem(name: "query", value: movie)]
            
            guard let queryURL = urlComponetns?.url else {return Disposables.create()}
            var dataTask: URLSessionDataTask
           dataTask = URLSession.shared.dataTask(with: queryURL) { data, responce, error in
                guard let data = data, error == nil else { return }
                do {
                    let result = try
                    JSONDecoder().decode(MoviesByGenre.self, from: data)
                    observe.onNext(result.results)
                } catch {
                    observe.onError(error)
                }
               observe.onCompleted()
            }
              dataTask.resume()
            return Disposables.create {
                return dataTask.cancel()
            }
        }
    }
    
    
    
    
    
    
}
