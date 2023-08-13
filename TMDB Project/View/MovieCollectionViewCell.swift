//
//  MovieCollectionViewCell.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/11.
//

import UIKit
import Kingfisher

final class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    
    var movieInfo: MovieInfo? {
        didSet {
            titleLabel.text = movieInfo?.title
            rateLabel.text = String(format: "%.1f", movieInfo?.vote_average ?? 0)
            guard let path = movieInfo?.poster_path else {
                imageView.image = UIImage.noPosterImage
                return
            }
            let url = TMDB_API.imageURL(
                width: 300,
                path: path
            )
            self.imageView.kf.setImage(with: url)
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage.noPosterImage
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 20
        backView.layer.masksToBounds = true
        makeShadow()
    }
    
    private func makeShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.label.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 12
        layer.shadowOffset = CGSize(width: 4, height: 4)
    }
    
    @IBAction private func clipButtonTapped(_ sender: Any) {
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13, *), self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            layer.shadowColor = UIColor.label.cgColor
            }
    }

}
