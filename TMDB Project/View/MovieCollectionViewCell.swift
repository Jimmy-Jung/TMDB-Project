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
    @IBOutlet private weak var originalTitleLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    
    @IBOutlet weak var rateStackView: UIStackView!
    @IBOutlet weak var bottomView: UIView!
    var movieInfo: MovieInfo? {
        didSet {
            titleLabel.text = movieInfo?.title
            originalTitleLabel.text = movieInfo?.originalTitle
            rateLabel.text = String(format: "%.1f", movieInfo?.voteAverage ?? 0)
            guard let path = movieInfo?.posterPath else {
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
    
    func hideViews() {
        rateStackView.isHidden = true
        bottomView.isHidden = true
    }
    private func makeShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.label.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 2, height: 2)
    }
    
    @IBAction private func clipButtonTapped(_ sender: Any) {
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13, *), self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            layer.shadowColor = UIColor.label.cgColor
            }
    }

}
