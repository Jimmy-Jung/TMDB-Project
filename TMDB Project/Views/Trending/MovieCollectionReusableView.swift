//
//  MovieCollectionReusableView.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/13.
//

import UIKit
import JimmyKit

class MovieCollectionReusableView: UICollectionReusableView {

    let titleLabel: UILabel = UILabel()
        .font(.systemFont(ofSize: 17))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubView(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(30)
            make.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
