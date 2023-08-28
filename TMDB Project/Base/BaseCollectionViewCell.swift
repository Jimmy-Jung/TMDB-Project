//
//  BaseCollectionViewCell.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/28.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurationView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurationView() { }
    func setConstraints() { }
    
}
