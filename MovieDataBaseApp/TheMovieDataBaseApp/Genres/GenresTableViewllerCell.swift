//
//  GenresTableViewllerCell.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 23.01.2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class GenresTableViewllerCell: UITableViewCell {
    let disposeBag = DisposeBag()
    
//    let dataSource = RxCollectionViewSectionedAnimatedDataSource<GenreAnimatedSectionModel> {_, collectionView, indexPath, item in
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenresCollectionID",
//                                                      for: indexPath) as! GenresCollectionViewCell
//        cell.configere(item)
//        return cell
//    }
    var dataSource = RxCollectionViewSectionedReloadDataSource<GenreAnimatedSectionModel> { _, collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenresCollectionID",
                                                      for: indexPath) as! GenresCollectionViewCell
        cell.configere(item)
        return cell
    }

    let viewModel = GenresViewModel()
    
    @IBOutlet weak var genreColectionView: UICollectionView! {
        didSet {
            genreColectionView.register(UINib(nibName: "GenresCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GenresCollectionID")
        }
    }
    @IBOutlet weak var genreLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       observers()
        openDetailScreen()
    }

    func observers() {
        viewModel.data
            .asDriver()
            .drive(genreColectionView.rx
                .items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func configureCell(_ genre: Genre, _ segmentControll: Int) async throws {
        genreLable.text = genre.name
        
        switch segmentControll {
        case 0: try await viewModel.getMovieByGenre(genre: genre.id)
        case 1: try await viewModel.getTVByGenre(genre: genre.id)
        default: fatalError("error")
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: - open Datails screen and send data
    
    func openDetailScreen() {
 
        genreColectionView.rx.modelSelected(Media.self)
            .subscribe { character in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let detailVC = storyboard.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController
            detailVC?.detailsViewModel = DetailsViewModel(movie: character.element!)
            self.parentViewController?.navigationController?.pushViewController(detailVC!, animated: true)
        }
        .disposed(by: disposeBag)
        
    }
}



// MARK: - Add ability for navigation from cells
extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
