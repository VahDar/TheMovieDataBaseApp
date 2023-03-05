//
//  GenresViewController.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 23.01.2023.
//
import RxSwift
import RxCocoa
import RxDataSources
import UIKit
import SDWebImage

class GenresViewController: ViewController {
    
    var disposeBag = DisposeBag()
    let viewModel = GenresViewModel()
    
    @IBOutlet weak var segmentalController: UISegmentedControl!
    
    @IBOutlet weak var mainGenreTableView: UITableView! {
        didSet {
            mainGenreTableView.register(UINib(nibName: "GenresTableViewllerCell", bundle: nil), forCellReuseIdentifier: "GenresTableViewllerCellID")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainGenreTableView.rowHeight = 200
        dataTable()
        setupUITabBAr()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        mainGenreTableView.setContentOffset(.zero, animated: true)
    }
    
    func dataTable() {
        Task {
            try await self.viewModel.movieGenres()
        }
                self.viewModel.sourceDataTableView
                    .switchLatest()
                    .asDriver(onErrorJustReturn: [])
                    .drive(self.mainGenreTableView.rx.items(cellIdentifier: "GenresTableViewllerCellID", cellType: GenresTableViewllerCell.self)) { _, genre, cell in
                        Task {
                            try await cell.configureCell(genre, self.segmentalController.selectedSegmentIndex)
                        }
                }.disposed(by: self.disposeBag)

            segmentalController.rx.value.asDriver().drive { position in
                    switch position {
                    case 0: GenresViewModel.positionSegmental = .movie
                        Task {
                            try await self.viewModel.movieGenres()
                        }
                        GenresViewModel.positionSegmental = .movie
                    case 1: GenresViewModel.positionSegmental = .tv
                        Task {
                            try await self.viewModel.tvGenres()
                        }
                        GenresViewModel.positionSegmental = .tv
                    default: fatalError("error")
                    }
                }.disposed(by: disposeBag)
          
        }
    
    
    func setupUITabBAr() {
        UITabBar.appearance().barTintColor = UIColor(displayP3Red: 232/255, green: 187/255, blue: 67/255, alpha: 0.7)
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 232/255, green: 187/255, blue: 67/255, alpha: 0.7)
    }
    
    }

