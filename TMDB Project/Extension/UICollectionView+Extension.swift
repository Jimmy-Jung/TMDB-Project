//
//  UICollectionView+Extension.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/20.
//

import UIKit

extension UICollectionView {
    static func getCollectionViewFlowLayout(
        numberOfRows: Int,
        itemRatio: CGFloat,
        spacing: CGFloat,
        inset: CGFloat,
        scrollDirection: UICollectionView.ScrollDirection
    ) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - (spacing * CGFloat(numberOfRows - 1)) - (inset * 2)
        layout.itemSize = CGSize(width: width/CGFloat(numberOfRows), height: (width/CGFloat(numberOfRows)) * itemRatio)
        layout.sectionInset = UIEdgeInsets(
            top: 10,
            left: inset,
            bottom: inset,
            right: inset
        )
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = scrollDirection
        return layout
    }

}
