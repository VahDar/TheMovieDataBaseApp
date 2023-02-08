//
//  SearchViewModel.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 28.01.2023.
//

import Foundation
import RxCocoa
import RxSwift

class SearchViewModel {
    private let disposeBag = DisposeBag()
    //MARK: - Inputs
    private let searchSubject = PublishSubject<String>()
    var searchObserver: AnyObserver<String> {
        return searchSubject.asObserver()
    }
    
    //MARK: - Outputs
    private let loadingSubject = PublishSubject<Bool>()
    var isLoading: Driver<Bool> {
        return loadingSubject
            .asDriver(onErrorJustReturn: false)
    }
    
    private let errorSubject = PublishSubject<SearchError?>()
    var error: Driver<SearchError?> {
        return errorSubject
            .asDriver(onErrorJustReturn: SearchError.unknowed)
    }
    
    private let contentSubject = PublishSubject<[Media]>()
    var content: Driver<[Media]> {
        return contentSubject
            .asDriver(onErrorJustReturn: [])
    }
    
    func search(byTerm term: String) -> Observable<[Media]> {
        return SearchNetworking.shared.fetchSearchApi(movie: term)
    }
    
    
    
    init() {
        searchSubject
            .asObservable()
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
            .debounce(.seconds(2), scheduler: MainScheduler.instance)
            .flatMapLatest { [weak self] term -> Observable<[Media]> in
                guard let self = self else { return Observable.empty() }
                // every new try to search, the error signal will
                // emit nil to hide the error view
                self.errorSubject.onNext(nil)
                // switch to loading mode
                self.loadingSubject.onNext(true)
                return self.search(byTerm: term)
                    .catch { [weak self] error -> Observable<[Media]> in
                        guard let self = self else { return Observable.empty() }
                        self.errorSubject.onNext(SearchError.underlyingError(error))
                        return Observable.empty()
                    }
            }
            .subscribe(onNext: { [weak self] elements in
                guard let self = self else { return }
                self.loadingSubject.onNext(false)
                if elements.isEmpty {
                    self.errorSubject.onNext(SearchError.notFound)
                } else {
                    self.contentSubject.onNext(elements)
                }
            })
            .disposed(by: disposeBag)
    }
    
}
