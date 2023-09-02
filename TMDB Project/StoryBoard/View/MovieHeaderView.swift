//
//  MovieHeaderView.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/13.
//

import UIKit

class MovieHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var descriptionLabel: UILabel!
   
    static let reuseIdentifier: String = String(describing: MovieHeaderView.self)

        static var nib: UINib {
            return UINib(nibName: String(describing: self), bundle: nil)
        }

    
    @IBAction func moreButtonTapped(_ sender: UIButton) {
    }
    
}
