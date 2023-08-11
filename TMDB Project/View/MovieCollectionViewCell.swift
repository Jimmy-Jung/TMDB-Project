//
//  MovieCollectionViewCell.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/11.
//

import UIKit
import Kingfisher

final class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    var movieInfo: MovieInfo? {
        didSet {
            guard let path = movieInfo?.posterPath else {
                imageView.image = UIImage(named: "noPoster")
                return
            }
            let url = TMDB_API.imageURL(
                width: Int(imageView.frame.width),
                path: path
            )
            self.imageView.kf.setImage(with: url)
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage(named: "noPoster")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 10
        backView.clipsToBounds = true
    }
    
    @IBAction func clipButtonTapped(_ sender: Any) {
    }
    

}
