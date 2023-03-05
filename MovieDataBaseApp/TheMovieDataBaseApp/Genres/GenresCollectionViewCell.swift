//
//  GenresCollectionViewCell.swift
//  TheMovieDataBaseApp
//
//  Created by Vakhtang on 23.01.2023.
//

import UIKit
import SDWebImage

class GenresCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewCollectionView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gonfigureImage()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }

    func configere(_ genresMovie: Media) {
        let transformer = SDImageResizingTransformer(size: CGSize(width: 150, height: 200), scaleMode: .fill)
        posterImageView.sd_setImage(with: URL(string: GenresUrl.imagePoster.rawValue + (genresMovie.posterPath ?? "")), placeholderImage: nil, context: [.imageTransformer: transformer])
    }
        
    
    func gonfigureImage() {
        viewCollectionView.layer.cornerRadius = 25
        imageView.layer.cornerRadius = 25
    }
}

