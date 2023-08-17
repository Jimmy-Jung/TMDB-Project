//
//  OverViewTableViewCell.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/17.
//

import UIKit

final class OverViewTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    var buttonToggle = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionLabel.numberOfLines = 2
        moreButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        moreButton.isEnabled = false
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if buttonToggle {
            descriptionLabel.numberOfLines = 2
            moreButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        } else {
            descriptionLabel.numberOfLines = 0
            moreButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        }
        buttonToggle.toggle()
    }

}
