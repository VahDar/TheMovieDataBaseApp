//
//  DetailsViewController.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 26.01.2023.
//

import RxSwift
import UIKit
import RxCocoa
import SDWebImage
import youtube_ios_player_helper

class DetailsViewController: ViewController {
    
  private let disposeBag = DisposeBag()
    var detailsViewModel: DetailsViewModel?
    
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var textViewOverview: UITextView!
    @IBOutlet weak var videoNameLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
   
    @IBOutlet weak var trailerPlayer: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }
    
    private func configure() {
        guard let detailsViewModel = detailsViewModel else {return}
        videoNameLabel.text = (detailsViewModel.movie.title ?? "")
        textViewOverview.text = (detailsViewModel.movie.overview)
        rateLabel.text = "\(detailsViewModel.movie.voteAverage)"
        posterImage.layer.cornerRadius = 20
        posterImage.sd_setImage(with: URL(string: (GenresUrl.imagePoster.rawValue + (detailsViewModel.movie.posterPath ?? ""))), completed: nil)
        detailsViewModel.video.drive() { [weak self] result in
            guard let self = self else {return}
            self.trailerPlayer.load(withVideoId: result)
        }.disposed(by: disposeBag)

    }

    
    @IBAction func addToFavoriteButton(_ sender: Any) {
        
        detailsViewModel?.updateFavorite(add: true, complition: { favoriteResponce in
            DispatchQueue.main.async {
                let uiAlert = UIAlertController(title: "Favorites", message: favoriteResponce.statusMessage,
                                                preferredStyle: UIAlertController
                                                .Style.alert)
                uiAlert.addAction(UIAlertAction(title: "Complite",
                                                style: UIAlertAction
                                                .Style.default, handler: nil))
                self.present(uiAlert, animated: true, completion: nil)
            }
        })
    }
    
    
    
}
