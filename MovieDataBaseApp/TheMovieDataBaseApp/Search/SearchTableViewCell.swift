//
//  SearchTableViewCell.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 29.01.2023.
//

import UIKit
import SDWebImage

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var videoNameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImage()
    }

    func configure(with movie: Media) {
        posterImage.sd_setImage(with: URL(string: GenresUrl.imagePoster.rawValue + (movie.posterPath ?? "")), completed: nil)
       
        videoNameLabel.text = movie.title
        overviewLabel.text = movie.overview
   }
    
    private func setupImage() {
        posterImage.layer.cornerRadius = 25
    }
}
