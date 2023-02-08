//
//  SearchViewController.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 28.01.2023.
//
import RxSwift
import RxCocoa
import UIKit

class SearchViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    let searchViewModel = SearchViewModel()
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    
    var errorView: UIView? {
        errorLabel.text = "Video not found"
        return errorLabel
    }
    
    var loadingView: UIView? {
        return nil
    }
    
    //    var contentView:UIView {
    //        fatalError("Error")
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorView?.isHidden = true
        loadingView?.isHidden = true
        toDetailScreen()
        bindViews()
        observes()
        setup()
    }
    
    //MARK: - bind searchView
    
    private func bindViews() {
        searchBar
            .rx
            .text
            .orEmpty
            .bind(to: self.searchViewModel.searchObserver)
            .disposed(by: disposeBag)
        
        searchViewModel
            .isLoading
            .asDriver()
            .drive(tableView.rx.isHidden)
            .disposed(by: disposeBag)
        
        if let loadingView = loadingView {
            searchViewModel.isLoading
                .map(!)
                .drive(loadingView.rx.isHidden)
                .disposed(by: disposeBag)
            searchViewModel.error
                .map { $0 != nil }
                .drive(loadingView.rx.isHidden)
                .disposed(by: disposeBag)
        }
        
        if let errorView = errorView {
            searchViewModel.error
                .map { $0 == nil }
                .drive(errorView.rx.isHidden)
                .disposed(by: disposeBag)
        }
        
    }
    
    private func observes() {
        searchViewModel
            .content
            .drive(tableView.rx.items(cellIdentifier: "SearchTableViewCell", cellType: SearchTableViewCell.self)) { _, movie, cell in
                cell.configure(with: movie)
            }.disposed(by: disposeBag)
    }
    
    //MARK: - Detail screen
    
    private func toDetailScreen() {
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        tableView.rx.modelSelected(Media.self).subscribe { result in
            if let detailVC = storybord.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController { detailVC.detailsViewModel = DetailsViewModel(movie: result.element!)
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }.disposed(by: disposeBag)
        
    }
    private func setup() {

        tableView.backgroundColor = UIColor(displayP3Red: 234/255, green: 187/255, blue: 66/255, alpha: 1)
        
    }
}
