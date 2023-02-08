//
//  FavoriteTableViewCell.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 02.02.2023.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var titelNameLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func configure(media: Media) {
        titelNameLabel.text = (media.name ?? "") + (media.title ?? "")
        posterImageView.sd_setImage(with: URL(string: GenresUrl.imagePoster.rawValue + (media.posterPath ?? "")), completed: nil)
        rateLabel.text = "\(media.voteAverage)"
        overviewLabel.text = media.overview
    }
    
    
    func setup() {
        posterImageView.layer.cornerRadius = 17
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
