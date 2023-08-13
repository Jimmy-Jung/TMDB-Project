//
//  ViewController.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/11.
//

import UIKit

final class MovieViewController: UIViewController {
    private let titleText = "TMDB"
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    private var movieList: [MovieInfo] = []
    private let networkManager = TMDBNetworkManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        configBackBarButton(title: nil)
        setupCollectionView()
        configCollectionView()
        callRequest()
    }
    
    private func callRequest() {
        networkManager.requestTrending(period: .week) { [weak self] list in
            self?.movieList.append(contentsOf: list)
            self?.movieCollectionView.reloadData()
        }
    }
    
    private func setupCollectionView() {
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        let nib = UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil)
        movieCollectionView.register(nib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    }
    
    private func configCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let inset: CGFloat = 40
        let width = UIScreen.main.bounds.width - (inset * 2)
        layout.itemSize = CGSize(width: width, height: width * (4/3))
        layout.sectionInset = UIEdgeInsets(
            top: 10,
            left: inset,
            bottom: inset,
            right: inset
        )
        movieCollectionView.collectionViewLayout = layout
        layout.minimumInteritemSpacing = inset
        layout.minimumLineSpacing = inset
        layout.scrollDirection = .vertical
        movieCollectionView.collectionViewLayout = layout
    }
}

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        cell.movieInfo = movieList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: CreditViewController.identifier) as! CreditViewController
        vc.movieInfo = movieList[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MovieCollectionReusableView.identifier, for: indexPath) as! MovieCollectionReusableView
        headerView.titleLabel.text = "#Week Trending"
        return headerView
    }
}
extension MovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int)
    -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 48)
    }
}
