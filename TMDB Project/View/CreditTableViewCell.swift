//
//  CreditTableViewCell.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/13.
//

import UIKit
import Kingfisher

final class CreditTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    private let retryStrategy = DelayRetryStrategy(maxRetryCount: 2, retryInterval: .seconds(3))
    var cast: Cast? {
        didSet {
            guard let cast else { return }
            nameLabel.text = cast.name
            secondaryLabel.text = cast.character
            let url = TMDB_API.imageURL(
                width: 200,
                path: cast.profile_path ?? ""
            )
            profileImageView.kf.setImage(
                with: url,
                placeholder: UIImage.noProfileImage,
                options: [
                    .retryStrategy(retryStrategy),
                    .transition(.fade(0.5))
                ]
            )
        }
    }
    var crew: Cast? {
        didSet {
            guard let crew else { return }
            nameLabel.text = crew.name
            secondaryLabel.text = crew.department
            let url = TMDB_API.imageURL(
                width: 200,
                path: crew.profile_path ?? ""
            )
            profileImageView.kf.setImage(
                with: url,
                placeholder: UIImage.noProfileImage,
                options: [
                    .retryStrategy(retryStrategy),
                    .transition(.fade(0.5))
                ]
            )
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 10
        profileImageView.layer.masksToBounds = true
    }
    
}
