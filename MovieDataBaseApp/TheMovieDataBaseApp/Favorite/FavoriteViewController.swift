//
//  FavoriteViewController.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 02.02.2023.
//

import UIKit
import RxSwift
import RxCocoa

class FavoriteViewController: UIViewController {

    let favoriteViewModel = FavoriteViewModel()
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        favViewModel()
        setupObserve()
        toDetailsScreen()
    }
    
    func favViewModel() {
        segmentController.rx
            .selectedSegmentIndex
            .values
            .asObservable().subscribe { [weak self] segmentPosition in
                switch segmentPosition.element {
                case 0: self?.favoriteViewModel.swichType = .movies
                    self?.favoriteViewModel.favList()
                case 1: self?.favoriteViewModel.swichType = .tv
                    self?.favoriteViewModel.favList()
                default: break
                }
            }.disposed(by: disposeBag)
        
        tableView.rx
            .modelDeleted(Media.self)
            .subscribe { [weak self] res in
                self?.favoriteViewModel.updateFav(mediaID: res.element?.id ?? 0, complition: { [weak self] responce in
                    self?.favoriteViewModel.favList()
                })
            }.disposed(by: disposeBag)
    }

    func setupObserve() {
        favoriteViewModel.favList()
        favoriteViewModel.content.drive(tableView.rx.items(cellIdentifier: "FavoriteTableViewCell", cellType: FavoriteTableViewCell.self)) { _, media, cell in
            cell.configure(media: media)
        }.disposed(by: disposeBag)
    }
  
    private func toDetailsScreen() {
       let storybord = UIStoryboard(name: "Main", bundle: nil)
        tableView.rx.modelSelected(Media.self).subscribe { result in
            if let detailVC = storybord.instantiateViewController(identifier: "DetailsViewController") as?
                DetailsViewController {
                detailVC.detailsViewModel = DetailsViewModel(movie: result.element!)
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }.disposed(by: disposeBag)
    }
    
    private func setup() {
        tableView.backgroundColor = UIColor(displayP3Red: 234/255, green: 187/255, blue: 66/255, alpha: 1)
    }

}
