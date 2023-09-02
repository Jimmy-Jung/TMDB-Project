//
//  RecommendTableViewCell.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/17.
//

import UIKit

class RecommendTableViewCell: UITableViewCell {

    @IBOutlet weak var recommendCollectionView: UICollectionView!
    var movieInfo: [MovieInfo]? {
        didSet {
            recommendCollectionView.reloadData()
        }
    }
    var delegate: Pushable?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
        configureCollectionViewLayout()
    }
}

extension RecommendTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieInfo?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        cell.movieInfo = self.movieInfo?[indexPath.row]
        cell.hideViews()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieInfo else {return}
        delegate?.pushNavigation(movieInfo: movieInfo[indexPath.item])
    }
}

extension RecommendTableViewCell: CollectionViewAttributeProtocol {
    func configureCollectionView() {
        recommendCollectionView.delegate = self
        recommendCollectionView.dataSource = self
        let cellNib = UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil)
        recommendCollectionView.register(cellNib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let inset: CGFloat = 20
        let spacing: CGFloat = 20
        let width = (UIScreen.main.bounds.width - (inset * 4)) / 2
        layout.itemSize = CGSize(width: width, height: width * (4/3))
        layout.sectionInset = UIEdgeInsets(
            top: spacing,
            left: inset,
            bottom: spacing,
            right: inset
        )
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .horizontal
        recommendCollectionView.collectionViewLayout = layout
    }
}
